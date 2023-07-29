import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/ChequeNotif/chequeNotif_bloc.dart';
import 'package:chequeproject/blocs/ChequeNotif/chequeNotif_event.dart';
import 'package:chequeproject/blocs/ChequeNotif/chequeNotif_state.dart';
import 'package:chequeproject/models/cheque_notif.dart';
import 'package:gmsoft_pkg/config/global_params.dart'; 
import 'package:chequeproject/widgets/notif_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmsoft_pkg/error_with_refresh_button_widget.dart'; 
import 'package:lottie/lottie.dart';

class NotificationView extends StatelessWidget {
  static String Route = '/notification';

  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ChequeNotifBloc()..add(LoadChequesNotifEvent()),
      child: _NotificationHome(
        size: size,
      ),
    );
  }
}

class _NotificationHome extends StatelessWidget {
  _NotificationHome({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) { 
    return SafeArea(
        child: Scaffold(
      backgroundColor: GlobalParams.backgroundColor,
      appBar: AppBar(
        title: const Text('Notification'),
        elevation: 0,
        backgroundColor: GlobalParams.GlobalColor,
      ),
      body: NotifBody(size: size),
    ));
  }
}

class NotifBody extends StatelessWidget {
  NotifBody({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  int index = 1;

  @override
  Widget build(BuildContext context) { 
    return Material(
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChequeNotifBloc, ChequeNotifState>(
                  builder: (context, state) {
                if (state.requestState == ChequeNotifRequestState.Loading) {
                  return SizedBox(
                    height: size.height * 0.5,
                    child: Center(
                      child: Lottie.asset('assets/loader.json'),
                    ),
                  );
                } else if (state.requestState ==
                    ChequeNotifRequestState.Loaded) {
                  List<ChequeNotif>? chequeNotifList =
                      state.requestState == ChequeNotifRequestState.Loaded
                          ? state.data
                          : state.search_result;
                  return Container(
                    height: size.height * 0.78,
                    padding: EdgeInsets.only(
                        top: GlobalParams.MainPadding / 2,
                        left: GlobalParams.MainPadding / 3,
                        right: GlobalParams.MainPadding / 4),
                    child: ListView.builder(
                      itemCount: chequeNotifList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var currentItem = chequeNotifList![index];
                        return NotificationCard(
                          title: currentItem.title ?? "",
                          time: currentItem.date ?? "",
                          subtitle: currentItem.message ?? "",
                          isRead: false,
                        );
                      },
                    ),
                  );
                }
                return ErrorWithRefreshButtonWidget(
                  button_function: () {
                    BlocProvider.of<ChequeNotifBloc>(context)
                        .add(LoadChequesNotifEvent());
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
