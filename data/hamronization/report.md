# hamronization CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hamronization_hamronize_abricate | PASS |  |
| hamronization_hamronize_amrfinderplus | PASS |  |
| hamronization_hamronize_amrplusplus | PASS |  |
| hamronization_hamronize_ariba | PASS |  |
| hamronization_hamronize_csstar | PASS |  |
| hamronization_hamronize_deeparg | PASS |  |
| hamronization_hamronize_fargene | PASS |  |
| hamronization_hamronize_groot | PASS |  |
| hamronization_hamronize_kmerresistance | PASS |  |
| hamronization_hamronize_mykrobe | PASS |  |
| hamronization_hamronize_resfams | PASS |  |
| hamronization_hamronize_resfinder | PASS |  |
| hamronization_hamronize_rgi | PASS |  |
| hamronization_hamronize_srax | PASS |  |
| hamronization_hamronize_srst2 | PASS |  |
| hamronization_hamronize_staramr | PASS |  |
| hamronization_hamronize_summarize | PASS |  |
| hamronization_hamronize_tbprofiler | PASS |  |

## hamronization_hamronize_summarize

### Tool Description
Concatenate and summarize AMR detection reports

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize summarize <options> <list of reports>

Concatenate and summarize AMR detection reports

positional arguments:
  hamronized_reports    list of hAMRonized reports

options:
  -h, --help            show this help message and exit
  -t, --summary_type {tsv,json,interactive}
                        Which summary report format to generate
  -o, --output OUTPUT   Output file path for summary
```

## hamronization_hamronize_abricate

### Tool Description
Applies hAMRonization specification to output(s) from abricate (OUTPUT.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py abricate <options>

Applies hAMRonization specification to output(s) from abricate (OUTPUT.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for abricate
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for abricate
```

## hamronization_hamronize_amrfinderplus

