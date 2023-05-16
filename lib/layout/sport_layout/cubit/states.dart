abstract class SportStates {}

class InitialSportState extends SportStates {}

class GetLoadingHomeDataSportState extends SportStates {}
class GetSuccessHomeDataSportState extends SportStates {}
class GetErrorHomeDataSportState extends SportStates {}

class GetLoadingCrntMatchSportState extends SportStates {}
class GetSuccessCrntMatchSportState extends SportStates {}
class GetErrorCrntMatchSportState extends SportStates {}

class GetLoadingCrntPlayerSportState extends SportStates {}
class GetSuccessCrntPlayerSportState extends SportStates {}
class GetErrorCrntPlayerSportState extends SportStates {}