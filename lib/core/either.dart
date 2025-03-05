abstract class Either<L,R>{
 factory Either.left(L value)=Left<L,R>;
 factory Either.right(R value)=Right<L,R>;

// this method to return value right if rigth is not null or left if left is not null
// but one of them must be null right or left
 T fold<T>(T Function(L left) onLeft,T Function(R right) onRight);

}

// this class to Error value
class Left<L,R> implements Either<L,R>{
  final L value;

  Left(this.value);
  
  @override
  T fold<T>(T Function(L value) onLeft, T Function(R value) onRight)=>onLeft(value);
}

// THIS class to success value
class Right<L,R> implements Either<L,R>{
  final R value;

  Right(this.value);
  
  @override
  T fold<T>(T Function(L value) onLeft, T Function(R value) onRight) =>
    onRight(value);
  
}