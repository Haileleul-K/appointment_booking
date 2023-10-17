import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trip_add_event.dart';
part 'trip_add_state.dart';

class TripAddBloc extends Bloc<TripAddEvent, TripAddState> {
  TripAddBloc() : super(TripAddInitial()) {
    on<TripAddEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
