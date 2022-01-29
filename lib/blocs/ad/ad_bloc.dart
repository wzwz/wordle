import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/ad/ad.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  AdBloc() : super(NoAdShown()) {
    on<ShowInterstitialAd>(_onShowInterstitialAd);
    on<CloseInterstitialAd>(_onCloseInterstitialAd);
  }

  Future<void> _onShowInterstitialAd(
      ShowInterstitialAd event, Emitter<AdState> emit) async {
    emit(InterstitialAdShown());
  }

  Future<void> _onCloseInterstitialAd(
      CloseInterstitialAd event, Emitter<AdState> emit) async {
    emit(NoAdShown());
  }
}
