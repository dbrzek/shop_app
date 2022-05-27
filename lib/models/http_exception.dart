
class HttpExceptetion implements Exception {
  final String message;

  HttpExceptetion(this.message);

  @override
  String toString() {
    return message;
    //return super.toString();  //Instance of Httpexceptetion
  }

}