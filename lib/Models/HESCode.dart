class HESCode {
  static const tblHesCode = "HesCode";
  static const colid = "id";
  static const colName = "name";
  static const colhesCodeId = "hescode";

  int id;
  String name;
  String hescode;

  HESCode({
    this.id,
    this.name,
    this.hescode,
  });

  HESCode.fromMap(Map<String, dynamic> map) {
    id = map[colid];
    name = map[colName];
    hescode = map[colhesCodeId];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colName: name, colhesCodeId: hescode};
    if (id != null) map[colid] = id;
    return map;
  }
}
