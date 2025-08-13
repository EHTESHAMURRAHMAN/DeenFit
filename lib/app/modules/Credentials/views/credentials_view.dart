import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/credentials_controller.dart';

class CredentialsView extends GetView<CredentialsController> {
  const CredentialsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CredentialsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CredentialsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
