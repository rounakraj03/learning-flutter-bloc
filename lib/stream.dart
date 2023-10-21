Stream<int> BoatStream() async* {
  for(int i=0; i<10; i++) {
    print("Boat sent $i");
    await Future.delayed(const Duration(seconds: 5));
    yield i;
  }
}

void main(){
  Stream<int> stream = BoatStream();
  stream.listen((event) {print("Boat Received $event");});
}