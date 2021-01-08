class HESCode {
  static const hesCodeName = "name";
  static const hesCodeId = "id";

  String name;
  String id;

  HESCode({
    this.name,
    this.id,
  });

  HESCode.fromMap(Map<String, dynamic> map) {
    name = map[hesCodeName];
    id = map[hesCodeId];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{hesCodeName: name, hesCodeId: id};
    if (id != null) map[hesCodeId] = id;
    return map;
  }
}
