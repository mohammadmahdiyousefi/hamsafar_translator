class UpdateModel {
  final String version;
  final String url;
  final String body;

  UpdateModel({
    required this.version,
    required this.url,
    required this.body,
  });

  factory UpdateModel.fromJson(Map<String, dynamic> json) {
    return UpdateModel(
      version: json['tag_name'],
      url: json['assets'][0]['browser_download_url'],
      body: json['body'],
    );
  }
}
