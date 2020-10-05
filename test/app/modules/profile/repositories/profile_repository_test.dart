import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:advice_hub/app/modules/profile/repositories/profile_repository.dart';

class MockClient extends Mock implements Dio {}

void main() {
  // ignore: unused_local_variable
  ProfileRepository repository;
  // MockClient client;

  setUp(() {
    // repository = ProfileRepository();
    // client = MockClient();
  });

  group('ProfileRepository Test', () {
    //  test("First Test", () {
    //    expect(repository, isInstanceOf<ProfileRepository>());
    //  });

    test('returns a Post if the http call completes successfully', () async {
      //    when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
      //        .thenAnswer((_) async =>
      //            Response(data: {'title': 'Test'}, statusCode: 200));
      //    Map<String, dynamic> data = await repository.fetchPost(client);
      //    expect(data['title'], 'Test');
    });
  });
}
