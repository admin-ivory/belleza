
class AddBusinessModel {
  int? id;
  String? cateId;
  String? cateName;
  String? name;
  String? businessName;
  String? instagramLink;
  String? whatsappNumber;
  String? email;
  bool? haveShop;
  int? status;
  bool? isChecked;
  List<Categories>? categories;

  AddBusinessModel({this.id, this.cateId, this.name, this.businessName, this.email, this.haveShop, this.status, this.categories, this.isChecked});

  AddBusinessModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    cateId = json['cate_id'];
    name = json['first_name'];
    businessName = json['business_name'];
    whatsappNumber = json['whatsapp_number'];
    instagramLink = json['instagram_link'];
    email = json['email'];
    haveShop = json['have_shop'];
    isChecked = json['isChecked'];
    status = int.parse(json['status'].toString());
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cate_id'] = cateId;
    data['first_name'] = name;
    data['business_name'] = businessName;
    data['whatsapp_number'] = whatsappNumber;
    data['instagram_link'] = instagramLink;
    data['email'] = email;
    data['have_shop'] = haveShop;
    data['isChecked'] = isChecked;
    data['status'] = status;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? cover;
  bool? isChecked = false;
  int? status;


  Categories({this.id, this.name, this.isChecked, this.status, this.cover});

  Categories.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    isChecked = json['isChecked'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['isChecked'] = isChecked;
    data['status'] = status;
    return data;
  }
}
