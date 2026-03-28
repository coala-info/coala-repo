# binchicken CWL Generation Report

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


## binchicken_marker

### Tool Description
A command-line tool for binning chicken genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
- **Homepage**: https://github.com/aroneys/binchicken
- **Package**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Validation**: PASS

### Original Help Text
```text
usage: binchicken [-h] {coassemble,single,evaluate,update,iterate,build} ...
binchicken: error: argument subparser_name: invalid choice: 'marker' (choose from 'coassemble', 'single', 'evaluate', 'update', 'iterate', 'build')
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


## binchicken_by

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
- **Homepage**: https://github.com/aroneys/binchicken
- **Package**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: binchicken [-h] {coassemble,single,evaluate,update,iterate,build} ...
binchicken: error: argument subparser_name: invalid choice: 'by' (choose from 'coassemble', 'single', 'evaluate', 'update', 'iterate', 'build')
```


## binchicken_evaluate

### Tool Description
Evaluate binchicken results

### Metadata
- **Docker Image**: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
- **Homepage**: https://github.com/aroneys/binchicken
- **Package**: https://anaconda.org/channels/bioconda/packages/binchicken/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/binchicken", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.10/site-packages/binchicken/binchicken.py", line 1834, in main
    args = main_parser.parse_the_args()
  File "/usr/local/lib/python3.10/site-packages/bird_tool_utils/argparsing.py", line 218, in parse_the_args
    args = self._child_parser.parse_args()
  File "/usr/local/lib/python3.10/argparse.py", line 1833, in parse_args
    args, argv = self.parse_known_args(args, namespace)
  File "/usr/local/lib/python3.10/argparse.py", line 1866, in parse_known_args
    namespace, args = self._parse_known_args(args, namespace)
  File "/usr/local/lib/python3.10/argparse.py", line 2061, in _parse_known_args
    positionals_end_index = consume_positionals(start_index)
  File "/usr/local/lib/python3.10/argparse.py", line 2038, in consume_positionals
    take_action(action, args)
  File "/usr/local/lib/python3.10/argparse.py", line 1943, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/local/lib/python3.10/argparse.py", line 1221, in __call__
    subnamespace, arg_strings = parser.parse_known_args(arg_strings, None)
  File "/usr/local/lib/python3.10/argparse.py", line 1866, in parse_known_args
    namespace, args = self._parse_known_args(args, namespace)
  File "/usr/local/lib/python3.10/argparse.py", line 2079, in _parse_known_args
    start_index = consume_optional(start_index)
  File "/usr/local/lib/python3.10/argparse.py", line 2019, in consume_optional
    take_action(action, args, option_string)
  File "/usr/local/lib/python3.10/argparse.py", line 1943, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/local/lib/python3.10/argparse.py", line 1106, in __call__
    parser.print_help()
  File "/usr/local/lib/python3.10/argparse.py", line 2567, in print_help
    self._print_message(self.format_help(), file)
  File "/usr/local/lib/python3.10/argparse.py", line 2551, in format_help
    return formatter.format_help()
  File "/usr/local/lib/python3.10/argparse.py", line 283, in format_help
    help = self._root_section.format_help()
  File "/usr/local/lib/python3.10/argparse.py", line 214, in format_help
    item_help = join([func(*args) for func, args in self.items])
  File "/usr/local/lib/python3.10/argparse.py", line 214, in <listcomp>
    item_help = join([func(*args) for func, args in self.items])
  File "/usr/local/lib/python3.10/argparse.py", line 214, in format_help
    item_help = join([func(*args) for func, args in self.items])
  File "/usr/local/lib/python3.10/argparse.py", line 214, in <listcomp>
    item_help = join([func(*args) for func, args in self.items])
  File "/usr/local/lib/python3.10/argparse.py", line 540, in _format_action
    help_text = self._expand_help(action)
  File "/usr/local/lib/python3.10/argparse.py", line 637, in _expand_help
    return self._get_help_string(action) % params
ValueError: unsupported format character ']' (0x5d) at index 50
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


## Metadata
- **Skill**: generated
