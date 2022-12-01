import "dart:convert";

class Task {
  DateTime dateTime;
  String text;
  bool isDone = false;
  final int _id;

  Task(this.dateTime, this.text, this._id);

  factory Task.fromJson(String jsonString){
    var decodedJson = json.decode(jsonString);
    var date = DateTime.parse(decodedJson["date"]!);
    var buffer = Task(date, decodedJson["text"]!, int.parse(decodedJson["id"]!));
    buffer.isDone = decodedJson["isDone"]! == "true";
    return buffer;
  }

  void changeStatus() => isDone = isDone;

  int get id => _id;

  bool _isOverdue() {
    return DateTime.now().isAfter(dateTime);
  }

  bool getStatus() {
    return isDone || !_isOverdue();
  }

  String getStatusString() {
    if (_isOverdue()) {
      return 'was due ${-dateTime
          .difference(DateTime.now())
          .inDays} days ago';
    } else {
      return 'is due in ${dateTime
          .difference(DateTime.now())
          .inDays} days';
    }
  }

  @override
  String toString() {
    return text;
  }

  Map<String, String> toJsonDict() {
    return {
      "isDone": isDone.toString(),
      "date": dateTime.toString(),
      "text": text,
      "id": id.toString()
    };
  }
}
