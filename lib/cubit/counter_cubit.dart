// import 'dart:developer';
//
// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'counter_state.dart';
//
// class CounterCubit extends Cubit<CounterState> {
//   CounterCubit() : super(CounterInitial());
//
//   static CounterCubit get(context) => BlocProvider.of(context);
//
//   static int counter = 0;
//
//   increament(Counter){
//     counter = counter+1 ;
//     emit(Increament());
//   }
//
//   dcreament(Counter){
//     return counter -1 ;
//     emit(decreament());
//   }
// }
