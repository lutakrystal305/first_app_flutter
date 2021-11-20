import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Cubit<int> {
  CounterBloc(int initialState) : super(5);

  // ignore: invalid_use_of_visible_for_testing_member
  void changeCount(value) => emit(value);
}
