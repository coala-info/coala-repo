# binchicken CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| binchicken_build | Failed | image problem: every workflow step runs through pixi environments that are not in the image, and pixi fails to create them in the read-only site-packages folder (needs --no-read-only and network); build itself is the step that creates them. |
| binchicken_coassemble | Failed | image problem: every workflow step runs through pixi environments that are not in the image, and pixi fails to create them in the read-only site-packages folder (needs --no-read-only and network); command line parsed fine on repo test reads; singlem_metapackage and genome_singlem types fixed. |
| binchicken_evaluate | Failed | image problem: every workflow step runs through pixi environments that are not in the image, and pixi fails to create them in the read-only site-packages folder; command line parsed fine on the repo mock_coassemble test data. |
| binchicken_iterate | Failed | image problem: every workflow step runs through pixi environments that are not in the image, and pixi fails to create them in the read-only site-packages folder (needs --no-read-only and network); previous-run inputs fixed from string/File to File/Directory and bogus outputs removed. |
| binchicken_single | Failed | image problem: every workflow step runs through pixi environments that are not in the image, and pixi fails to create them in the read-only site-packages folder (needs --no-read-only and network); command line parsed fine on repo test reads; singlem_metapackage and genome_singlem types fixed. |
| binchicken_update | Failed | image problem: every workflow step runs through pixi environments that are not in the image, and pixi fails to create them in the read-only site-packages folder (needs --no-read-only and network); previous-run inputs fixed from string paths and bogus outputs to File/Directory inputs. |

## binchicken_coassemble

