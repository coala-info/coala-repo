---
name: embl-api-validator
description: This tool validates ENA flat files for submission compliance. Use when user asks to validate ENA flat files.
homepage: http://www.ebi.ac.uk/ena/software/flat-file-validator
---


# embl-api-validator

yaml
name: embl-api-validator
description: Validates ENA flat files for submission. Use when Claude needs to ensure the correctness and compliance of ENA flat files before submission to the ENA database. This includes checking for structural integrity, adherence to ENA standards, and identifying potential errors or inconsistencies in the data.
```
## Overview
The embl-api-validator is a command-line tool designed to validate ENA (European Nucleotide Archive) flat files. It checks these files for compliance with ENA submission standards, ensuring data accuracy and structural integrity before submission. This tool is crucial for researchers and bioinformaticians preparing data for deposition in ENA.

## Usage Instructions

The `embl-api-validator` is typically used via its command-line interface. The primary function is to validate one or more flat files against ENA's schema.

### Basic Validation

To validate a single flat file:

```bash
embl-api-validator <path/to/your/flatfile.txt>
```

To validate multiple flat files:

```bash
embl-api-validator <path/to/file1.txt> <path/to/file2.txt> ...
```

### Output and Error Handling

The validator will output any errors or warnings encountered during the validation process. Successful validation means the file conforms to ENA's flat file format specifications. If errors are reported, they must be corrected in the flat file before submission.

### Expert Tips

*   **Pre-submission Check**: Always run the validator on your flat files *before* attempting submission to ENA. This proactive step can save significant time by catching errors early.
*   **File Naming**: Ensure your flat files have appropriate extensions (e.g., `.txt`, `.flatfile`) and follow any naming conventions recommended by ENA.
*   **Error Interpretation**: Carefully read and understand each error message provided by the validator. The messages often pinpoint the exact line number and nature of the problem.
*   **Version Compatibility**: While not explicitly detailed in the provided documentation, it's good practice to be aware of the validator's version and any potential changes in ENA's flat file specifications over time. If you encounter unexpected validation failures, consider if there's a newer version of the validator or if ENA's requirements have recently changed.

## Reference documentation
- [ENA flat file validator overview](./references/anaconda_org_channels_bioconda_packages_embl-api-validator_overview.md)