import 'package:equatable/equatable.dart';

abstract class BlocState extends Equatable {
  const BlocState();
}

class BlocStateLoading extends BlocState {
  @override
  List<Object> get props => [];
}

class BlocStateLoaded<T> extends BlocState {
  final T data;
  const BlocStateLoaded(this.data);

  @override
  List<Object> get props => [data as Object];
}

class BlocStateError extends BlocState {
  final Exception exception;
  const BlocStateError(this.exception);

  @override
  List<Object> get props => [exception];
}