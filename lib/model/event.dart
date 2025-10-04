class Event {
  static const String collectionName = 'Events';
  String id;
  String image;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;
  Event({
    this.id = '',
    required this.image,
    required this.title,
    required this.description,
    required this.eventName,
    required this.dateTime,
    required this.time,
    this.isFavorite = false,
  });

  Event.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'] ?? '',
        image: json['image'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        eventName: json['eventName'] ?? '',
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
        time: json['time'] ?? '',
        isFavorite: json['isFavorite'] ?? false,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'eventName': eventName,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      'isFavorite': isFavorite,
    };
  }
}