### Tool Description
Perform co-assembly of multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
- **Homepage**: https://github.com/aroneys/binchicken
- **Package**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-09-28
- **GitHub**: https://github.com/aroneys/binchicken
- **Stars**: N/A
### Original Help Text
```text
usage: binchicken coassemble [-h] [--forward FORWARD [FORWARD ...]]
                             [--forward-list FORWARD_LIST]
                             [--reverse REVERSE [REVERSE ...]]
                             [--reverse-list REVERSE_LIST]
                             [--genomes GENOMES [GENOMES ...]]
                             [--genomes-list GENOMES_LIST]
                             [--coassembly-samples COASSEMBLY_SAMPLES [COASSEMBLY_SAMPLES ...]]
                             [--coassembly-samples-list COASSEMBLY_SAMPLES_LIST]
                             [--anchor-samples ANCHOR_SAMPLES [ANCHOR_SAMPLES ...]]
                             [--anchor-samples-list ANCHOR_SAMPLES_LIST]
                             [--singlem-metapackage SINGLEM_METAPACKAGE]
                             [--sample-singlem SAMPLE_SINGLEM [SAMPLE_SINGLEM ...]]
                             [--sample-singlem-list SAMPLE_SINGLEM_LIST]
                             [--sample-singlem-dir SAMPLE_SINGLEM_DIR]
                             [--sample-query SAMPLE_QUERY [SAMPLE_QUERY ...]]
                             [--sample-query-list SAMPLE_QUERY_LIST]
                             [--sample-query-dir SAMPLE_QUERY_DIR]
                             [--sample-read-size SAMPLE_READ_SIZE]
                             [--genome-transcripts GENOME_TRANSCRIPTS [GENOME_TRANSCRIPTS ...]]
                             [--genome-transcripts-list GENOME_TRANSCRIPTS_LIST]
                             [--genome-singlem GENOME_SINGLEM]
                             [--taxa-of-interest TAXA_OF_INTEREST]
                             [--appraise-sequence-identity APPRAISE_SEQUENCE_IDENTITY]
                             [--min-sequence-coverage MIN_SEQUENCE_COVERAGE]
                             [--single-assembly]
                             [--exclude-coassemblies EXCLUDE_COASSEMBLIES [EXCLUDE_COASSEMBLIES ...]]
                             [--exclude-coassemblies-list EXCLUDE_COASSEMBLIES_LIST]
                             [--num-coassembly-samples NUM_COASSEMBLY_SAMPLES]
                             [--max-coassembly-samples MAX_COASSEMBLY_SAMPLES]
                             [--max-coassembly-size MAX_COASSEMBLY_SIZE]
                             [--max-recovery-samples MAX_RECOVERY_SAMPLES]
                             [--max-sample-combinations MAX_SAMPLE_COMBINATIONS]
                             [--abundance-weighted]
                             [--abundance-weighted-samples ABUNDANCE_WEIGHTED_SAMPLES [ABUNDANCE_WEIGHTED_SAMPLES ...]]
                             [--abundance-weighted-samples-list ABUNDANCE_WEIGHTED_SAMPLES_LIST]
                             [--kmer-precluster {never,large,always}]
                             [--precluster-distances PRECLUSTER_DISTANCES]
                             [--precluster-size PRECLUSTER_SIZE]
                             [--file-hierarchy {never,large,always}]
                             [--file-hierarchy-depth FILE_HIERARCHY_DEPTH]
                             [--file-hierarchy-chars FILE_HIERARCHY_CHARS]
                             [--prodigal-meta] [--assemble-unmapped] [--sra]
                             [--download-limit DOWNLOAD_LIMIT] [--run-qc]
                             [--unmapping-min-appraised UNMAPPING_MIN_APPRAISED]
                             [--unmapping-max-identity UNMAPPING_MAX_IDENTITY]
                             [--unmapping-max-alignment UNMAPPING_MAX_ALIGNMENT]
                             [--run-aviary]
                             [--prior-assemblies PRIOR_ASSEMBLIES]
                             [--cluster-submission]
                             [--aviary-speed {fast,comprehensive}]
                             [--assembly-strategy {dynamic,metaspades,megahit}]
                             [--aviary-gtdbtk-db AVIARY_GTDBTK_DB]
                             [--aviary-checkm2-db AVIARY_CHECKM2_DB]
                             [--aviary-metabuli-db AVIARY_METABULI_DB]
                             [--aviary-snakemake-profile AVIARY_SNAKEMAKE_PROFILE]
                             [--aviary-assemble-cores AVIARY_ASSEMBLE_CORES]
                             [--aviary-assemble-memory AVIARY_ASSEMBLE_MEMORY]
                             [--aviary-recover-cores AVIARY_RECOVER_CORES]
                             [--aviary-recover-memory AVIARY_RECOVER_MEMORY]
                             [--aviary-extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                             [--aviary-skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                             [--aviary-request-gpu] [--output OUTPUT]
                             [--cores CORES] [--dryrun]
                             [--snakemake-profile SNAKEMAKE_PROFILE]
                             [--local-cores LOCAL_CORES] [--retries RETRIES]
                             [--snakemake-args SNAKEMAKE_ARGS]
                             [--tmp-dir TMP_DIR] [--debug] [--version]
                             [--quiet] [--full-help] [--full-help-roff]
binchicken coassemble: error: argument -h/--help: ignored explicit argument 'elp'
```

## binchicken_single

### Tool Description
Perform single-sample assembly and binning

### Metadata
- **Docker Image**: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
- **Homepage**: https://github.com/aroneys/binchicken
- **Package**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Validation**: PASS

