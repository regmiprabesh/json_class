class Description {
  String desc1;
  String desc2;

  Description.fromJson(Map<String, dynamic> json)
      : desc1 = json['desc1'],
        desc2 = json['desc2'];
}
