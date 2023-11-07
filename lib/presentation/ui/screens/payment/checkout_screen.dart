import 'package:ostad_crafty_bay/data/models/payment/payment_method.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/payment_controller/create_invoice_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/payment/web_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  bool isCompleted = false;
  @override
  void initState() {
    super.initState();
    Get.find<CreateInvoiceController>().createInvoice().then((value) {
      isCompleted = value;
     if(mounted){
       setState(() {});
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout Screen"),
      ),
      body: GetBuilder<CreateInvoiceController>(
        builder: (_createInvoiceController) {
          if(_createInvoiceController.isCreateInvoiceInProgress){
            return const Center(child: CircularProgressIndicator());
          }
          if(!isCompleted){
            return const Center(child: Text('Completed your profile first'));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemCount: _createInvoiceController.invoiceCreateResponseModel.data?.first.paymentMethod?.length ?? 0,
                itemBuilder: (context,index){
                final PaymentMethod? _paymentMethod = _createInvoiceController.invoiceCreateResponseModel.data?.first.paymentMethod![index];
                return ListTile(
                  onTap: (){
                    Get.off(()=> WebViewScreen(paymentUrl: _paymentMethod!.redirectGatewayURL!));
                  },
                  leading: Image.network(_paymentMethod?.logo ?? '',width: 60,),
                  title: Text(_paymentMethod?.name ?? ''),
                );
                },
              separatorBuilder: (context, index) => const Divider(
              thickness: 2,
            ),
          ),
          );
        }
      ),
    );
  }
}