### Original Help Text
```text
usage: binchicken single [-h] [--forward FORWARD [FORWARD ...]]
                         [--forward-list FORWARD_LIST]
                         [--reverse REVERSE [REVERSE ...]]
                         [--reverse-list REVERSE_LIST]
                         [--genomes GENOMES [GENOMES ...]]
                         [--genomes-list GENOMES_LIST]
                         [--coassembly-samples COASSEMBLY_SAMPLES [COASSEMBLY_SAMPLES ...]]
                         [--coassembly-samples-list COASSEMBLY_SAMPLES_LIST]
                         [--anchor-samples ANCHOR_SAMPLES [ANCHOR_SAMPLES ...]]
                         [--anchor-samples-list ANCHOR_SAMPLES_LIST]
                         [--singlem-metapackage SINGLEM_METAPACKAGE]
                         [--sample-singlem SAMPLE_SINGLEM [SAMPLE_SINGLEM ...]]
                         [--sample-singlem-list SAMPLE_SINGLEM_LIST]
                         [--sample-singlem-dir SAMPLE_SINGLEM_DIR]
                         [--sample-query SAMPLE_QUERY [SAMPLE_QUERY ...]]
                         [--sample-query-list SAMPLE_QUERY_LIST]
                         [--sample-query-dir SAMPLE_QUERY_DIR]
                         [--sample-read-size SAMPLE_READ_SIZE]
                         [--genome-transcripts GENOME_TRANSCRIPTS [GENOME_TRANSCRIPTS ...]]
                         [--genome-transcripts-list GENOME_TRANSCRIPTS_LIST]
                         [--genome-singlem GENOME_SINGLEM]
                         [--taxa-of-interest TAXA_OF_INTEREST]
                         [--appraise-sequence-identity APPRAISE_SEQUENCE_IDENTITY]
                         [--min-sequence-coverage MIN_SEQUENCE_COVERAGE]
                         [--single-assembly]
                         [--exclude-coassemblies EXCLUDE_COASSEMBLIES [EXCLUDE_COASSEMBLIES ...]]
                         [--exclude-coassemblies-list EXCLUDE_COASSEMBLIES_LIST]
                         [--num-coassembly-samples NUM_COASSEMBLY_SAMPLES]
                         [--max-coassembly-samples MAX_COASSEMBLY_SAMPLES]
                         [--max-coassembly-size MAX_COASSEMBLY_SIZE]
                         [--max-recovery-samples MAX_RECOVERY_SAMPLES]
                         [--max-sample-combinations MAX_SAMPLE_COMBINATIONS]
                         [--abundance-weighted]
                         [--abundance-weighted-samples ABUNDANCE_WEIGHTED_SAMPLES [ABUNDANCE_WEIGHTED_SAMPLES ...]]
                         [--abundance-weighted-samples-list ABUNDANCE_WEIGHTED_SAMPLES_LIST]
                         [--kmer-precluster {never,large,always}]
                         [--precluster-distances PRECLUSTER_DISTANCES]
                         [--precluster-size PRECLUSTER_SIZE]
                         [--file-hierarchy {never,large,always}]
                         [--file-hierarchy-depth FILE_HIERARCHY_DEPTH]
                         [--file-hierarchy-chars FILE_HIERARCHY_CHARS]
                         [--prodigal-meta] [--assemble-unmapped] [--sra]
                         [--download-limit DOWNLOAD_LIMIT] [--run-qc]
                         [--unmapping-min-appraised UNMAPPING_MIN_APPRAISED]
                         [--unmapping-max-identity UNMAPPING_MAX_IDENTITY]
                         [--unmapping-max-alignment UNMAPPING_MAX_ALIGNMENT]
                         [--run-aviary] [--prior-assemblies PRIOR_ASSEMBLIES]
                         [--cluster-submission]
                         [--aviary-speed {fast,comprehensive}]
                         [--assembly-strategy {dynamic,metaspades,megahit}]
                         [--aviary-gtdbtk-db AVIARY_GTDBTK_DB]
                         [--aviary-checkm2-db AVIARY_CHECKM2_DB]
                         [--aviary-metabuli-db AVIARY_METABULI_DB]
                         [--aviary-snakemake-profile AVIARY_SNAKEMAKE_PROFILE]
                         [--aviary-assemble-cores AVIARY_ASSEMBLE_CORES]
                         [--aviary-assemble-memory AVIARY_ASSEMBLE_MEMORY]
                         [--aviary-recover-cores AVIARY_RECOVER_CORES]
                         [--aviary-recover-memory AVIARY_RECOVER_MEMORY]
                         [--aviary-extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                         [--aviary-skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                         [--aviary-request-gpu] [--output OUTPUT]
                         [--cores CORES] [--dryrun]
                         [--snakemake-profile SNAKEMAKE_PROFILE]
                         [--local-cores LOCAL_CORES] [--retries RETRIES]
                         [--snakemake-args SNAKEMAKE_ARGS] [--tmp-dir TMP_DIR]
                         [--debug] [--version] [--quiet] [--full-help]
                         [--full-help-roff]
binchicken single: error: argument -h/--help: ignored explicit argument 'elp'
```

