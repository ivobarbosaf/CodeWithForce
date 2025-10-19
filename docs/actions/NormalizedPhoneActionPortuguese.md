# NormalizedPhoneActionPortuguese (Flow Invocable)

Apex Flow action that validates and normalizes Portuguese mobile phone numbers to the canonical format +351XXXXXXXXX.

## Overview
- Action label in Flow: "Normalize PT Mobile"
- Input (Request): `inputPhone` (String)
 - Input (Request): `inputPhone` (String)
- Outputs (Response):
  - `normalizedPhoneNumber` (String) → "+351" + 9 digits when valid; null otherwise
  - `isValid` (Boolean) → true when a valid Portuguese mobile number
- Valid mobile prefixes: 91, 92, 93, 96

## Accepted input formats
The action accepts the most common user-entered formats and extracts exactly the 9 national digits:
- 9 digits: `961958682`
- Trunk zero: `0961958682` → removes leading 0
- Country code w/out plus: `351961958682` → removes `351`
- Country code with plus: `+351961958682` → the `+` is ignored during cleaning
- Country code with 00: `00351961958682` → removes `00351`
 - Country code with leading 0 before 351: `0351961958682` → removes `0351`
- Any separators (space, dash, parentheses) are ignored

## Validation rules
- After extraction, the national number must:
  - Have exactly 9 digits
  - Start with one of: 91, 92, 93, 96
- If valid → returns `+351` + national number and `isValid = true`
- If invalid → returns `normalizedPhoneNumber = null` and `isValid = false`

## Behavior details
- Cleaning: removes any non-digit characters (including `+`, spaces, dashes, parentheses)
- Extraction logic (in order):
  1. `00351` + 9 digits → return digits after `00351`
  2. `0351` + 9 digits → return digits after `0351`
  3. 9 digits → return as-is
  4. `0` + 9 digits → drop the leading `0`
  5. `351` + 9 digits → return digits after `351`
  6. `+351` case is covered by cleaning to digits and step 5 above
- Any other length/format that cannot yield exactly 9 national digits → invalid

## Flow usage
1. Add Action → search for "Normalize PT Mobile"
2. Set Input:
   - `Input Phone` → the phone value you want to normalize
3. Use Outputs:
   - `Is Valid` to branch decisions
   - `Normalized Phone Number` to store or display the normalized value

### Example decisions
- If `Is Valid` = true → Update record phone with `Normalized Phone Number`
- Else → Show error message to the user / keep original

## Apex examples
```apex
NormalizedPhoneActionPortuguese.Request r = new NormalizedPhoneActionPortuguese.Request();
r.inputPhone = '+351 961 958 682';
List<NormalizedPhoneActionPortuguese.Response> out = NormalizedPhoneActionPortuguese.normalizePhone(new List<NormalizedPhoneActionPortuguese.Request>{ r });
System.debug(out[0].isValid);               // true
System.debug(out[0].normalizedPhoneNumber); // +351961958682
```

## Test coverage
- Test class: `NormalizedPhoneActionPortugueseTest`
- Total tests: 14 (including 00351 and 0351 formats)
- Class coverage: 98%
- Last run (Oct 19, 2025): All tests passed

## Known limitations
- Only Portuguese mobile prefixes (91, 92, 93, 96) are considered valid
- Does not validate number assignment/porting; checks only format and prefix
- Landline numbers are not supported

## Changelog
- 2025-10-19
  - Support for `0351XXXXXXXXX` format
  - Action label shortened to "Normalize PT Mobile"
  - Bug fix: support for `00351XXXXXXXXX` format
  - Documentation added (this file)
