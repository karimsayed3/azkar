class DetailsScreenModel {
  int? section_id;
  String? count;
  String? description;
  String? reference;
  String? content;

  DetailsScreenModel({
    this.section_id,
    this.count,
    this.description,
    this.reference,
    this.content,
  });

  DetailsScreenModel.fromJson(Map<String, dynamic> json) {
    section_id = json['section_id'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    content = json['content'];
  }
}
