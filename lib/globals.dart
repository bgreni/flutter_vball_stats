library vball_stats.globals;
import "entities/User.dart";
import "entities/Team.dart";
import 'package:vball_stats/services/FirestoreHelper.dart';


String currentUserId;
bool isCurrentUserCoach;

User currentUser;

Team currentTeam;

FirestoreHelper fireHelper = new FirestoreHelper();
