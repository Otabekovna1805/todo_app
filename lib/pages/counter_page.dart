import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/counter_cubit/counter_cubit.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.read<CounterCubitt>().increment(),
                        child: const Text(
                          "+1",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      BlocBuilder<CounterCubitt, int>(
                        builder: (context, state) =>
                            Text(
                              "$state",
                              style: const TextStyle(fontSize: 30),
                            ),
                      ),
                      ElevatedButton(
                        onPressed: () => context.read<CounterCubitt>().decrement(),
                        child: const Text(
                          "-1",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                   
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}