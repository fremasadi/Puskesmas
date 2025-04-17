import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/queue_controller.dart';

class QueueView extends GetView<QueueController> {
  const QueueView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QueueView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QueueView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
