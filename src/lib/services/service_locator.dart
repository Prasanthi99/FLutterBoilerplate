import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:kiwi/kiwi.dart';
import 'package:boilerplate/models/app_constants.dart';
import 'package:boilerplate/models/app_serializer.dart';
import 'package:boilerplate/models/app_configuration.dart';
import 'package:boilerplate/models/core/app_context.dart';
import 'package:boilerplate/models/core/theme_context.dart';
import 'package:boilerplate/services/storage/flogs_provider.dart';
import 'package:boilerplate/services/storage/hive.dart';
import 'package:boilerplate/services/storage/secure_storage.dart';
import 'package:boilerplate/services/http/contracts/base_contract.dart';
import 'package:boilerplate/services/http/providers/auth_provider.dart';
import 'package:boilerplate/services/http/providers/base_provider.dart';
import 'package:boilerplate/models/core/base_model.dart';
import 'package:boilerplate/models/app_constants.dart';
import 'package:boilerplate/models/app_configuration.dart';
import 'package:boilerplate/services/storage/sqlflite.dart';
import 'package:boilerplate/ui/view_models/logger_model.dart';
import 'package:boilerplate/ui/view_models/login_model.dart';

class ServiceLocator {
  static KiwiContainer _container;
  static configure() {
    _container = KiwiContainer();

    _container.registerInstance(BaseModel());
    _container.registerFactory(((c) => LoginModel(c.resolve<LoggerService>())));
    _container
        .registerFactory((c) => LoggerModel((c.resolve<LoggerService>())));
    _container.registerFactory((c) => AuthProvider(c.resolve<BaseContract>()));
    _container.registerFactory((c) => BaseProvider(AppConfiguration.baseUrl));

    _container.registerSingleton<AppContext>((c) {
      AppContext context = new AppContext();
      var secureStorage = c.resolve<AppSecureStorage>();
      secureStorage
          .readAsync<AppContext>(AppConstants.APP_CONTEXT_KEY)
          .then((result) {
        if (result != null) {
          if (result.userContext != null) {
            context.setUserContext(result.userContext);
            context.status = AppStatusType.Authenticated;
          } else
            context.status = AppStatusType.Initialized;
        }
        return context;
      });
      return context ?? new AppContext();
    });

    _container.registerSingleton<ThemeContext>((c) {
      ThemeContext themeContext = new ThemeContext.parameterizedConstructor(
          AppConstants.defaultThemeState,
          AppConstants.defaultPrimaryAccentColor,
          AppConstants.defaultSecondaryAccentColor);
      var secureStorage = c.resolve<AppSecureStorage>();
      secureStorage
          .readAsync<ThemeContext>(AppConstants.THEMEKEY)
          .then((result) {
        if (result != null) {
          themeContext.primaryAccentColor = result.primaryAccentColor;
          themeContext.secondaryAccentColor = result.secondaryAccentColor;
          themeContext.themeState = result.themeState;
          return themeContext;
        }
        return themeContext;
      });
      return themeContext;
    });

    _container.registerSingleton((c) {
      return AppSerializer.configure();
    });

    _container.registerSingleton((c) {
      return SQLiteDB.instance;
    });

    _container.registerSingleton((c) {
      return new AppSecureStorage(c.resolve<JsonRepo>());
    });

    _container.registerSingleton((c) {
      HiveDb.configure();
      return new HiveDb();
    });
    _container.registerSingleton((c) {
      return new LoggerService();
    });
  }

  static T getInstance<T>() {
    return _container.resolve<T>();
  }
}
