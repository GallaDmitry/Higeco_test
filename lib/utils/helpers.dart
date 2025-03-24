class Helpers {
  static String timestampToDateTime(int timestamp) {
    if (timestamp == 0 || timestamp.runtimeType != int) return 'N/A';
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(2,4)}';
  }
}