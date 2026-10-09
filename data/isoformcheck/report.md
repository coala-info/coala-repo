# isoformcheck CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| isoformcheck_addgroup | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_addsample | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_addsamples | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_chisquare | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_comparesamples | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_contingencytable | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_exportallelesets | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_exportisoforms | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_initialize | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_liftover | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_listgroups | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_listsamples | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_removegroup | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_rename | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_stats | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |
| isoformcheck_validate | PASS | chained run on real Ensembl sequence: human INS/SST/IAPP regions as reference and chimp, gorilla and orangutan orthologous regions as sample haplotypes (repo has no test data); output content consistent across steps. |

## isoformcheck_addgroup

### Tool Description
Add a sample to a group

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck addgroup [-h] [--verbose [VERBOSE ...]] -db DATABASE
                             --sample SAMPLE --group GROUP

Add a sample to a group

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
  --sample SAMPLE       Name of sample (required)
  --group GROUP         Name of group (required)
```

## isoformcheck_addsample

### Tool Description
Add a new sample

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck addsample [-h] [--verbose [VERBOSE ...]] -i INPUT --name
                              NAME --haplotype HAPLOTYPE -db DATABASE
                              [--liftoff LIFTOFF] [--agc AGC] [-t THREADS]

Add a new sample

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -i INPUT, --input INPUT
                        Sequence file (required)
  --name NAME           Sample name
  --haplotype HAPLOTYPE
                        Sample haplotype
  -db DATABASE, --database DATABASE
                        Database folder
  --liftoff LIFTOFF     Path to liftoff
  --agc AGC             Path to agc
  -t THREADS, --threads THREADS
                        Number of threads
```

## isoformcheck_addsamples

### Tool Description
Add multiple new samples

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck addsamples [-h] [--verbose [VERBOSE ...]] -i INPUT -db
                               DATABASE [--liftoff LIFTOFF] [--agc AGC]
                               [-t THREADS] [--force]

Add multiple new samples

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -i INPUT, --input INPUT
                        Sample table file (required)
  -db DATABASE, --database DATABASE
                        Database folder
  --liftoff LIFTOFF     Path to liftoff
  --agc AGC             Path to agc
  -t THREADS, --threads THREADS
                        Number of threads
  --force               Force insert samples even if validation fails
```

## isoformcheck_chisquare

### Tool Description
Calculate chi squared P-values of group vs allele set

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck chisquare [-h] [--verbose [VERBOSE ...]] -db DATABASE
                              [--transcript TRANSCRIPT] [--group [GROUP ...]]
                              [--table TABLE] [-o OUTPUT]
                              [--include-gene-info]

Calculate chi squared P-values of group vs allele set

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
  --transcript TRANSCRIPT
                        Name of transcript. If no transcript is given, all
                        transcripts will be used.
  --group [GROUP ...]   Names of groups to include
  --table TABLE         Table with samples per group to include
  -o OUTPUT, --output OUTPUT
                        Output file (- for stdout) (default -)
  --include-gene-info   Include information about gene in the output table.
```

## isoformcheck_comparesamples

### Tool Description
Compare samples to database

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck comparesamples [-h] [--verbose [VERBOSE ...]] -db DATABASE
                                   --table TABLE [-o OUTPUT] [-t THREADS]
                                   [--liftoff LIFTOFF] [--force]

Compare samples to database

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
  --table TABLE         Table with novel samples to include
  -o OUTPUT, --output OUTPUT
                        Output prefix (default "result")
  -t THREADS, --threads THREADS
                        Number of threads
  --liftoff LIFTOFF     Path to liftoff
  --force               Force compare samples even if validation fails
```

## isoformcheck_contingencytable

### Tool Description
Create contingency tables

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck contingencytable [-h] [--verbose [VERBOSE ...]] -db
                                     DATABASE [--transcript TRANSCRIPT]
                                     [--group GROUP [GROUP ...]]
                                     [--table TABLE] [-o OUTPUT]
                                     [--include-gene-info]

Create contingency tables

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
  --transcript TRANSCRIPT
                        Name of transcript. If no transcript is given, all
                        transcripts will be used.
  --group GROUP [GROUP ...]
                        Names of groups (at least two required, multiple
                        possible)
  --table TABLE         Table with samples per group to include
  -o OUTPUT, --output OUTPUT
                        Output file (- for stdout) (default -)
  --include-gene-info   Include information about gene in the output table.
```

