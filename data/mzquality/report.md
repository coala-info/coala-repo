# mzquality CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mzquality_blank-effect | PASS | Per-batch blank effect table for PGE1-3 on the tool's example data. |
| mzquality_export-measurements | PASS | Samples vs. compounds table (228 samples, 3 compounds plus IS columns). |
| mzquality_internal-standard-rsd | PASS | RSDs for the 2 internal standards of the example data. |
| mzquality_plot-compound | PASS | Writes the plotly HTML plot PGE2.html. |
| mzquality_plot-compounds | PASS | Writes one plotly HTML plot per compound (3). |
| mzquality_plot-compounds-zipped | PASS | Zip file holds the 3 compound HTML plots. |
| mzquality_qc-correction | PASS | Adds the inter_median_qc_corrected column for all 980 measurements of the example data. |
| mzquality_qc-rsd | PASS | QC RSD values match an independent pandas computation on the QC corrected data. |
| mzquality_rep-rsd | PASS | Per-batch replicate RSDs (9-31%) for the 3 compounds. |
| mzquality_rt-shifts | PASS | One RT shift row per measurement (980 rows); shifts equal rt minus the batch mean. |
| mzquality_summary | PASS | Example data from the tool's repo (combined.tsv): JSON lists 3 batches, 227 samples, 3 compounds. |

## mzquality_blank-effect

### Tool Description
Calculate the blank effect of each compound.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        54
Docstring:   Calculate the blank effect of ... 

Usage:       qcli.py blank-effect MEA_FILE BLANK_EFFECT_FILE [BY_BATCH]
             qcli.py blank-effect --mea-file MEA_FILE --blank-effect-file BLANK_EFFECT_FILE [--by-batch BY_BATCH]
```

## mzquality_export-measurements

### Tool Description
Exports data as samples vs compounds.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        190
Docstring:   exports data as samples vs compounds

Usage:       qcli.py export-measurements FILE COLUMN EXPORT_LOCATION [INCLUDE_IS]
             qcli.py export-measurements --file FILE --column COLUMN --export-location EXPORT_LOCATION [--include-is INCLUDE_IS]
```

## mzquality_internal-standard-rsd

### Tool Description
Calculate the Internal Standard RSD's.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        129
Docstring:   Calculate the Internal Standard RSD's ... 

Usage:       qcli.py internal-standard-rsd QC_CORRECTED_FILE IS_RSD_FILE [BY_BATCH]
             qcli.py internal-standard-rsd --qc-corrected-file QC_CORRECTED_FILE --is-rsd-file IS_RSD_FILE [--by-batch BY_BATCH]
```

## mzquality_plot-compound

### Tool Description
Plot an individual compound.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        144
Docstring:   plot an individual compound 

Usage:       qcli.py plot-compound QC_CORRECTED_FILE COMPOUND PLOT_LOCATION
             qcli.py plot-compound --qc-corrected-file QC_CORRECTED_FILE --compound COMPOUND --plot-location PLOT_LOCATION
```

## mzquality_plot-compounds-zipped

### Tool Description
Plot a list of compounds and store them as a zip file.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        169
Docstring:   plot a list of compounds and store them as a zip file 

Usage:       qcli.py plot-compounds-zipped QC_CORRECTED_FILE ZIP_FILE
             qcli.py plot-compounds-zipped --qc-corrected-file QC_CORRECTED_FILE --zip-file ZIP_FILE
```

## mzquality_plot-compounds

### Tool Description
Plot a list of compounds.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        156
Docstring:   plot a list of compounds 

Usage:       qcli.py plot-compounds QC_CORRECTED_FILE PLOT_LOCATION
             qcli.py plot-compounds --qc-corrected-file QC_CORRECTED_FILE --plot-location PLOT_LOCATION
```

## mzquality_qc-correction

### Tool Description
Calculate the QC corrected data.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        84
Docstring:   Calculate the QC corrected data ... 

Usage:       qcli.py qc-correction MEA_FILE QC_CORRECTED_FILE
             qcli.py qc-correction --mea-file MEA_FILE --qc-corrected-file QC_CORRECTED_FILE
```

## mzquality_qc-rsd

### Tool Description
Calculate the QC RSD's.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        99
Docstring:   Calculate the QC RSD's ... 

Usage:       qcli.py qc-rsd QC_CORRECTED_FILE QC_RSD_FILE [BY_BATCH]
             qcli.py qc-rsd --qc-corrected-file QC_CORRECTED_FILE --qc-rsd-file QC_RSD_FILE [--by-batch BY_BATCH]
```

## mzquality_rep-rsd

### Tool Description
Calculate the Replicate RSD's.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        114
Docstring:   Calculate the Replicate RSD's ... 

Usage:       qcli.py rep-rsd QC_CORRECTED_FILE REP_RSD_FILE [BY_BATCH]
             qcli.py rep-rsd --qc-corrected-file QC_CORRECTED_FILE --rep-rsd-file REP_RSD_FILE [--by-batch BY_BATCH]
```

## mzquality_rt-shifts

### Tool Description
Calculate the RT shifts of each compound per batch.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        69
Docstring:   Calculate the RT shifts of each compound per batch ... 

Usage:       qcli.py rt-shifts MEA_FILE RT_SHIFTS_FILE
             qcli.py rt-shifts --mea-file MEA_FILE --rt-shifts-file RT_SHIFTS_FILE
```

## mzquality_summary

### Tool Description
Report a summary of the measurements (batches, samples and compounds) as JSON on standard output.

### Metadata
- **Docker Image**: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
- **Homepage**: https://github.com/hankemeierlab/mzQuality
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Type:        method
File:        /files/mzQuality/qcli.py
Line:        35
Docstring:   Report a summary of the measurements ... 

Usage:       qcli.py summary MEA_FILE
             qcli.py summary --mea-file MEA_FILE
```

## Metadata
- **Skill**: generated
