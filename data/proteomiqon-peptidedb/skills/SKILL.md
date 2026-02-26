---
name: proteomiqon-peptidedb
description: This tool transforms protein sequences from FASTA files into a structured SQLite database of peptides by simulating in silico digestion and chemical modifications. Use when user asks to create a peptide database, perform in silico digestion, or prepare a reference database for shotgun proteomics.
homepage: https://csbiology.github.io/ProteomIQon/
---


# proteomiqon-peptidedb

## Overview

The `proteomiqon-peptidedb` tool transforms protein sequences from FASTA files into a structured SQLite database of peptides. It simulates experimental digestion conditions by applying specific protease rules, mass limits, and chemical modifications. You should use this skill when you need to prepare a reference database for shotgun proteomics, specifically when the downstream tools in the ProteomIQon suite require a `.sqlite` database to match against MS/MS spectra.

## CLI Usage Patterns

The tool follows a standard command-line interface requiring an input FASTA, an output directory, and a JSON parameter file.

### Basic Execution
```bash
proteomiqon -peptidedb -i "path/to/proteome.fasta" -o "path/to/outDirectory" -p "path/to/params.json"
```

### Argument Reference
- `-i | --input`: Path to the proteome information in FASTA format.
- `-o | --output`: Path to the directory where the resulting SQLite database will be stored.
- `-p | --params`: Path to the JSON file containing digestion and modification parameters.
- `--help`: Displays detailed descriptions of all available CLI arguments.

## Parameter Configuration

The behavior of the in silico digestion is governed by a JSON file. Below are the key parameters and best practices for configuration.

### Essential Parameter Fields
- **Name**: A descriptive string for the database.
- **Protease**: The enzyme used (e.g., `Trypsin`).
- **MissedCleavages**: Typically set between `0` (min) and `2` (max).
- **MassMode**: Use `Monoisotopic` for high-resolution MS data or `Average` for low-resolution data.
- **VariableMods**: A list of modifications to consider (e.g., `Oxidation'Met'`, `Acetylation'ProtNTerm'`).
- **VarModThreshold**: Limits the maximum number of variable modifications per peptide to prevent combinatorial explosion.
- **ParseProteinIDRegexPattern**: A regex string (default `"id"`) used to extract specific identifiers from FASTA headers.

### Example Parameter Structure (JSON)
```json
{
  "Name": "Human_Proteome_Trypsin",
  "ParseProteinIDRegexPattern": "id",
  "Protease": "Trypsin",
  "MinMissedCleavages": 0,
  "MaxMissedCleavages": 2,
  "MaxMass": 15000.0,
  "MinPepLength": 4,
  "MaxPepLength": 65,
  "IsotopicMod": ["N15"],
  "MassMode": "Monoisotopic",
  "FixedMods": [],
  "VariableMods": ["Oxidation'Met'", "Acetylation'ProtNTerm'"],
  "VarModThreshold": 4
}
```

## Expert Tips and Best Practices

1. **Manage Search Space**: Keep `MaxMass` and `MaxPepLength` within realistic experimental bounds (e.g., 15000 Da and 65 amino acids) to maintain performance and reduce false discovery rates.
2. **Regex Precision**: Ensure the `ParseProteinIDRegexPattern` matches your FASTA header format. If your headers use Pipe-separated values (like UniProt), adjust the regex to capture the specific accession number.
3. **Modification Control**: High `VarModThreshold` values significantly increase the database size and search time. A threshold of 3 or 4 is generally sufficient for standard workflows.
4. **Downstream Compatibility**: The resulting SQLite database is specifically designed for use with `proteomiqon-peptidespectrummatching`. Ensure the `MassMode` selected here matches the settings used in subsequent search steps.

## Reference documentation
- [PeptideDB Tool Documentation](./references/csbiology_github_io_ProteomIQon_tools_PeptideDB.html.md)
- [ProteomIQon Overview](./references/csbiology_github_io_ProteomIQon.md)