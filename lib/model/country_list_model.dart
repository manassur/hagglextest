class CountryListModel {
  Data? data;

  CountryListModel({this.data});

  CountryListModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<GetAllCountries>? countryList;

  Data({this.countryList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['getAllCountries'] != null) {
      countryList = <GetAllCountries>[];
      json['getAllCountries'].forEach((v) {
        countryList!.add(new GetAllCountries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countryList != null) {
      data['getAllCountries'] =
          this.countryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllCountries {
  String? sId;
  String? name;
  String? alpha2Code;
  String? flag;
  String? callingCode;

  GetAllCountries(
      {this.sId, this.name, this.alpha2Code, this.flag, this.callingCode});

  GetAllCountries.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    alpha2Code = json['alpha2Code'];
    flag = json['flag'];
    callingCode = json['callingCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['alpha2Code'] = this.alpha2Code;
    data['flag'] = this.flag;
    data['callingCode'] = this.callingCode;
    return data;
  }
}
