import 'dart:async';

import 'package:learning_bloc/bloc/counter_event.dart';
import 'package:learning_bloc/bloc/counter_state.dart';

class CounterBloc {
  CounterState _currentState = CounterState.initial();

  // 1. setting input event, state
  // event
  final _eventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get eventSink => _eventController.sink;

  // state
  final _stateController = StreamController<CounterState>();
  StreamSink<CounterState> get _stateSink => _stateController.sink;

  // 2. setting output
  Stream<CounterState> get counter => _stateController.stream;

  // 3. listen to the stream
  CounterBloc() {
    _eventController.stream.listen((event) {
      _mapEventToState(event);
    });
  }

  // 4. map to logic (business logic)
  _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _currentState = CounterState(counter: _currentState.counter + 1);
      // add state to sink
      _stateSink.add(_currentState);
    }
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
  //
}
