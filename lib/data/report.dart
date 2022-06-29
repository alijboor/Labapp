// ignore_for_file: non_constant_identifier_names

class Report {
  final int id;
  final String name;
  final String descr;
  final String name_of_patient;
  final int nation_id;

  Report(this.id, this.name, this.descr, this.name_of_patient, this.nation_id);

  factory Report.forMap(Map<String, dynamic> json) {
    return Report(json[0], json[1], json[2], json[3], json[4]);
  }

  static fromMap(json) {}
}