## binchicken_update

### Tool Description
Update binchicken's databases and configurations.

### Metadata
- **Docker Image**: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
- **Homepage**: https://github.com/aroneys/binchicken
- **Package**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Validation**: PASS

### Original Help Text
```text
usage: binchicken update [-h] [--forward FORWARD [FORWARD ...]]
                         [--forward-list FORWARD_LIST]
                         [--reverse REVERSE [REVERSE ...]]
                         [--reverse-list REVERSE_LIST]
                         [--genomes GENOMES [GENOMES ...]]
                         [--genomes-list GENOMES_LIST]
                         [--coassembly-samples COASSEMBLY_SAMPLES [COASSEMBLY_SAMPLES ...]]
                         [--coassembly-samples-list COASSEMBLY_SAMPLES_LIST]
                         [--anchor-samples ANCHOR_SAMPLES [ANCHOR_SAMPLES ...]]
                         [--anchor-samples-list ANCHOR_SAMPLES_LIST] [--sra]
                         [--download-limit DOWNLOAD_LIMIT]
                         [--coassemble-output COASSEMBLE_OUTPUT]
                         [--coassemble-unbinned COASSEMBLE_UNBINNED]
                         [--coassemble-binned COASSEMBLE_BINNED]
                         [--coassemble-targets COASSEMBLE_TARGETS]
                         [--coassemble-elusive-edges COASSEMBLE_ELUSIVE_EDGES]
                         [--coassemble-elusive-clusters COASSEMBLE_ELUSIVE_CLUSTERS]
                         [--coassemble-summary COASSEMBLE_SUMMARY]
                         [--coassemblies COASSEMBLIES [COASSEMBLIES ...]]
                         [--coassemblies-list COASSEMBLIES_LIST]
                         [--assemble-unmapped] [--run-qc]
                         [--unmapping-min-appraised UNMAPPING_MIN_APPRAISED]
                         [--unmapping-max-identity UNMAPPING_MAX_IDENTITY]
                         [--unmapping-max-alignment UNMAPPING_MAX_ALIGNMENT]
                         [--run-aviary] [--prior-assemblies PRIOR_ASSEMBLIES]
                         [--cluster-submission]
                         [--aviary-speed {fast,comprehensive}]
                         [--assembly-strategy {dynamic,metaspades,megahit}]
                         [--aviary-gtdbtk-db AVIARY_GTDBTK_DB]
                         [--aviary-checkm2-db AVIARY_CHECKM2_DB]
                         [--aviary-metabuli-db AVIARY_METABULI_DB]
                         [--aviary-snakemake-profile AVIARY_SNAKEMAKE_PROFILE]
                         [--aviary-assemble-cores AVIARY_ASSEMBLE_CORES]
                         [--aviary-assemble-memory AVIARY_ASSEMBLE_MEMORY]
                         [--aviary-recover-cores AVIARY_RECOVER_CORES]
                         [--aviary-recover-memory AVIARY_RECOVER_MEMORY]
                         [--aviary-extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                         [--aviary-skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                         [--aviary-request-gpu] [--output OUTPUT]
                         [--cores CORES] [--dryrun]
                         [--snakemake-profile SNAKEMAKE_PROFILE]
                         [--local-cores LOCAL_CORES] [--retries RETRIES]
                         [--snakemake-args SNAKEMAKE_ARGS] [--tmp-dir TMP_DIR]
                         [--debug] [--version] [--quiet] [--full-help]
                         [--full-help-roff]
binchicken update: error: argument -h/--help: ignored explicit argument 'elp'
```

