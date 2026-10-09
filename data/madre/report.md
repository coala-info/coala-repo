# madre CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| madre | Not completed | pipeline, skipped: madre runs assembly, mapping and reduction steps and needs a large reference database |
| madre_calculate-abundances | PASS | synthetic data: read counts 120, 180 and 100 match the simulated reads; estimated abundances are plausible |
| madre_database-reduction | PASS | synthetic data: contigs from three real phage genomes; the reduced database keeps the three source genomes and drops the T7 variant |
| madre_read-classification | PASS | synthetic data: reads simulated from three real phage genomes; the 400 reads are classified to the right genomes (100, 180, 120) and clustered |

## madre

### Tool Description
MADRe

### Metadata
- **Docker Image**: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/lbcb-sci/MADRe
- **Package**: https://anaconda.org/channels/bioconda/packages/madre/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/madre/overview
- **Total Downloads**: 306
- **Last updated**: 2025-10-29
- **GitHub**: https://github.com/lbcb-sci/MADRe
- **Stars**: N/A
### Original Help Text
```text
usage: madre [-h] [--version] --out-folder OUT_FOLDER --reads READS
             [--reads_flag {pacbio,hifi,ont}] [--threads THREADS] [-F]
             [--config CONFIG] [--strictness {less-strict,strict,very-strict}]
             [--collapsed_strains_overhead COLLAPSED_STRAINS_OVERHEAD]
             [--min_contig_len MIN_CONTIG_LEN] [--use-myloasm USE_MYLOASM]

MADRe

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --out-folder OUT_FOLDER
                        Path to the output folder.
  --reads READS         Path to the reads file (fastq/fq can be gzipped).
  --reads_flag {pacbio,hifi,ont}
                        Reads technology. (default=ont)
  --threads THREADS     Number of threads (default=32).
  -F, --force           Force rerun all steps.
  --config CONFIG       Path to the configuration file. (default=./config.ini)
  --strictness {less-strict,strict,very-strict}
                        Database reduction strictness level. (default=very-
                        strict)
  --collapsed_strains_overhead COLLAPSED_STRAINS_OVERHEAD
                        Overhead for collapsed strains during database
                        reduction. (default=2)
  --min_contig_len MIN_CONTIG_LEN
                        Minimum contig length for database reduction.
                        (default=1000)
  --use-myloasm USE_MYLOASM
                        Use Myloasm assembler tool instead of
                        metaFlye/metaMDBG. (default=False)
```

## madre_read-classification

### Tool Description
MADRe read classification: assigns reads to reference strains from the PAF file of the assembly mapped to the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/lbcb-sci/MADRe
- **Package**: https://anaconda.org/channels/bioconda/packages/madre/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read-classification [-h] --paf_path PAF_PATH --strain_species_info
                           STRAIN_SPECIES_INFO
                           [--read_class_output READ_CLASS_OUTPUT]
                           [--clustering_out CLUSTERING_OUT]

MADRe.

options:
  -h, --help            show this help message and exit
  --paf_path PAF_PATH   Path to the PAF file of assembly mapped to database.
  --strain_species_info STRAIN_SPECIES_INFO
                        An additional parameter required if a custom database
                        path is provided. JSON file with info about species
                        taxid for every strain taxid in the database. If you
                        want to use default one provide path to
                        MADRe/database/taxids_species.json.
  --read_class_output READ_CLASS_OUTPUT
                        Path to the output file with classification labels for
                        reads. (default=read_classification.out)
  --clustering_out CLUSTERING_OUT
                        Path to clustering output directory. If provided
                        clustering using mapping info from --paf_path will be
                        performed, otherwise not.
