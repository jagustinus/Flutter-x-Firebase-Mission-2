part of 'model.dart';

class Users extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String profilePic;

  Users(this.uid, this.email, {this.name, this.profilePic});

  @override
  List<Object> get props => [uid, email, name, profilePic];
}
