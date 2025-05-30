import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_tagxi/l10n/app_localizations.dart';

import '../../../../../../common/common.dart';
import '../../../../application/acc_bloc.dart';
import '../../../widgets/top_bar.dart';
import '../widget/chat_history_widget.dart';

class AdminChat extends StatelessWidget {
  static const String routeName = '/adminchat';
  final AdminChatPageArguments arg;
  const AdminChat({super.key, required this.arg});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AccBloc()
      ..add(AdminChatInitEvent(arg: arg)),
      child: BlocListener<AccBloc, AccState>(
        listener: (context, state) {
          if (state is SendAdminMessageSuccessState) {
            context.read<AccBloc>().add(GetAdminChatHistoryListEvent());
          }
        },
        child: BlocBuilder<AccBloc, AccState>(builder: (context, state) {
          return Scaffold(
            body: TopBarDesign(
              icon:  Icon(Icons.chat,color: Theme.of(context).disabledColor,),
              isHistoryPage: false,
              title: AppLocalizations.of(context)!.adminChat,
              onTap: () {
                Navigator.of(context).pop();
                context.read<AccBloc>().chatStream!.cancel();
              },
              controller: context.read<AccBloc>().scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ChatHistoryWidget(
                        cont :context,adminChatList:  context.read<AccBloc>().adminChatList),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.fromLTRB(
                  10, 10, 10, MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: size.width * 0.9,
                margin: EdgeInsets.only(bottom: size.width * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: Theme.of(context).disabledColor.withOpacity(0.6), 
                       width: 0.6),
                  color: Theme.of(context).cardColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextField(
                          controller: context.read<AccBloc>().adminchatText,
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context)!.typeMessage,
                          ),
                          minLines: 1,
                          maxLines: 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (context
                              .read<AccBloc>()
                              .adminchatText
                              .text
                              .isNotEmpty) {
                            context.read<AccBloc>().add(
                                  SendAdminMessageEvent(
                                    newChat: context
                                            .read<AccBloc>()
                                            .adminChatList
                                            .isEmpty
                                        ? '0'
                                        : '1',
                                    message: context
                                        .read<AccBloc>()
                                        .adminchatText
                                        .text,
                                    chatId: context
                                            .read<AccBloc>()
                                            .adminChatList
                                            .isEmpty
                                        ? ""
                                        : context
                                            .read<AccBloc>()
                                            .adminChatList[0]
                                            .conversationId,
                                  ),
                                );
                            context.read<AccBloc>().adminchatText.clear();
                          }
                        },
                        child: Icon(
                          Icons.send,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
