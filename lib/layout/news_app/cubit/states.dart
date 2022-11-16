abstract class NewsState{}
class NewsInitialState extends NewsState{}
class BottomNavBarState extends NewsState{}
class GetBusinessSuccessState extends NewsState{}
class GetBusinessErrorState extends NewsState{
  late final String error;
  GetBusinessErrorState(this.error);
}
class NewsGetBusinessLoadingState extends NewsState{}
class GetSportsSuccessState extends NewsState{}
class GetSportsErrorState extends NewsState{
  late final String error;
  GetSportsErrorState(this.error);
}
class NewsGetSportsLoadingState extends NewsState{}
class GetScienceSuccessState extends NewsState{}
class GetScienceErrorState extends NewsState{
  late final String error;
  GetScienceErrorState(this.error);
}
class NewsGetScienceLoadingState extends NewsState{}
class GetSearchSuccessState extends NewsState{}
class GetSearchErrorState extends NewsState{
  late final String error;
  GetSearchErrorState(this.error);
}
class NewsGetSearchLoadingState extends NewsState{}