```

## madre_database-reduction

### Tool Description
MADRe database reduction: selects the reference genomes supported by the assembly mapping and extracts them into a reduced database.

### Metadata
- **Docker Image**: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/lbcb-sci/MADRe
- **Package**: https://anaconda.org/channels/bioconda/packages/madre/overview
- **Validation**: PASS

### Original Help Text
```text
usage: database-reduction [-h] --database DATABASE --strain_species_info
                          STRAIN_SPECIES_INFO --paf_path PAF_PATH
                          --num_collapsed_strains NUM_COLLAPSED_STRAINS
                          --reduced_list_txt REDUCED_LIST_TXT
                          [--reduced_db REDUCED_DB]
                          [--mapping_class MAPPING_CLASS]
                          [--mapping_reduced_db MAPPING_REDUCED_DB]
                          [--threads THREADS]
                          [--strictness {less-strict,strict,very-strict}]
                          [--min_contig_len MIN_CONTIG_LEN]
                          [--collapsed_strains_overhead COLLAPSED_STRAINS_OVERHEAD]

MADRe.

options:
  -h, --help            show this help message and exit
  --database DATABASE   Path to the strating database file (fasta/fna).
  --strain_species_info STRAIN_SPECIES_INFO
                        An additional parameter required if a custom database
                        path is provided. JSON file with info about species
                        taxid for every strain taxid in the database. If you
                        want to use default one provide path to
                        MADRe/database/taxids_species.json.
  --paf_path PAF_PATH   Path to the PAF file of assembly mapped to database.
  --num_collapsed_strains NUM_COLLAPSED_STRAINS
                        File containing info about number of collapsed strains
                        for every contig (hairsplitter output).
  --reduced_list_txt REDUCED_LIST_TXT
                        Path to the file with list of genomes for reduced
                        database.
  --reduced_db REDUCED_DB
                        Path to the reduced database file (fasta).
  --mapping_class MAPPING_CLASS
                        Path to the output mapping contig classification.
  --mapping_reduced_db MAPPING_REDUCED_DB
                        Path to the output mapping reduced database.
  --threads THREADS     Number of threads (default=32).
  --strictness {less-strict,strict,very-strict}
                        Strictness of database reduction - choices: less-
                        strict, strict, very-strict - default: very-strict
  --min_contig_len MIN_CONTIG_LEN
                        Filter out contigs shorter than min_contig_len
                        (default=1000).
  --collapsed_strains_overhead COLLAPSED_STRAINS_OVERHEAD
                        Maximum overhead for number of collapsed strains per
                        contig estimated by HairSplitter (default=2).
```

## madre_calculate-abundances

### Tool Description
MADRe abundance calculation: read counts and estimated abundances per reference strain.

### Metadata
- **Docker Image**: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/lbcb-sci/MADRe
- **Package**: https://anaconda.org/channels/bioconda/packages/madre/overview
- **Validation**: PASS

### Original Help Text
```text
usage: calculate-abundances [-h] [--db DB] --reads READS --read_class
                            READ_CLASS [--rc_abundances_out RC_ABUNDANCES_OUT]
                            [--abundances_out ABUNDANCES_OUT]
                            [--clusters CLUSTERS]

MADRe.

options:
  -h, --help            show this help message and exit
  --db DB               Path to the database file (fasta). If
                        DatabaseReduction used - path to the reduced database.
                        WARNING: Required for estimated abundances
                        calculation.
  --reads READS         Path to the reads file (fastq/fasta, can be gziped).
  --read_class READ_CLASS
                        Path to the input file with classification labels for
                        reads from read classification step.
                        (default=read_classification.out)
  --rc_abundances_out RC_ABUNDANCES_OUT
                        Path to the output file with read count.
                        (default=rc_abundances.out)
  --abundances_out ABUNDANCES_OUT
                        Path to the output file with estimated abundances. If
                        path is not given this file is not going to be
                        generated. WARNING: In case of large sample and large
                        database that can be computationally exhaustive job.
  --clusters CLUSTERS   Path to dir that contains clusters.txt and
                        representatives.txt files. If provided, the abundances
                        in output files will be reported including cluster
                        information.
```
