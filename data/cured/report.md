# cured CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cured_CURED_FindREs.py | PASS | Ran on 30 k-mers from CURED_Main with the repo example genomes and an enzyme list; reports are complete (note: with the default all-NEB enzyme set this version crashes with IndexError when blastn finds no hit). |
| cured_CURED_Main.py | PASS | Found 967 k-mers present in all 5 case and no control genomes of the repo example data; spot check of 20 k-mers against the genomes agrees. |

## cured_CURED_FindREs.py

### Tool Description
This script is a part of the CURED pipeline. This script is used to find restriction enzyme sites in the identified k-mers.

### Metadata
- **Docker Image**: quay.io/biocontainers/cured:1.05--hdfd78af_0
- **Homepage**: https://github.com/microbialARC/CURED
- **Package**: https://anaconda.org/channels/bioconda/packages/cured/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cured/overview
- **Total Downloads**: 896
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/microbialARC/CURED
- **Stars**: N/A
### Original Help Text
```text
usage: CURED_FindREs.py [-h] [--case_control_file CASE_CONTROL_FILE]
                        [--specificity SPECIFICITY]
                        [--added_bases ADDED_BASES]
                        [--min_coverage MIN_COVERAGE] [--extension EXTENSION]
                        [--pcr_product_upstream PCR_PRODUCT_UPSTREAM]
                        [--pcr_product_downstream PCR_PRODUCT_DOWNSTREAM]
                        [--compare_coordinates] [--enzymes ENZYMES] [-help]
                        kmers genomes_folder

This script is a part of the CURED pipeline. This script is used to find
restriction enzyme sites in the identified k-mers.

positional arguments:
  kmers                 List of kmers to be searched.
  genomes_folder        Path to genomes.

options:
  -h, --help            show this help message and exit
  --case_control_file CASE_CONTROL_FILE
                        Csv file of cases and controls.
  --specificity SPECIFICITY, -S SPECIFICITY
                        Specificity for finding RE sites in controls. Default
                        = 100.
  --added_bases ADDED_BASES
                        Number of added bases on either end of the sequence.
                        Default = 20.
  --min_coverage MIN_COVERAGE
                        Minimum coverage threshold for sequence to be
                        considered found in controls. Default = 90.
  --extension EXTENSION, -x EXTENSION
                        Extension of input assemblies. Default = fna
  --pcr_product_upstream PCR_PRODUCT_UPSTREAM, -UP PCR_PRODUCT_UPSTREAM
                        Number of bases to include upstream of identified
                        k-mer in outputted PCR product.
  --pcr_product_downstream PCR_PRODUCT_DOWNSTREAM, -DOWN PCR_PRODUCT_DOWNSTREAM
                        Number of bases to include downstream of identified
                        k-mer in outputted PCR product.
  --compare_coordinates
                        Mode to compare RE by position to determine
                        uniqueness. Default is to determine uniqueness based
                        on presence/absence.
  --enzymes ENZYMES     Provide a file of restriction enzymes to be used.
                        Default is all enzymes supplied by NE Biolabs.
  -help                 Show this help message and exit.
```

## cured_CURED_Main.py

### Tool Description
This script is part of the CURED pipeline. This script is used for finding unique clonal biomarkers in your cases.

### Metadata
- **Docker Image**: quay.io/biocontainers/cured:1.05--hdfd78af_0
- **Homepage**: https://github.com/microbialARC/CURED
- **Package**: https://anaconda.org/channels/bioconda/packages/cured/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cured/overview
- **Total Downloads**: 896
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/microbialARC/CURED
- **Stars**: N/A
### Original Help Text
```text
usage: CURED_Main.py [-h] [--number_of_cases NUMBER_OF_CASES]
                     [--number_of_controls NUMBER_OF_CONTROLS]
                     [--threads THREADS]
                     [--case_control_file CASE_CONTROL_FILE]
                     [--sensitivity SENSITIVITY] [--specificity SPECIFICITY]
                     [--kmer_length KMER_LENGTH]
                     [--species SPECIES [SPECIES ...]]
                     [--sequence_type SEQUENCE_TYPE]
                     [--case_accession_list CASE_ACCESSION_LIST]
                     [--extension EXTENSION] [--database DATABASE] [--summary]
                     [--quiet] [--genomes_folder GENOMES_FOLDER]
                     [--case_genomes] [--use_datasets] [--use_simple]
                     [--kmer_list KMER_LIST] [-help]

This script is part of the CURED pipeline. This script is used for finding
unique clonal biomarkers in your cases.

options:
  -h, --help            show this help message and exit
  --number_of_cases NUMBER_OF_CASES, -cases NUMBER_OF_CASES
                        Add in the number of cases to be used in each
                        iteration.
  --number_of_controls NUMBER_OF_CONTROLS, -controls NUMBER_OF_CONTROLS
                        Add in the number of controls to be used in each
                        iteration.
  --threads THREADS, -T THREADS
                        Number of threads to be used for unitig-caller.
                        Default = 1.
  --case_control_file CASE_CONTROL_FILE
                        Csv file of genomes to be used with case or control
                        designation.
  --sensitivity SENSITIVITY
                        Specifiy sensitivity. Default = 100.
  --specificity SPECIFICITY
                        Specify specificity. Default = 100.
  --kmer_length KMER_LENGTH, -K KMER_LENGTH
                        Specify minimum length of k-mer to search for. Default
                        is 20.
  --species SPECIES [SPECIES ...]
                        Genus or species of interest
  --sequence_type SEQUENCE_TYPE, -st SEQUENCE_TYPE
                        sequence type of interest
  --case_accession_list CASE_ACCESSION_LIST
                        List of case accessions.
  --extension EXTENSION, -x EXTENSION
                        extension of assembly inputs. Ignore if using
                        --species/--sequence_type options. Default = fna
  --database DATABASE, -db DATABASE
                        Choose to download genomes from RefSeq, GenBank, or
                        both. Default = both.
  --summary             Check to see how many genomes will be downloaded if
                        you use the --species option. Use this option with
                        --database and --species options.
  --quiet, -q           No screen output. Default = OFF
  --genomes_folder GENOMES_FOLDER
                        Path to genomes.
  --case_genomes        Option if you have local sequencing data to serve as
                        the cases. Use --species to download control genomes.
  --use_datasets        Option to provide CURED with a case and control file
                        of ncbi accessions and downloaded them. Use with
                        --case_control_file
  --use_simple          Option to run unitig-caller simple mode. This is
                        useful for when you already have a list of k-mers that
                        you want to query against a set of genomes.
  --kmer_list KMER_LIST
                        List of k-mers to be used as query in running unitig-
                        caller simple mode
  -help                 Show this help message and exit.
```

## Metadata
- **Skill**: generated

