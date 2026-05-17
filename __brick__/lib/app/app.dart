import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'localization/app_localization.dart';
import 'routes/app_router.dart';
import 'theme/light_theme.dart';
import 'theme/dark_theme.dart';
import '../core/services/localization_service.dart';

class StartupApp extends StatelessWidget {
  final AppRouter appRouter;
  final LocalizationService localizationService;

  const StartupApp({
    super.key,
    required this.appRouter,
    required this.localizationService,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ListenableBuilder(
          listenable: localizationService,
          builder: (context, _) {
            return MaterialApp.router(
              title: 'StartupKit',
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter.router,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              locale: localizationService.currentLocale,
              supportedLocales: LocalizationService.supportedLocales,
              localizationsDelegates: const [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (final supported in supportedLocales) {
                  if (supported.languageCode == locale?.languageCode) {
                    return supported;
                  }
                }
                return LocalizationService.fallbackLocale;
              },
            );
          },
        );
      },
    );
  }
}
