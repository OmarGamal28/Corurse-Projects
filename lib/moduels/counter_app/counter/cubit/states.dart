abstract class CounterStates {}

class InitialState extends CounterStates{}
class PlusState extends CounterStates{
  late final int counter;
  PlusState(this.counter);
}
class MinusState extends CounterStates{
  late final int counter;
  MinusState(this.counter);
}