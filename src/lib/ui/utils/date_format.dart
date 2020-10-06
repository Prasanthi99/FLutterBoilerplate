extension DateTimeExtension on DateTime {
  String get timeAgo {
    var time = "";
    var now = DateTime.now();
    var diff = DateTime.now().difference(this).inMinutes;
    if (diff == 0) {
      return "Just Now";
    } else if (diff < 60) {
      return "${diff} ${diff == 1 ? 'minute ago' : 'minutes ago'}";
    } else if (diff < 60 * 24) {
      var hours = (diff / 60).round();
      return "${hours.toString()} ${hours == 1 ? 'hour ago' : 'hours ago'}";
    } else if (diff < 60 * 24 * 2) {
      return "Yesterday";
    }
    return "${DateTime.now().difference(this).inDays} days ago";
  }

  String get suffix {
    var suffix = "th";
    var digit = this.day % 10;
    if ((digit > 0 && digit < 4) && (this.day < 11 || this.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return suffix;
  }
}
