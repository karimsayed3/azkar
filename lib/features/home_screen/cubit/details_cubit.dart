import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/features/home_screen/cubit/details_state.dart';


class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;

  increament(counter){
    if (this.counter < counter){
      this.counter = this.counter +1 ;
      emit(Increament());
    }
  }

  dcreament(Counter){
    return counter -1 ;
    emit(decreament());
  }
}