### Tool Description
Applies hAMRonization specification to output(s) from amrfinderplus (OUTPUT.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py amrfinderplus <options>

Applies hAMRonization specification to output(s) from amrfinderplus
(OUTPUT.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for amrfinderplus
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for amrfinderplus
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for
                        amrfinderplus
```

## hamronization_hamronize_amrplusplus

### Tool Description
Applies hAMRonization specification to output(s) from amrplusplus (gene.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py amrplusplus <options>

Applies hAMRonization specification to output(s) from amrplusplus (gene.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for amrplusplus
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for amrplusplus
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for
                        amrplusplus
```

## hamronization_hamronize_ariba

### Tool Description
Applies hAMRonization specification to output(s) from ariba (OUTDIR/OUTPUT.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py ariba <options>

Applies hAMRonization specification to output(s) from ariba
(OUTDIR/OUTPUT.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for ariba
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for ariba
  --reference_database_name REFERENCE_DATABASE_NAME
                        Input string containing the reference_database_name
                        for ariba
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for ariba
```

## hamronization_hamronize_csstar

### Tool Description
Applies hAMRonization specification to output(s) from csstar (OUTPUT.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py csstar <options>

Applies hAMRonization specification to output(s) from csstar (OUTPUT.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for csstar
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for csstar
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for csstar
  --reference_database_name REFERENCE_DATABASE_NAME
                        Input string containing the reference_database_name
                        for csstar
```

## hamronization_hamronize_deeparg

### Tool Description
Applies hAMRonization specification to output(s) from deeparg (OUTDIR/OUTPUT.mapping.ARG)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py deeparg <options>

Applies hAMRonization specification to output(s) from deeparg
(OUTDIR/OUTPUT.mapping.ARG)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for deeparg
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for deeparg
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for
                        deeparg
```

## hamronization_hamronize_fargene

### Tool Description
Applies hAMRonization specification to output(s) from fargene (retrieved-genes-*-hmmsearched.out)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py fargene <options>

Applies hAMRonization specification to output(s) from fargene (retrieved-
genes-*-hmmsearched.out)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for fargene
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for fargene
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for
                        fargene
```

## hamronization_hamronize_groot

### Tool Description
Applies hAMRonization specification to output(s) from groot (OUTPUT.tsv (from `groot report`))

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py groot <options>

Applies hAMRonization specification to output(s) from groot (OUTPUT.tsv (from
`groot report`))

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for groot
  --reference_database_name REFERENCE_DATABASE_NAME
                        Input string containing the reference_database_name
                        for groot
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for groot
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for groot
```

## hamronization_hamronize_kmerresistance

### Tool Description
Applies hAMRonization specification to output(s) from kmerresistance (OUTPUT.res)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py kmerresistance <options>

Applies hAMRonization specification to output(s) from kmerresistance
(OUTPUT.res)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for kmerresistance
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for kmerresistance
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for
                        kmerresistance
```

## hamronization_hamronize_resfams

### Tool Description
Applies hAMRonization specification to output(s) from resfams (resfams.tblout)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py resfams <options>

Applies hAMRonization specification to output(s) from resfams (resfams.tblout)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for resfams
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for resfams
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for
                        resfams
```

## hamronization_hamronize_resfinder

### Tool Description
Applies hAMRonization specification to output(s) from resfinder (data_resfinder.json)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py resfinder <options>

Applies hAMRonization specification to output(s) from resfinder
(data_resfinder.json)

positional arguments:
  report           Path to report(s)

options:
  -h, --help       show this help message and exit
  --format FORMAT  Output format (tsv or json)
  --output OUTPUT  Output location
```

## hamronization_hamronize_mykrobe

### Tool Description
Applies hAMRonization specification to output(s) from mykrobe (OUTPUT.json)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py mykrobe <options>

Applies hAMRonization specification to output(s) from mykrobe (OUTPUT.json)

positional arguments:
  report           Path to report(s)

options:
  -h, --help       show this help message and exit
  --format FORMAT  Output format (tsv or json)
  --output OUTPUT  Output location
```

## hamronization_hamronize_rgi

### Tool Description
Applies hAMRonization specification to output(s) from rgi (OUTPUT.txt or OUTPUT_bwtoutput.gene_mapping_data.txt)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py rgi <options>

Applies hAMRonization specification to output(s) from rgi (OUTPUT.txt or
OUTPUT_bwtoutput.gene_mapping_data.txt)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for rgi
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for rgi
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for rgi
```

## hamronization_hamronize_srax

### Tool Description
Applies hAMRonization specification to output(s) from srax (sraX_detected_ARGs.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py srax <options>

Applies hAMRonization specification to output(s) from srax
(sraX_detected_ARGs.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for srax
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for srax
  --reference_database_name REFERENCE_DATABASE_NAME
                        Input string containing the reference_database_name
                        for srax
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for srax
```

## hamronization_hamronize_srst2

### Tool Description
Applies hAMRonization specification to output(s) from srst2 (OUTPUT_srst2_report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py srst2 <options>

Applies hAMRonization specification to output(s) from srst2
(OUTPUT_srst2_report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for srst2
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for srst2
  --input_file_name INPUT_FILE_NAME
                        Input string containing the input_file_name for srst2
```

## hamronization_hamronize_staramr

### Tool Description
Applies hAMRonization specification to output(s) from staramr (resfinder.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py staramr <options>

Applies hAMRonization specification to output(s) from staramr (resfinder.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  --format FORMAT       Output format (tsv or json)
  --output OUTPUT       Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Input string containing the analysis_software_version
                        for staramr
  --reference_database_version REFERENCE_DATABASE_VERSION
                        Input string containing the reference_database_version
                        for staramr
```

## hamronization_hamronize_tbprofiler

### Tool Description
Applies hAMRonization specification to output(s) from tbprofiler (OUTPUT.results.json)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize.py tbprofiler <options>

Applies hAMRonization specification to output(s) from tbprofiler
(OUTPUT.results.json)

positional arguments:
  report           Path to report(s)

options:
  -h, --help       show this help message and exit
  --format FORMAT  Output format (tsv or json)
  --output OUTPUT  Output location
```

## Metadata
- **Skill**: generated
