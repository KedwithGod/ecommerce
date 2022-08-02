class WooCommerceErrorResponse{
  String code,message;
  int status;

  WooCommerceErrorResponse({required this.code,
    required this.message,
    required this.status});


  factory WooCommerceErrorResponse.fromMap(Map<String, dynamic> map) {
    return WooCommerceErrorResponse(
      code: map['code'],
      message: map['message'],
      status: map["data"]['status'],
    );
  }
}

