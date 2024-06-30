import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:img_loader/utils/env.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class BadRequestException extends ApiException {
  BadRequestException(super.message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message);
}

class ForbiddenException extends ApiException {
  ForbiddenException(super.message);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message);
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException(super.message);
}

mixin BaseService {
  Future<Uint8List> getRequest({required String url}) async {
    var uri = Uri.parse(url);
    var response = await http.get(
      Uri.https(uri.host, uri.path),
      headers: {
        HttpHeaders.userAgentHeader: Env.header,
      },
    ).timeout(const Duration(seconds: 10));
    return _handleResponse(response);
  }

  Uint8List _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.bodyBytes;
      case 400:
        throw BadRequestException(
            "Something went wrong with your request. Please check your input or try again later.");
      case 401:
        throw UnauthorizedException(
            "You don't have permission to access this resource");
      case 403:
        throw ForbiddenException(
            "You don't have the necessary permissions to view this content");
      case 404:
        throw NotFoundException(
            "We couldn't find what you're looking for");
      case 500:
        throw InternalServerErrorException(
            "Something went wrong on server end. Please try again later");
      default:
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
    }
  }
}
