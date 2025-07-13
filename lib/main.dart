import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp/core/util/apiservice.dart';
import 'package:tcp/feutaure/Row_Material/presentation/view/manager/add_raw_material_cubit.dart';
import 'package:tcp/feutaure/Row_Material/presentation/view/manager/get_raw_material_cubit.dart';
import 'package:tcp/feutaure/Row_Material/presentation/view/raw_material_view.dart';
import 'package:tcp/feutaure/Row_Material/repo/raw_material_repo.dart';
import 'package:tcp/view_models/auth_cubit/auth_cubit.dart'; // AuthCubit

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AddRawMaterialCubit(
              rawMaterialRepository:
                  RawMaterialRepository(apiService: ApiService())),
        ),
        BlocProvider<GetRawMaterialsCubit>(
          create: (context) => GetRawMaterialsCubit(
              rawMaterialRepository:
                  RawMaterialRepository(apiService: ApiService())),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690), // قم بتعيين حجم التصميم الخاص بك هنا
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Inter',
            ),
            home: const RawMaterialsListPage(),
          );
        },
      ),
    );
  }
}
