import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('ff_username') ?? _username;
    _nextimage = prefs.getInt('ff_nextimage') ?? _nextimage;
    _nextopponent = prefs.getInt('ff_nextopponent') ?? _nextopponent;
    _Answers = prefs.getStringList('ff_Answers') ?? _Answers;
    _appname = prefs.getString('ff_appname') ?? _appname;
    _OpponentLevels =
        prefs.getStringList('ff_OpponentLevels')?.map(int.parse).toList() ??
            _OpponentLevels;
    _roundlength = prefs.getInt('ff_roundlength') ?? _roundlength;
    _ppicture = prefs.getString('ff_ppicture') ?? _ppicture;
    _opponentPoints =
        prefs.getStringList('ff_opponentPoints')?.map(int.parse).toList() ??
            _opponentPoints;
    _opponentAnswers =
        prefs.getStringList('ff_opponentAnswers') ?? _opponentAnswers;
    _userlevel = prefs.getInt('ff_userlevel') ?? _userlevel;
    _nRoundsPerGame = prefs.getInt('ff_nRoundsPerGame') ?? _nRoundsPerGame;
    _isIntroWatched = prefs.getBool('ff_isIntroWatched') ?? _isIntroWatched;
  }

  late SharedPreferences prefs;

  String _username = '';
  String get username => _username;
  set username(String _value) {
    _username = _value;
    prefs.setString('ff_username', _value);
  }

  int _nextimage = 0;
  int get nextimage => _nextimage;
  set nextimage(int _value) {
    _nextimage = _value;
    prefs.setInt('ff_nextimage', _value);
  }

  int _nextopponent = -1;
  int get nextopponent => _nextopponent;
  set nextopponent(int _value) {
    _nextopponent = _value;
    prefs.setInt('ff_nextopponent', _value);
  }

  List<String> OpponentNames = [
    'user3040',
    'ocg4723',
    'batista003',
    'burny',
    'Holli Felix',
    'user1002',
    'user4116',
    'garip',
    'ailoveer!',
    'alikan',
    'sd',
    'iamai'
  ];

  List<String> _Answers = [
    "dummy",
    "emma stone holding a stone",
    "group of cavemen taking a selfie",
    "chess match on a pizza",
    "donald trump trapped in minecraft, drinking a beer",
    "annual meeting of dancer apples",
    "shrek's father in world war 2",
    "walter white accidentally end up in winterfell",
    "pikachu in a fine dine restaruant",
    "a futuristic green space station",
    "a baby experiencing stock market crash",
    "a futuristic space station with an oasis",
    "a big hamster as a radio broadcaster",
    "an angry cat captured an orchestra",
    "saturn eaten by a black hole",
    "samuel jackson is selected as a new pope",
    "jeff bezos lost in amazon forest but happy",
    "a group of teddy bear tired in a paris street",
    "pikahcus' uprising in paris",
    "an old photo of creepy teletubbies",
    "happy teletubbies at walmart",
    "steve jobs as a 18th century prussian general",
    "cristiano ronaldo becomes a birthday cake",
    "spider-man works as a dhl officer",
    "boris johnson graduating from college",
    "a giant avocado sitting on a chair",
    "eggs gathered in mordor, waiting for frodo",
    "a paradox",
    "man stuck in a qr code",
    "maradona met with george washington",
    "darth vader decided to take part in dune",
    "cat dancing in a nightclub",
    "a tiny man looking for poop photos",
    "gandalf tries to wake up",
    "mac and cheese",
    "a newspaper about the lost case of princess fiona",
    "tiramisaurus rex"
  ];

  List<String> get Answers => _Answers;
  set Answers(List<String> _value) {
    _Answers = _value;
    prefs.setStringList('ff_Answers', _value);
  }

  void addToAnswers(String _value) {
    _Answers.add(_value);
    prefs.setStringList('ff_Answers', _Answers);
  }

  void removeFromAnswers(String _value) {
    _Answers.remove(_value);
    prefs.setStringList('ff_Answers', _Answers);
  }

  String _appname = 'See like AI';
  String get appname => _appname;
  set appname(String _value) {
    _appname = _value;
    prefs.setString('ff_appname', _value);
  }

  List<int> _OpponentLevels = [2, 1, 4, 6, 11, 1, 1, 2, 3, 4];
  List<int> get OpponentLevels => _OpponentLevels;
  set OpponentLevels(List<int> _value) {
    _OpponentLevels = _value;
    prefs.setStringList(
        'ff_OpponentLevels', _value.map((x) => x.toString()).toList());
  }

  void addToOpponentLevels(int _value) {
    _OpponentLevels.add(_value);
    prefs.setStringList(
        'ff_OpponentLevels', _OpponentLevels.map((x) => x.toString()).toList());
  }

  void removeFromOpponentLevels(int _value) {
    _OpponentLevels.remove(_value);
    prefs.setStringList(
        'ff_OpponentLevels', _OpponentLevels.map((x) => x.toString()).toList());
  }

  int _roundlength = 15000;
  int get roundlength => _roundlength;
  set roundlength(int _value) {
    _roundlength = _value;
    prefs.setInt('ff_roundlength', _value);
  }

  String _ppicture = '';
  String get ppicture => _ppicture;
  set ppicture(String _value) {
    _ppicture = _value;
    prefs.setString('ff_ppicture', _value);
  }

  List<int> _opponentPoints = [50, 40, 20, 70, 80];
  List<int> get opponentPoints => _opponentPoints;
  set opponentPoints(List<int> _value) {
    _opponentPoints = _value;
    prefs.setStringList(
        'ff_opponentPoints', _value.map((x) => x.toString()).toList());
  }

  void addToOpponentPoints(int _value) {
    _opponentPoints.add(_value);
    prefs.setStringList(
        'ff_opponentPoints', _opponentPoints.map((x) => x.toString()).toList());
  }

  void removeFromOpponentPoints(int _value) {
    _opponentPoints.remove(_value);
    prefs.setStringList(
        'ff_opponentPoints', _opponentPoints.map((x) => x.toString()).toList());
  }

  List<String> _opponentAnswers = [
    "dummyopponentanswer",
    "emma stoneception",
    "group of cavemen laughing together",
    "chess pizza",
    "donald trump in minecraft",
    "very crowded apples dancing",
    "shrek as a world war 2 soldier",
    "walter snow",
    "pikachu having a nice dinner",
    "suburb of green buildings, futuristic",
    "a terrified and stunned baby",
    "futuristic space station with an oasis",
    "a capybara sitting with headset",
    "an evil cat standing in front of an orchestra",
    "white horse becomes a puddle",
    "samuel jackson as pope",
    "jeff bezos in an amazon forest",
    "teddy bears waiting in paris",
    "evil little pikachus in paris streets",
    "elder creepy teletubbies",
    "teletubbies at supermarket",
    "steve jobs as general",
    "cristiano ronaldo on cake",
    "spider-man working for dhl",
    "young boris johnson with a half tie",
    "avocado chair",
    "eggs hell",
    "chicken egg",
    "man trapped in qr code",
    "maradona with washington",
    "darth vader gathered with other darth vaders",
    "cat having fun in nightclub, while searching for a drink",
    "weird little man watching a weird screen",
    "gandalf wonders about the ring on his bed",
    "mac and cheese",
    "old newspaper article about ??",
    "t-rex as birthday cake"
  ];

  List<String> get opponentAnswers => _opponentAnswers;
  set opponentAnswers(List<String> _value) {
    _opponentAnswers = _value;
    prefs.setStringList('ff_opponentAnswers', _value);
  }

  void addToOpponentAnswers(String _value) {
    _opponentAnswers.add(_value);
    prefs.setStringList('ff_opponentAnswers', _opponentAnswers);
  }

  void removeFromOpponentAnswers(String _value) {
    _opponentAnswers.remove(_value);
    prefs.setStringList('ff_opponentAnswers', _opponentAnswers);
  }

  int _userlevel = 1;
  int get userlevel => _userlevel;
  set userlevel(int _value) {
    _userlevel = _value;
    prefs.setInt('ff_userlevel', _value);
  }

  int _nRoundsPerGame = 2;
  int get nRoundsPerGame => _nRoundsPerGame;
  set nRoundsPerGame(int _value) {
    _nRoundsPerGame = _value;
    prefs.setInt('ff_nRoundsPerGame', _value);
  }

  bool isReadyActive = true;

  bool isSoundOn = true;

  bool _isIntroWatched = false;
  bool get isIntroWatched => _isIntroWatched;
  set isIntroWatched(bool _value) {
    _isIntroWatched = _value;
    prefs.setBool('ff_isIntroWatched', _value);
  }

  int tutoPhase = 1;
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
