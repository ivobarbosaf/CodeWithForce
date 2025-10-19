@IsTest
private class NormalizePhoneActionTest {
  @IsTest
  static void normalizeValidMobileNumber() {
    NormalizePhoneAction.Request request = new NormalizePhoneAction.Request();
    request.phoneNumber = '961958682';

    List<NormalizePhoneAction.Response> responses = NormalizePhoneAction.normalizePhone(
      new List<NormalizePhoneAction.Request>{ request }
    );

    System.assertEquals(1, responses.size(), 'Expected one response entry');
    NormalizePhoneAction.Response response = responses[0];

    System.assertEquals(
      true,
      response.isValid,
      'Expected the phone number to be considered valid'
    );
    System.assertEquals(
      '+351961958682',
      response.normalizedPhoneNumber,
      'Normalized phone number mismatch'
    );
  }

  @IsTest
  static void normalizeAlreadyPrefixedNumber() {
    NormalizePhoneAction.Request request = new NormalizePhoneAction.Request();
    request.phoneNumber = '+351 931 234 567';

    List<NormalizePhoneAction.Response> responses = NormalizePhoneAction.normalizePhone(
      new List<NormalizePhoneAction.Request>{ request }
    );
    NormalizePhoneAction.Response response = responses[0];

    System.assertEquals(
      true,
      response.isValid,
      'Expected +351 prefix to be recognized'
    );
    System.assertEquals(
      '+351931234567',
      response.normalizedPhoneNumber,
      'Normalized value should keep digits only'
    );
  }

  @IsTest
  static void normalizeWith351Prefix() {
    NormalizePhoneAction.Request request = new NormalizePhoneAction.Request();
    request.phoneNumber = '351921234567';

    List<NormalizePhoneAction.Response> responses = NormalizePhoneAction.normalizePhone(
      new List<NormalizePhoneAction.Request>{ request }
    );
    NormalizePhoneAction.Response response = responses[0];

    System.assertEquals(
      true,
      response.isValid,
      'Expected 351 prefix to be recognized'
    );
    System.assertEquals(
      '+351921234567',
      response.normalizedPhoneNumber,
      'Should normalize 351 prefix correctly'
    );
  }

  @IsTest
  static void normalizeWithSpacesAndDashes() {
    NormalizePhoneAction.Request request = new NormalizePhoneAction.Request();
    request.phoneNumber = '+351 96-195-8682';

    List<NormalizePhoneAction.Response> responses = NormalizePhoneAction.normalizePhone(
      new List<NormalizePhoneAction.Request>{ request }
    );
    NormalizePhoneAction.Response response = responses[0];

    System.assertEquals(
      true,
      response.isValid,
      'Expected formatted number to be valid'
    );
    System.assertEquals(
      '+351961958682',
      response.normalizedPhoneNumber,
      'Should remove formatting and normalize'
    );
  }

  @IsTest
  static void invalidPhoneNumberFailsValidation() {
    NormalizePhoneAction.Request request = new NormalizePhoneAction.Request();
    request.phoneNumber = '5551234'; // Wrong prefix and length

    List<NormalizePhoneAction.Response> responses = NormalizePhoneAction.normalizePhone(
      new List<NormalizePhoneAction.Request>{ request }
    );
    NormalizePhoneAction.Response response = responses[0];

    System.assertEquals(
      false,
      response.isValid,
      'Expected invalid number to be flagged'
    );
    System.assertEquals(
      null,
      response.normalizedPhoneNumber,
      'Invalid numbers should not return a normalized value'
    );
  }

  @IsTest
  static void invalidPrefixFailsValidation() {
    NormalizePhoneAction.Request request = new NormalizePhoneAction.Request();
    request.phoneNumber = '351951234567'; // 95 is not a valid Portuguese mobile prefix

    List<NormalizePhoneAction.Response> responses = NormalizePhoneAction.normalizePhone(
      new List<NormalizePhoneAction.Request>{ request }
    );
    NormalizePhoneAction.Response response = responses[0];

    System.assertEquals(
      false,
      response.isValid,
      'Expected invalid prefix to be flagged'
    );
    System.assertEquals(
      null,
      response.normalizedPhoneNumber,
      'Invalid prefix should not return a normalized value'
    );
  }
}
