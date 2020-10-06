import 'package:f_logs/f_logs.dart';
import 'package:boilerplate/models/app_serializer.dart';
import 'package:boilerplate/models/core/base_model.dart';
import 'package:boilerplate/services/storage/flogs_provider.dart';

class LoggerModel extends BaseModel {
  List<Log> logs = new List<Log>();
  LoggerService _loggingContract;

  LoggerModel(LoggerService loggerContract) {
    this._loggingContract = loggerContract;
  }
  Future<void> getAll() async {
    this.logs = await this._loggingContract.GetAllLogs();
    if (this.logs != null) {
      this.logs = this.logs.reversed.toList();
      this.logs =
          this.logs.length > 10 ? this.logs.take(10).toList() : this.logs;
    }
    notifyListeners();
  }

  void clearAll() {
    this._loggingContract.ClearLogs();
    this.logs = new List<Log>();
    notifyListeners();
  }
}
