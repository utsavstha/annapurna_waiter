import 'package:annapurna/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider = ChangeNotifierProvider.autoDispose<AuthController>(
    (ref) => AuthController());
