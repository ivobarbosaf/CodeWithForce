// Classe invocável por Flow para normalizar números de telemóvel PT.
// Regras: aceita vários formatos de entrada e devolve +351XXXXXXXXX quando válido.
public with sharing class NormalizedPhoneActionPortuguese {
  private static final Set<String> PORTUGUESE_MOBILE_PREFIXES = new Set<String>{
    '91',
    '92',
    '93',
    '96'
  };
  private static final String COUNTRY_CODE_PREFIX = '+351';

  public class Request {
    @InvocableVariable(required=true)
    public String inputPhone;
  }

  public class Response {
    @InvocableVariable
    public String normalizedPhoneNumber;

    @InvocableVariable
    public Boolean isValid;
  }

  @InvocableMethod(
    label='Normalize PT Mobile'
    description='Validates Portuguese mobile numbers and returns the normalized +351 format when applicable'
  )
  public static List<Response> normalizePhone(List<Request> requests) {
    List<Response> responses = new List<Response>();

    if (requests == null) {
      return responses;
    }

    for (Request request : requests) {
      responses.add(processRequest(request));
    }

    return responses;
  }

  private static Response processRequest(Request request) {
    Response response = new Response();

    if (request == null || String.isBlank(request.inputPhone)) {
      response.isValid = false;
      response.normalizedPhoneNumber = null;
      return response;
    }

    // Remove all non-digit characters, but preserve the + sign if present
    String inputNumber = request.inputPhone.trim();
    Boolean hasCountryCodePrefix = inputNumber.startsWith('+');
    String cleanedNumber = inputNumber.replaceAll('[^0-9]', '');

    String nationalNumber = extractNationalNumber(
      cleanedNumber,
      hasCountryCodePrefix
    );

    if (
      String.isNotBlank(nationalNumber) &&
      nationalNumber.length() == 9 &&
      startsWithAllowedPrefix(nationalNumber)
    ) {
      response.normalizedPhoneNumber = COUNTRY_CODE_PREFIX + nationalNumber;
      response.isValid = true;
      return response;
    }

    response.isValid = false;
    response.normalizedPhoneNumber = null;
    return response;
  }

  private static String extractNationalNumber(
    String cleanedNumber,
    Boolean hasCountryCodePrefix
  ) {
    if (String.isBlank(cleanedNumber)) {
      return null;
    }

    // Case 1: 9 digits (961958682) - National format
    if (cleanedNumber.length() == 9) {
      return cleanedNumber;
    }

    // Case 2: 10 digits starting with 0 (0961958682) - National format with trunk prefix
    if (cleanedNumber.length() == 10 && cleanedNumber.startsWith('0')) {
      return cleanedNumber.substring(1); // Remove leading 0
    }

    // Caso 2b: 13 dígitos a começar por 0351 (ex.: 0351961958682) - Zero antes de 351
    if (cleanedNumber.length() == 13 && cleanedNumber.startsWith('0351')) {
      return cleanedNumber.substring(4); // remove '0351' → devolve 9 dígitos
    }

    // Caso 2c: 14 dígitos a começar por 00351 (ex.: 00351961958682) - Internacional com 00
    if (cleanedNumber.length() == 14 && cleanedNumber.startsWith('00351')) {
      return cleanedNumber.substring(5); // remove '00351' → devolve 9 dígitos
    }

    // Case 3: 12 digits starting with 351 (351961958682) - International format without +
    if (cleanedNumber.length() == 12 && cleanedNumber.startsWith('351')) {
      return cleanedNumber.substring(3);
    }

    // Case 4: 13 digits (from +351961958682) - International format with +
    if (
      cleanedNumber.length() == 13 &&
      hasCountryCodePrefix &&
      cleanedNumber.startsWith('351')
    ) {
      return cleanedNumber.substring(3);
    }

    return null;
  }

  private static Boolean startsWithAllowedPrefix(String value) {
    return value != null &&
      value.length() >= 2 &&
      PORTUGUESE_MOBILE_PREFIXES.contains(value.substring(0, 2));
  }
}
