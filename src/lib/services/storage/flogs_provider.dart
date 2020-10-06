import 'package:f_logs/model/flog/flog.dart';
import 'package:f_logs/model/flog/log.dart';
import 'package:f_logs/model/flog/log_level.dart';

class LoggerService {
  void Error(String screen, String method, String text) {
    FLog.error(className: screen, methodName: method, text: text);
  }

  void ExceptionLog(String screen, String method, String text, Exception e) {
    FLog.logThis(
        className: screen,
        methodName: method,
        text: text,
        type: LogLevel.SEVERE,
        exception: e);
  }

  Future<List<Log>> GetAllLogs() async {
    FLog.exportLogs();
    var data = await FLog.getAllLogs();
    return data;
  }

  void ClearLogs() {
    FLog.clearLogs();
  }

  void Info(String screen, String method, String text) async {
    var logs = await this.GetAllLogs();
    if (logs != null && logs.length > 10) {
      this.ClearLogs();
    }
    FLog.info(className: screen, methodName: method, text: text);
  }

  void Severe(String screen, String method, String text) {
    FLog.info(className: screen, methodName: method, text: text);
  }

  void Warning(String screen, String method, String text) {
    FLog.warning(className: screen, methodName: method, text: text);
  }
}
