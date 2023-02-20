import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/features/maps/data/repository/maps_repo.dart';
import 'package:flutter_maps/features/maps/presentation/screens/map_screen.dart';
import 'package:flutter_maps/features/phone_auth/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_maps/features/phone_auth/presentation/screens/login_screen.dart';

import 'constants/strings.dart';
import 'features/maps/business_logic/cubit/maps/maps_cubit.dart';
import 'features/maps/data/webservices/places_webservices.dart';
import 'features/phone_auth/presentation/screens/otp_screen.dart';


class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                MapsCubit(MapsRepository(PlacesWebservices())),
            child: MapScreen(),
          ),
        );

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
    }
  }
}
