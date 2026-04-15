---
name: qrisk2
description: The qrisk2 tool calculates a patient's 10-year risk of heart attack or stroke using the QRisk2-2014 cardiovascular risk prediction algorithm. Use when user asks to calculate cardiovascular risk scores, predict the likelihood of heart disease, or assess clinical risk factors using the QRisk2-2014 library.
homepage: https://github.com/BlackPearSw/qrisk2-2014
metadata:
  docker_image: "biocontainers/qrisk2:v0.1.20150729-4-deb_cv1"
---

# qrisk2

## Overview
The `qrisk2` skill implements the QRisk2-2014 cardiovascular risk prediction algorithm via the `qrisk2-2014` JavaScript library. It allows for the calculation of a patient's 10-year risk of a heart attack or stroke by processing a specific set of clinical variables. This tool is essential for clinical decision support and identifying high-risk patients who may benefit from preventative treatments.

## Usage Instructions

### Installation
The tool is available as an NPM package:
```bash
npm install qrisk2-2014
```

### Programmatic Implementation
The library provides gender-specific methods: `qrisk2.male(args)` and `qrisk2.female(args)`.

```javascript
var qrisk2 = require('qrisk2-2014');

var args = {
  age: 30,           // Age in years
  b_AF: 0,           // Atrial Fibrillation (0=No, 1=Yes)
  b_ra: 0,           // Rheumatoid Arthritis (0=No, 1=Yes)
  b_renal: 0,        // Chronic Renal Disease (0=No, 1=Yes)
  b_treatedhyp: 0,   // Treated Hypertension (0=No, 1=Yes)
  b_type1: 0,        // Type 1 Diabetes (0=No, 1=Yes)
  b_type2: 0,        // Type 2 Diabetes (0=No, 1=Yes)
  bmi: 25,           // Body Mass Index
  ethrisk: 1,        // Ethnicity (Categorical)
  fh_cvd: 0,         // Family history of CVD (0=No, 1=Yes)
  rati: 1,           // Cholesterol/HDL ratio
  sbp: 120,          // Systolic Blood Pressure (mmHg)
  smoke_cat: 0,      // Smoking category (Categorical)
  surv: 10,          // Survival time (typically 10 for 10-year risk)
  town: 0            // Townsend deprivation index
};

var risk = qrisk2.male(args);
console.log('10 year cardiovascular risk = ', risk.score, '%');
```

### Parameter Guidelines
*   **Binary Flags**: All parameters starting with `b_` (e.g., `b_AF`, `b_renal`) must be passed as integers: `0` for No/False and `1` for Yes/True.
*   **Categorical Data**:
    *   `ethrisk`: Represents ethnic group.
    *   `smoke_cat`: Represents smoking status (e.g., non-smoker, ex-smoker, light, moderate, heavy).
*   **Deprivation**: The `town` parameter refers to the Townsend deprivation index score, which is a measure of material deprivation within a specific area.
*   **Survival**: The `surv` parameter defines the prediction window. For a standard 10-year risk assessment, this should be set to `10`.

## Expert Tips
*   **Validation**: Ensure that `sbp` (Systolic Blood Pressure) and `bmi` are within physiological ranges before calling the function, as extreme outliers can skew the risk score.
*   **Legal Requirement**: When displaying the generated risk score, you must include or link to the ClinRisk Ltd disclaimer as per the LGPL-3.0 license terms.
*   **Regression Testing**: For high-stakes clinical environments, verify your implementation against the `qrisk2-2014-regression` test suite to ensure the coefficients and logic remain faithful to the original algorithm.

## Reference documentation
- [QRisk2-2014 README](./references/github_com_BlackPearSw_qrisk2-2014.md)