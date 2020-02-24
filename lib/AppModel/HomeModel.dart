class HomeModel {
  String title;
  String price;
  String imageUrl;
  String location;

  HomeModel({this.title, this.price, this.imageUrl, this.location});

  HomeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    data['location'] = this.location;
    return data;
  }
}