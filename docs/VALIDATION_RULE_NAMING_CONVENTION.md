# Validation Rule Naming Convention

## Standard Pattern

### **Naming Format:**
`VR##_ObjAbbr_Description` (Max 40 characters)

**Important:** Salesforce has a 40-character limit for validation rule names.

### **Error Message Format:**
`[VR##_ObjAbbr]`

## Object Abbreviations

| Object | Abbreviation | Example |
|--------|-------------|---------|
| Opportunity | Opp | [VR01_Opp] |
| Account | Acc | [VR01_Acc] |
| Contact | Con | [VR01_Con] |
| Lead | Lea | [VR01_Lea] |
| Case | Cas | [VR01_Cas] |
| Contract | Ctr | [VR01_Ctr] |
| Product2 | Pro | [VR01_Pro] |
| Quote | Quo | [VR01_Quo] |

## Examples

### **Opportunity Object:**
- `VR01_Opp_SysAdmin_Only_Closed_Won` → Error: `[VR01_Opp]`
- `VR02_Opp_Amount_Required_Proposal` → Error: `[VR02_Opp]`
- `VR03_Opp_Close_Date_Future_Only` → Error: `[VR03_Opp]`

### **Account Object:**
- `VR01_Acc_Name_Required` → Error: `[VR01_Acc]`
- `VR02_Acc_Phone_Format_Validation` → Error: `[VR02_Acc]`

### **Contact Object:**
- `VR01_Con_Email_Required_Decision_Maker` → Error: `[VR01_Con]`

## Benefits

1. **Sequential Tracking:** Easy to identify order of rule creation
2. **Object Organization:** Clear separation per object
3. **Error Identification:** Quick identification in error logs
4. **Scalability:** Consistent pattern across all objects
5. **Governance:** Clear naming standards for team

## Implementation Guidelines

1. Always use leading zeros (VR01, VR02, not VR1, VR2)
2. Use descriptive names after object name
3. Include object abbreviation in error message
4. Document the purpose in description field
5. Maintain sequential numbering per object