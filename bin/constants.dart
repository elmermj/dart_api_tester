// ignore_for_file: non_constant_identifier_names, constant_identifier_names

const SERVER_URL = "http://localhost:8080/";

DEFAULT_HEADER(String token){
  return {
    'Authorization': 'Bearer $token',
  };
}

const DEFAULT_HEADER_NON_TOKEN = {
  'Content-Type': 'application/json',
};