import 'package:ostad_crafty_bay/presentation/state_holders/payment_controller/invoice_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {

  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     Get.find<InvoiceListController>().getInvoiceList();
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<InvoiceListController>(
          builder: (_invoiceListController) {
            if(_invoiceListController.isInvoiceListInProgress){
              return Center(child: CircularProgressIndicator());
            }else if(_invoiceListController.invoiceList != null && _invoiceListController.invoiceList.isEmpty){
              return Center(child: Text("Empty"));
            }
            return ListView.separated(
              itemCount: _invoiceListController.invoiceList.length,
                itemBuilder: (context,index){
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Total taka: ${_invoiceListController.invoiceList.first.total ?? ''}tk",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text("Vat: ${_invoiceListController.invoiceList.first.vat ?? ''}tk",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: 180, child: Divider(thickness: 1,)),
                        Text("Total + Vat: ${_invoiceListController.invoiceList.first.payable ?? ''}tk",
                          style: TextStyle(
                            fontSize: 18,
                          fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                        ),),
                        Divider(thickness: 3,),
                        Text(_invoiceListController.invoiceList.first.shipDetails ?? '')
                      ],
                    ),
                  ),
                );
                },
                separatorBuilder: (context,index)=> const Divider(), );
          }
        ),
      )
    );
  }
}
