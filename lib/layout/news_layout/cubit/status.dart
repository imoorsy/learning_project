abstract class newsStates {}

class newsInitialStates extends newsStates {}

class newsBottomNavStates extends newsStates {}

class newsBusnissLoadingStates extends newsStates {}

class newsGetBusnissSuccessStates extends newsStates {}

class newsGetBusnissErrorStates extends newsStates {
  final String error;

  newsGetBusnissErrorStates(this.error);
}
class newsSearchLoadingStates extends newsStates {}

class newsGetSearchSuccessStates extends newsStates {}

class newsGetSearchErrorStates extends newsStates {
  final String error;

  newsGetSearchErrorStates(this.error);
}


class newsSportsLoadingStates extends newsStates {}
class newsGetSportsSuccessStates extends newsStates {}

class newsGetSportsErrorStates extends newsStates {
  final String error;

  newsGetSportsErrorStates(this.error);
}

class newsScienceLoadingStates extends newsStates {}
class newsGetScienceSuccessStates extends newsStates {}

class newsGetScienceErrorStates extends newsStates {
  final String error;

  newsGetScienceErrorStates(this.error);
}

class newsMatchesLoadingStates extends newsStates {}

class newsGetMatchesSuccessStates extends newsStates {}

class newsChangeMatchesStates extends newsStates {}

class newsGetMatchesErrorStates extends newsStates {}

class newsChangeModeStates extends newsStates {}
class networkConnetStates extends newsStates {
  final String massage;

  networkConnetStates({required this.massage});
}
class networkNotConnectStates extends newsStates {
  final String massage;

  networkNotConnectStates({required this.massage});
}