## binchicken_iterate

### Tool Description
Iterate through binning and assembly strategies.

### Metadata
- **Docker Image**: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
- **Homepage**: https://github.com/aroneys/binchicken
- **Package**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Validation**: PASS

### Original Help Text
```text
usage: binchicken iterate [-h] [--iteration ITERATION]
                          [--aviary-outputs AVIARY_OUTPUTS [AVIARY_OUTPUTS ...]]
                          [--new-genomes NEW_GENOMES [NEW_GENOMES ...]]
                          [--new-genomes-list NEW_GENOMES_LIST]
                          [--new-genome-singlem NEW_GENOME_SINGLEM]
                          [--elusive-clusters ELUSIVE_CLUSTERS [ELUSIVE_CLUSTERS ...]]
                          [--coassemble-output COASSEMBLE_OUTPUT]
                          [--coassemble-unbinned COASSEMBLE_UNBINNED]
                          [--coassemble-binned COASSEMBLE_BINNED]
                          [--checkm-version CHECKM_VERSION]
                          [--min-completeness MIN_COMPLETENESS]
                          [--max-contamination MAX_CONTAMINATION]
                          [--forward FORWARD [FORWARD ...]]
                          [--forward-list FORWARD_LIST]
                          [--reverse REVERSE [REVERSE ...]]
                          [--reverse-list REVERSE_LIST]
                          [--genomes GENOMES [GENOMES ...]]
                          [--genomes-list GENOMES_LIST]
                          [--coassembly-samples COASSEMBLY_SAMPLES [COASSEMBLY_SAMPLES ...]]
                          [--coassembly-samples-list COASSEMBLY_SAMPLES_LIST]
                          [--anchor-samples ANCHOR_SAMPLES [ANCHOR_SAMPLES ...]]
                          [--anchor-samples-list ANCHOR_SAMPLES_LIST]
                          [--singlem-metapackage SINGLEM_METAPACKAGE]
                          [--sample-singlem SAMPLE_SINGLEM [SAMPLE_SINGLEM ...]]
                          [--sample-singlem-list SAMPLE_SINGLEM_LIST]
                          [--sample-singlem-dir SAMPLE_SINGLEM_DIR]
                          [--sample-query SAMPLE_QUERY [SAMPLE_QUERY ...]]
                          [--sample-query-list SAMPLE_QUERY_LIST]
                          [--sample-query-dir SAMPLE_QUERY_DIR]
                          [--sample-read-size SAMPLE_READ_SIZE]
                          [--genome-transcripts GENOME_TRANSCRIPTS [GENOME_TRANSCRIPTS ...]]
                          [--genome-transcripts-list GENOME_TRANSCRIPTS_LIST]
                          [--genome-singlem GENOME_SINGLEM]
                          [--taxa-of-interest TAXA_OF_INTEREST]
                          [--appraise-sequence-identity APPRAISE_SEQUENCE_IDENTITY]
                          [--min-sequence-coverage MIN_SEQUENCE_COVERAGE]
                          [--single-assembly]
                          [--exclude-coassemblies EXCLUDE_COASSEMBLIES [EXCLUDE_COASSEMBLIES ...]]
                          [--exclude-coassemblies-list EXCLUDE_COASSEMBLIES_LIST]
                          [--num-coassembly-samples NUM_COASSEMBLY_SAMPLES]
                          [--max-coassembly-samples MAX_COASSEMBLY_SAMPLES]
                          [--max-coassembly-size MAX_COASSEMBLY_SIZE]
                          [--max-recovery-samples MAX_RECOVERY_SAMPLES]
                          [--max-sample-combinations MAX_SAMPLE_COMBINATIONS]
                          [--abundance-weighted]
                          [--abundance-weighted-samples ABUNDANCE_WEIGHTED_SAMPLES [ABUNDANCE_WEIGHTED_SAMPLES ...]]
                          [--abundance-weighted-samples-list ABUNDANCE_WEIGHTED_SAMPLES_LIST]
                          [--kmer-precluster {never,large,always}]
                          [--precluster-distances PRECLUSTER_DISTANCES]
                          [--precluster-size PRECLUSTER_SIZE]
                          [--file-hierarchy {never,large,always}]
                          [--file-hierarchy-depth FILE_HIERARCHY_DEPTH]
                          [--file-hierarchy-chars FILE_HIERARCHY_CHARS]
                          [--prodigal-meta] [--assemble-unmapped] [--sra]
                          [--download-limit DOWNLOAD_LIMIT] [--run-qc]
                          [--unmapping-min-appraised UNMAPPING_MIN_APPRAISED]
                          [--unmapping-max-identity UNMAPPING_MAX_IDENTITY]
                          [--unmapping-max-alignment UNMAPPING_MAX_ALIGNMENT]
                          [--run-aviary] [--prior-assemblies PRIOR_ASSEMBLIES]
                          [--cluster-submission]
                          [--aviary-speed {fast,comprehensive}]
                          [--assembly-strategy {dynamic,metaspades,megahit}]
                          [--aviary-gtdbtk-db AVIARY_GTDBTK_DB]
                          [--aviary-checkm2-db AVIARY_CHECKM2_DB]
                          [--aviary-metabuli-db AVIARY_METABULI_DB]
                          [--aviary-snakemake-profile AVIARY_SNAKEMAKE_PROFILE]
                          [--aviary-assemble-cores AVIARY_ASSEMBLE_CORES]
                          [--aviary-assemble-memory AVIARY_ASSEMBLE_MEMORY]
                          [--aviary-recover-cores AVIARY_RECOVER_CORES]
                          [--aviary-recover-memory AVIARY_RECOVER_MEMORY]
                          [--aviary-extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                          [--aviary-skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                          [--aviary-request-gpu] [--output OUTPUT]
                          [--cores CORES] [--dryrun]
                          [--snakemake-profile SNAKEMAKE_PROFILE]
                          [--local-cores LOCAL_CORES] [--retries RETRIES]
                          [--snakemake-args SNAKEMAKE_ARGS]
                          [--tmp-dir TMP_DIR] [--debug] [--version] [--quiet]
                          [--full-help] [--full-help-roff]
binchicken iterate: error: argument -h/--help: ignored explicit argument 'elp'
```

