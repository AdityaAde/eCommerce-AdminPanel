// ignore_for_file: depend_on_referenced_packages

import 'package:backend_getx/controller/order_stats_controller.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:backend_getx/models/order_stats_models.dart';
import 'package:backend_getx/screen/orders_screen.dart';
import 'package:backend_getx/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final OrderStatsController orderStatsController = Get.put(OrderStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My eCommerce'),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Add Charts Here
          FutureBuilder(
            future: orderStatsController.stats.value,
            builder: (context, AsyncSnapshot<List<OrderStats>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 250,
                  padding: const EdgeInsets.all(10),
                  child: CustomBarChart(
                    orderStats: snapshot.data!,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: InkWell(
              onTap: () {
                Get.to(() => ProductScreen());
              },
              child: const Card(
                child: Center(child: Text('Go To Products')),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: InkWell(
              onTap: () {
                Get.to(() => OrdersScreen());
              },
              child: const Card(
                child: Center(child: Text('Go To Orders')),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class CustomBarChart extends StatelessWidget {
  final List<OrderStats> orderStats;
  const CustomBarChart({Key? key, required this.orderStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
        id: 'orders',
        data: orderStats,
        domainFn: (series, _) => DateFormat.d().format(series.dateTime),
        measureFn: (series, _) => series.orders,
        colorFn: (series, _) => series.barColor!,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