## isoformcheck_exportallelesets

### Tool Description
Export per-sample allele set table

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck exportallelesets [-h] [--verbose [VERBOSE ...]] -db
                                     DATABASE [--transcript TRANSCRIPT]
                                     [-o OUTPUT] [--include-gene-info]

Export per-sample allele set table

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
  --transcript TRANSCRIPT
                        Name of transcript. If no transcript is given, all
                        transcripts will be used.
  -o OUTPUT, --output OUTPUT
                        Output file (- for stdout) (default -)
  --include-gene-info   Include information about gene in the output table.
```

## isoformcheck_exportisoforms

### Tool Description
Export isoform table

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck exportisoforms [-h] [--verbose [VERBOSE ...]] -db DATABASE
                                   [--transcript TRANSCRIPT] [-o OUTPUT]
                                   [--include-gene-info]

Export isoform table

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
  --transcript TRANSCRIPT
                        Name of transcript. If no transcript is given, all
                        transcripts will be used.
  -o OUTPUT, --output OUTPUT
                        Output file (- for stdout) (default -)
  --include-gene-info   Include information about gene in the output table.
```

## isoformcheck_initialize

### Tool Description
Create new database

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck initialize [-h] [--verbose [VERBOSE ...]] -r
                               REFERENCE_GENOME -a ANNOTATION -db DATABASE
                               [--liftoff LIFTOFF] [--agc AGC] [-t THREADS]

Create new database

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -r REFERENCE_GENOME, --reference-genome REFERENCE_GENOME
                        Reference genome file (required)
  -a ANNOTATION, --annotation ANNOTATION
                        Reference annotation gff3 (required)
  -db DATABASE, --database DATABASE
                        Output database folder
  --liftoff LIFTOFF     Path to liftoff
  --agc AGC             Path to agc
  -t THREADS, --threads THREADS
                        Number of threads
```

## isoformcheck_liftover

### Tool Description
Lift over annotations to one haplotype

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck liftover [-h] [--verbose [VERBOSE ...]] -i INPUT -o OUTPUT
                             -db DATABASE [--liftoff LIFTOFF] [-t THREADS]

Lift over annotations to one haplotype

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -i INPUT, --input INPUT
                        Haplotype sequence file (required)
  -o OUTPUT, --output OUTPUT
                        Output annotation file
  -db DATABASE, --database DATABASE
                        Database folder
  --liftoff LIFTOFF     Path to liftoff
  -t THREADS, --threads THREADS
                        Number of threads
```

## isoformcheck_listgroups

### Tool Description
List all groups per samples

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck listgroups [-h] [--verbose [VERBOSE ...]] -db DATABASE
                               [-o OUTPUT]

List all groups per samples

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder
  -o OUTPUT, --output OUTPUT
                        Output file (- for stdout) (default -)
```

## isoformcheck_listsamples

### Tool Description
List all samples

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck listsamples [-h] [--verbose [VERBOSE ...]] -db DATABASE
                                [-o OUTPUT]

List all samples

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder
  -o OUTPUT, --output OUTPUT
                        Output file (- for stdout) (default -)
```

## isoformcheck_removegroup

### Tool Description
Remove a sample from a group

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck removegroup [-h] [--verbose [VERBOSE ...]] -db DATABASE
                                --sample SAMPLE --group GROUP

Remove a sample from a group

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
  --sample SAMPLE       Name of sample (required)
  --group GROUP         Name of group (required)
```

## isoformcheck_rename

### Tool Description
Rename isoforms according to coverage

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck rename [-h] [--verbose [VERBOSE ...]] -db DATABASE

Rename isoforms according to coverage

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
```

## isoformcheck_stats

### Tool Description
Print basic statistics about database

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck stats [-h] [--verbose [VERBOSE ...]] -db DATABASE

Print basic statistics about database

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
```

## isoformcheck_validate

### Tool Description
Check sample haplotype validity

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoformCheck validate [-h] [--verbose [VERBOSE ...]] -db DATABASE

Check sample haplotype validity

options:
  -h, --help            show this help message and exit
  --verbose [VERBOSE ...]
                        Print debug information
  -db DATABASE, --database DATABASE
                        Database folder (required)
```

## Metadata
- **Skill**: generated