## binchicken_build

### Tool Description
Create dependency environments

### Metadata
- **Docker Image**: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
- **Homepage**: https://github.com/aroneys/binchicken
- **Package**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Validation**: PASS

### Original Help Text
```text
usage: binchicken build [-h] [--singlem-metapackage SINGLEM_METAPACKAGE]
                        [--checkm2-db CHECKM2_DB] [--gtdbtk-db GTDBTK_DB]
                        [--metabuli-db METABULI_DB]
                        [--set-tmp-dir SET_TMP_DIR] [--skip-aviary-envs]
                        [--build-gpu] [--download-databases] [--output OUTPUT]
                        [--cores CORES] [--dryrun]
                        [--snakemake-profile SNAKEMAKE_PROFILE]
                        [--local-cores LOCAL_CORES] [--retries RETRIES]
                        [--snakemake-args SNAKEMAKE_ARGS] [--tmp-dir TMP_DIR]
                        [--debug] [--version] [--quiet] [--full-help]
                        [--full-help-roff]

Create dependency environments

options:
  -h, --help            show this help message and exit
  --singlem-metapackage SINGLEM_METAPACKAGE
                        SingleM metapackage
  --checkm2-db CHECKM2_DB
                        CheckM2 database
  --gtdbtk-db GTDBTK_DB
                        GTDBtk release database (Only required if --aviary-
                        speed is set to {COMPREHENSIVE_AVIARY_MODE})
  --metabuli-db METABULI_DB
                        MetaBuli database (Only required with TaxVAMB extra
                        binner)
  --set-tmp-dir SET_TMP_DIR
                        Set temporary directory [default: /tmp]
  --skip-aviary-envs    Do not install Aviary subworkflow environments
  --build-gpu           Build GPU-friendly environments for certain binners in
                        Aviary recovery [default: do not]. Must be run on a
                        node with GPU access.
  --download-databases  Download databases if provided paths do not exist
  --output OUTPUT       Output directory [default: .]
  --cores CORES         Maximum number of cores to use [default: 1]
  --dryrun, --dry-run   dry run workflow
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.i
                        o/en/v7.32.3/executing/cli.html#profiles). Can be used
                        to submit rules as jobs to cluster engine (see https:/
                        /snakemake.readthedocs.io/en/v7.32.3/executing/cluster
                        .html).
  --local-cores LOCAL_CORES
                        Maximum number of cores to use on localrules when
                        running in cluster mode [default: 1]
  --retries RETRIES     Number of times to retry a failed job [default: 3].
  --snakemake-args SNAKEMAKE_ARGS
                        Additional commands to be supplied to snakemake in the
                        form of a space-prefixed single string e.g. " --quiet"
  --tmp-dir TMP_DIR     Path to temporary directory. [default: no default]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```

