import 'package:cleantemplate/bloc/bloc_event.dart';
import 'package:cleantemplate/bloc/bloc_state.dart';
import 'package:cleantemplate/data/result.dart';
import 'package:cleantemplate/data/source/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class ItemsBloc extends Bloc<BlocEvent, BlocState> {
  final log = Logger('ItemsBloc');
  final DataRepository repo;

  ItemsBloc({required this.repo}) : super(BlocStateLoading()) {
    on<GetItems>(_onGetItems);
  }

  Future<void> _onGetItems(GetItems event, Emitter<BlocState> emit) async {
    final result = await repo.getSampleItems();
    if (result.status == Status.success) {
      emit(BlocStateLoaded(result.data!));
    }
  }
}

class GetItems extends BlocEvent {
  const GetItems();
  @override
  List<Object> get props => [];
}
