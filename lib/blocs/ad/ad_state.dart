import 'package:equatable/equatable.dart';

abstract class AdState extends Equatable {
  const AdState();

  @override
  List<Object> get props => [];
}

class NoAdShown extends AdState {}

class InterstitialAdShown extends AdState {}