class UserData {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

class UserDataList {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserData> data;

  UserDataList({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UserDataList.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<UserData> userData =
        dataList.map((item) => UserData.fromJson(item)).toList();

    return UserDataList(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: userData,
    );
  }
}
