//creating exception class
//login exception
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//register exception
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class NetworkReuestFailAuthException implements Exception {}

//generic exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
