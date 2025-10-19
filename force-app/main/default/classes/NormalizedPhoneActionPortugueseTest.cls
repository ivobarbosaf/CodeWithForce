@IsTest
public class NormalizedPhoneActionPortugueseTest {

    @IsTest
    static void testNormalizePhone_ValidNationalFormat() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
        NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
        request.phoneNumber = '961958682';
        requests.add(request);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(true, responses[0].isValid, 'Should be valid');
        System.assertEquals('+351961958682', responses[0].normalizedPhoneNumber, 'Should normalize to +351 format');
    }

    @IsTest
    static void testNormalizePhone_ValidNationalFormatWithTrunk() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
        NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
        request.phoneNumber = '0961958682';
        requests.add(request);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(true, responses[0].isValid, 'Should be valid');
        System.assertEquals('+351961958682', responses[0].normalizedPhoneNumber, 'Should normalize to +351 format');
    }

    @IsTest
    static void testNormalizePhone_ValidInternationalFormat() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
        NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
        request.phoneNumber = '351961958682';
        requests.add(request);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(true, responses[0].isValid, 'Should be valid');
        System.assertEquals('+351961958682', responses[0].normalizedPhoneNumber, 'Should normalize to +351 format');
    }

    @IsTest
    static void testNormalizePhone_ValidInternationalFormatWithPlus() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
        NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
        request.phoneNumber = '+351961958682';
        requests.add(request);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(true, responses[0].isValid, 'Should be valid');
        System.assertEquals('+351961958682', responses[0].normalizedPhoneNumber, 'Should normalize to +351 format');
    }

    @IsTest
    static void testNormalizePhone_ValidPhoneWithSpaces() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
        NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
        request.phoneNumber = '+351 961 958 682';
        requests.add(request);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(true, responses[0].isValid, 'Should be valid');
        System.assertEquals('+351961958682', responses[0].normalizedPhoneNumber, 'Should normalize to +351 format');
    }

    @IsTest
    static void testNormalizePhone_AllValidPrefixes() {
        // Test all valid Portuguese mobile prefixes
        List<String> validPrefixes = new List<String>{'91', '92', '93', '96'};

        for (String prefix : validPrefixes) {
            // Arrange
            List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
            NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
            request.phoneNumber = prefix + '1234567';
            requests.add(request);

            // Act
            List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

            // Assert
            System.assertEquals(1, responses.size(), 'Should return one response for prefix ' + prefix);
            System.assertEquals(true, responses[0].isValid, 'Should be valid for prefix ' + prefix);
            System.assertEquals('+351' + prefix + '1234567', responses[0].normalizedPhoneNumber, 'Should normalize correctly for prefix ' + prefix);
        }
    }

    @IsTest
    static void testNormalizePhone_InvalidPrefix() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
        NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
        request.phoneNumber = '981234567'; // Invalid prefix 98
        requests.add(request);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(false, responses[0].isValid, 'Should be invalid');
        System.assertEquals(null, responses[0].normalizedPhoneNumber, 'Should not have normalized number');
    }

    @IsTest
    static void testNormalizePhone_InvalidLength() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
        NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
        request.phoneNumber = '96195868'; // Too short
        requests.add(request);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(false, responses[0].isValid, 'Should be invalid');
        System.assertEquals(null, responses[0].normalizedPhoneNumber, 'Should not have normalized number');
    }

    @IsTest
    static void testNormalizePhone_EmptyInput() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
        NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
        request.phoneNumber = '';
        requests.add(request);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(false, responses[0].isValid, 'Should be invalid');
        System.assertEquals(null, responses[0].normalizedPhoneNumber, 'Should not have normalized number');
    }

    @IsTest
    static void testNormalizePhone_NullInput() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();
        NormalizedPhoneActionPortuguese.Request request = new NormalizedPhoneActionPortuguese.Request();
        request.phoneNumber = null;
        requests.add(request);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(false, responses[0].isValid, 'Should be invalid');
        System.assertEquals(null, responses[0].normalizedPhoneNumber, 'Should not have normalized number');
    }

    @IsTest
    static void testNormalizePhone_NullRequestList() {
        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(null);

        // Assert
        System.assertEquals(0, responses.size(), 'Should return empty list');
    }

    @IsTest
    static void testNormalizePhone_MultipleRequests() {
        // Arrange
        List<NormalizedPhoneActionPortuguese.Request> requests = new List<NormalizedPhoneActionPortuguese.Request>();

        NormalizedPhoneActionPortuguese.Request request1 = new NormalizedPhoneActionPortuguese.Request();
        request1.phoneNumber = '961958682';
        requests.add(request1);

        NormalizedPhoneActionPortuguese.Request request2 = new NormalizedPhoneActionPortuguese.Request();
        request2.phoneNumber = '+351929876543';
        requests.add(request2);

        NormalizedPhoneActionPortuguese.Request request3 = new NormalizedPhoneActionPortuguese.Request();
        request3.phoneNumber = 'invalid';
        requests.add(request3);

        // Act
        List<NormalizedPhoneActionPortuguese.Response> responses = NormalizedPhoneActionPortuguese.normalizePhone(requests);

        // Assert
        System.assertEquals(3, responses.size(), 'Should return three responses');

        // First request - valid national format
        System.assertEquals(true, responses[0].isValid, 'First response should be valid');
        System.assertEquals('+351961958682', responses[0].normalizedPhoneNumber, 'First response should normalize correctly');

        // Second request - valid international format
        System.assertEquals(true, responses[1].isValid, 'Second response should be valid');
        System.assertEquals('+351929876543', responses[1].normalizedPhoneNumber, 'Second response should normalize correctly');

        // Third request - invalid
        System.assertEquals(false, responses[2].isValid, 'Third response should be invalid');
        System.assertEquals(null, responses[2].normalizedPhoneNumber, 'Third response should not have normalized number');
    }
}