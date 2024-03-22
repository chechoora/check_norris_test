import 'package:check_norris_test/domain/model/category.dart';

sealed class CategoryState {}

class LoadingState extends CategoryState {}

class DataState extends CategoryState {
  final List<Category> categories;

  DataState({required this.categories});
}

class ErrorState extends CategoryState {}
