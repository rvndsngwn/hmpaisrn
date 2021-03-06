import 'package:hmpaisrn/actions/fetch_actions.dart';
import 'package:hmpaisrn/models/app_data_state.dart';

AppDataState appDataReducer(AppDataState appDataState, action) {
  if (action is FetchSetUpcomingLaunchesAction) {
    appDataState = appDataState.copyWith(upcomingLaunch: action.upcomingLaunch);
	} else if (action is FetchSetLoadingAction) {
    appDataState = appDataState.copyWith(loading: action.loading);
  } else if (action is FetchSetPeopleInSpaceAction) {
    appDataState = appDataState.copyWith(peopleInSpace: action.autogenerated);
  } else if (action is FetchSetPreviousLaunchAction) {
    appDataState = appDataState.copyWith(previousLaunch: action.previousLaunch);
  } else if (action is FetchSetSearchLaunchAction) {
    appDataState = appDataState.copyWith(searchLaunch: action.searchLaunch);
  }
  return appDataState;
}