## binchicken_evaluate

### Tool Description
Evaluate coassembled bins

### Metadata
- **Docker Image**: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
- **Homepage**: https://github.com/aroneys/binchicken
- **Package**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-09-28
- **GitHub**: https://github.com/aroneys/binchicken
- **Stars**: N/A
### Original Help Text
```text
usage: binchicken evaluate [-h] [--coassemble-output COASSEMBLE_OUTPUT]
                           [--coassemble-unbinned COASSEMBLE_UNBINNED]
                           [--coassemble-binned COASSEMBLE_BINNED]
                           [--coassemble-targets COASSEMBLE_TARGETS]
                           [--coassemble-elusive-edges COASSEMBLE_ELUSIVE_EDGES]
                           [--coassemble-elusive-clusters COASSEMBLE_ELUSIVE_CLUSTERS]
                           [--coassemble-summary COASSEMBLE_SUMMARY]
                           [--aviary-outputs AVIARY_OUTPUTS [AVIARY_OUTPUTS ...]]
                           [--new-genomes NEW_GENOMES [NEW_GENOMES ...]]
                           [--new-genomes-list NEW_GENOMES_LIST]
                           [--coassembly-run COASSEMBLY_RUN]
                           [--singlem-metapackage SINGLEM_METAPACKAGE]
                           [--prodigal-meta] [--checkm-version CHECKM_VERSION]
                           [--min-completeness MIN_COMPLETENESS]
                           [--max-contamination MAX_CONTAMINATION] [--cluster]
                           [--cluster-ani CLUSTER_ANI]
                           [--genomes GENOMES [GENOMES ...]]
                           [--genomes-list GENOMES_LIST] [--output OUTPUT]
                           [--cores CORES] [--dryrun]
                           [--snakemake-profile SNAKEMAKE_PROFILE]
                           [--local-cores LOCAL_CORES] [--retries RETRIES]
                           [--snakemake-args SNAKEMAKE_ARGS]
                           [--tmp-dir TMP_DIR] [--debug] [--version] [--quiet]
                           [--full-help] [--full-help-roff]

Evaluate coassembled bins

Options:

Base input arguments:
--coassemble-output COASSEMBLE_OUTPUT
Output dir from coassemble subcommand

--coassemble-unbinned COASSEMBLE_UNBINNED
SingleM appraise unbinned output from Bin Chicken coassemble (alternative to
--coassemble-output)

--coassemble-binned COASSEMBLE_BINNED
SingleM appraise binned output from Bin Chicken coassemble (alternative to
--coassemble-output)

--coassemble-targets COASSEMBLE_TARGETS
Target sequences output from Bin Chicken coassemble (alternative to
--coassemble-output)

--coassemble-elusive-edges COASSEMBLE_ELUSIVE_EDGES
Elusive edges output from Bin Chicken coassemble (alternative to --coassemble-
output)

--coassemble-elusive-clusters COASSEMBLE_ELUSIVE_CLUSTERS
Elusive clusters output from Bin Chicken coassemble (alternative to
--coassemble-output)

--coassemble-summary COASSEMBLE_SUMMARY
Summary output from Bin Chicken coassemble (alternative to --coassemble-
output)

--aviary-outputs AVIARY_OUTPUTS [AVIARY_OUTPUTS ...]
Output dir from Aviary coassembly and recover commands produced by coassemble
subcommand

--new-genomes NEW_GENOMES [NEW_GENOMES ...]
New genomes to evaluate (alternative to --aviary-outputs, also requires
--coassembly-run)

--new-genomes-list NEW_GENOMES_LIST
New genomes to evaluate (alternative to --aviary-outputs, also requires
--coassembly-run) newline separated

--coassembly-run COASSEMBLY_RUN
Name of coassembly run to produce new genomes (alternative to --aviary-
outputs, also requires --new-genomes)

--singlem-metapackage SINGLEM_METAPACKAGE
SingleM metapackage for sequence searching

--prodigal-meta
Use prodigal "-p meta" argument (for testing)

Evaluation options:
--checkm-version CHECKM_VERSION
CheckM version to use to quality cutoffs [default: 2]

--min-completeness MIN_COMPLETENESS
Include bins with at least this minimum completeness [default: 70]

--max-contamination MAX_CONTAMINATION
Include bins with at most this maximum contamination [default: 10]

Cluster options:
--cluster
Cluster new and original genomes and report number of new clusters

--cluster-ani CLUSTER_ANI
Cluster using this sequence identity [default: 86%]

--genomes GENOMES [GENOMES ...]
Original genomes used as references for coassemble subcommand

--genomes-list GENOMES_LIST
Original genomes used as references for coassemble subcommand newline
separated

General options:
--output OUTPUT
Output directory [default: .]

--cores CORES
Maximum number of cores to use [default: 1]

--dryrun, --dry-run
dry run workflow

--snakemake-profile SNAKEMAKE_PROFILE
Snakemake profile (see
https://snakemake.readthedocs.io/en/v7.32.3/executing/cli.html#profiles). Can
be used to submit rules as jobs to cluster engine (see
https://snakemake.readthedocs.io/en/v7.32.3/executing/cluster.html).

--local-cores LOCAL_CORES
Maximum number of cores to use on localrules when running in cluster mode
[default: 1]

--retries RETRIES
Number of times to retry a failed job [default: 3].

--snakemake-args SNAKEMAKE_ARGS
Additional commands to be supplied to snakemake in the form of a space-
prefixed single string e.g. " --quiet"

--tmp-dir TMP_DIR
Path to temporary directory. [default: no default]

Other general options:
--debug
output debug information

--version
output version information and quit

--quiet
only output errors

--full-help
print longer help message

--full-help-roff
print longer help message in ROFF (manpage) format

Examples:
evaluate a completed coassembly
$ binchicken evaluate --coassemble-output coassemble_dir --aviary-outputs coassembly_0_dir ...
evaluate a completed coassembly by providing genomes directly
$ binchicken evaluate --coassemble-output coassemble_dir --new-genomes genome_1.fna ... --coassembly-run coassembly_0
```

## Metadata
- **Skill**: generated
