import 'dart:async';

import 'package:learning_bloc/bloc/counter_event.dart';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;

  // 1. setting input event, state
  // event
  final _eventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get eventSink => _eventController.sink;

  // state
  final _stateController = StreamController<int>();
  StreamSink<int> get _stateSink => _stateController.sink;

  // 2. setting output
  Stream<int> get counter => _stateController.stream;

  // 3. listen to the stream
  CounterBloc() {
    _eventController.stream.listen((event) {
      _mapEventToState(event);
    });
  }

  // 4. map to logic (business logic)
  _mapEventToState(CounterEvent event) {
    if (event == CounterEvent.increment) {
      _counter++;
      // add state to sink
      _stateSink.add(_counter);
    }
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
  //
}
