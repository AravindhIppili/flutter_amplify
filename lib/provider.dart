import 'package:aws_auth/services/auth.dart';
import 'package:riverpod/riverpod.dart';

final authUserProvider = FutureProvider<String>((ref) {
  final authAWSRepo = ref.watch(authAWSRepositoryProvider);
  return authAWSRepo.user.then((value) => value);
});