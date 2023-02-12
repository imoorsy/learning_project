import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/modules/counter/cubit/status.dart';

class CounterCubit extends Cubit<CounterStatus>
{
  CounterCubit() : super(CounterIntialState());


  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;

  void minus () {
    counter--;
    print(counter);
    emit(CounterMinusState());
  }

  void plus () {
    counter++;
    print(counter);
    emit(CounterPlusState());
  }
}