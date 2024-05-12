import 'package:flutter/material.dart';
import 'package:bloc_pattern_counter_app/counter/counter_event.dart';
import 'package:bloc_pattern_counter_app/counter/counter_state.dart';
import 'package:bloc_pattern_counter_app/counter/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc Pattern Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: const MyHomePage(title: 'Bloc Pattern Flutter App'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bloc Demo APP"),
      ),
      body: BlocBuilder<CounterBloc, CounterStates>(
        builder: (context, state) {
          if (state is InitialState) {
            return _counter(context, 0);
          }
          if (state is UpdateState) {
            return _counter(context, state.counter);
          }
          return Container();
        },
      ),
    );
  }
}

Widget _counter(BuildContext context, int counter) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          counter.toString(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.red,
              elevation: 0.0,
              height: 50,
              shape: const RoundedRectangleBorder(borderRadius : BorderRadius.all(Radius.circular(8))),
              child: const Text("-", style: TextStyle(fontSize: 22, color: Colors.white),),
              onPressed: () {
                context.read<CounterBloc>().add(NumberDecreaseEvent());
              },
            ),
            const SizedBox(
              width: 50,
            ),
            MaterialButton(
              color: Colors.green,
              elevation: 0.0,
              height: 50,
              shape: const RoundedRectangleBorder(borderRadius : BorderRadius.all(Radius.circular(8))),
              child: const Text("+", style: TextStyle(fontSize: 22, color: Colors.white),),
              onPressed: () {
                context.read<CounterBloc>().add(NumberIncreaseEvent());
              },
            ),
          ],
        )
      ],
    ),
  );
}
