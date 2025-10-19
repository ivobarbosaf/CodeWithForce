public with sharing class NormalizePhoneAction {
  private static final Set<String> PORTUGUESE_MOBILE_PREFIXES = new Set<String>{
    '91',
    '92',
    '93',
    '96'
  };
  private static final String COUNTRY_CODE_PREFIX = '+351';

  public class Request {
    @InvocableVariable(required=true)
    public String phoneNumber;
  }

  public class Response {
    @InvocableVariable
    public String normalizedPhoneNumber;

    @InvocableVariable
    public Boolean isValid;
  }

  @InvocableMethod(
    label='Normalize Portuguese Mobile Phone'
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

    if (request == null || String.isBlank(request.phoneNumber)) {
      response.isValid = false;
      response.normalizedPhoneNumber = null;
      return response;
    }

    // Remove all non-digit characters
    String cleanedNumber = request.phoneNumber.replaceAll('[^0-9]', '');

    String nationalNumber = extractNationalNumber(cleanedNumber);

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

  private static String extractNationalNumber(String cleanedNumber) {
    if (String.isBlank(cleanedNumber)) {
      return null;
    }

    // Case 1: 9 digits (961958682)
    if (cleanedNumber.length() == 9) {
      return cleanedNumber;
    }

    // Case 2: 12 digits starting with 351 (351961958682)
    if (cleanedNumber.length() == 12 && cleanedNumber.startsWith('351')) {
      return cleanedNumber.substring(3);
    }

    // Case 3: 13 digits starting with +351 (but + was removed, so just 351)
    // This is the same as case 2, already handled above

    return null;
  }

  private static Boolean startsWithAllowedPrefix(String value) {
    return value != null &&
      value.length() >= 2 &&
      PORTUGUESE_MOBILE_PREFIXES.contains(value.substring(0, 2));
  }
}
