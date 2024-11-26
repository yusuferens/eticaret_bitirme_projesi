import 'package:eticaret_bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:eticaret_bitirme_projesi/ui/cubit/detay_sayfa_cubit.dart';
import 'package:eticaret_bitirme_projesi/ui/cubit/sepet_cubit.dart';
import 'package:eticaret_bitirme_projesi/ui/views/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit())
      ],
      child: MaterialApp(
        title: 'JoStore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',


          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}

