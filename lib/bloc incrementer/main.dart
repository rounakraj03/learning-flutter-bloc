import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc%20incrementer/cubit/counter_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if(state.isIncremented){
            print("incremented");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Incremented"),duration: Duration(milliseconds: 500)),
            );          }
          if(!state.isIncremented){
            print("decremented");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Decremented"),duration: Duration(milliseconds: 500)),
            );          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Counter Value'),
              SizedBox(height: 24,),
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(state.counterValue.toString(),
                    style: TextStyle(fontSize: 30),);
                },
              ),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  }, child: Icon(Icons.plus_one_rounded),),
                  FloatingActionButton(onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  }, child: Icon(Icons.exposure_minus_1),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

