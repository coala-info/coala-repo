cwlVersion: v1.2
class: CommandLineTool
baseCommand: sawfish joint-call
label: sawfish_joint-call
doc: "Merge and genotype SVs from one or more samples, given the discover command
  results from each\n\nTool homepage: https://github.com/PacificBiosciences/sawfish"
inputs:
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Overwrite an existing output directory
    inputBinding:
      position: 101
      prefix: --clobber
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Turn on extra debug logging\n          \n          This option enables extra
      logging intended for debugging only. It is highly recommended (but not required)
      to set --threads to 1 when this is enabled."
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_max_dapth_chrom_regex
    type:
      - 'null'
      - string
    doc: "Regex used to select chromosomes where max depth filtration is disabled\n\
      \          \n          Default value is intended to disable high depth filtration
      on mitochondria"
    default: (?i)^(chr)?(m|mt|mito|mitochondria)$
    inputBinding:
      position: 101
      prefix: --disable-max-dapth-chrom-regex
  - id: min_sv_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ value for reads to be used in joint-genotyping
    default: 5
    inputBinding:
      position: 101
      prefix: --min-sv-mapq
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory for all joint-call command output (must not already exist)
    default: sawfish_joint-call_output
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: ref
    type:
      - 'null'
      - File
    doc: Genome reference in FASTA format. If not specified, the reference path 
      from the first sample's discover command will be automatically selected 
      instead
    inputBinding:
      position: 101
      prefix: --ref
  - id: report_supporting_reads
    type:
      - 'null'
      - boolean
    doc: Create a JSON output file listing the reads supporting each variant
    inputBinding:
      position: 101
      prefix: --report-supporting-reads
  - id: sample_csv
    type:
      - 'null'
      - File
    doc: Sample csv file
    inputBinding:
      position: 101
      prefix: --sample-csv
  - id: sample_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Sample discover-mode results directory (required). Can be specified 
      multiple times to joint call over multiple samples
    inputBinding:
      position: 101
      prefix: --sample
  - id: skip_sample_input_check
    type:
      - 'null'
      - boolean
    doc: Skip checks on input sample discover directory contents
    inputBinding:
      position: 101
      prefix: --skip-sample-input-check
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Defaults to all logical cpus detected
    inputBinding:
      position: 101
      prefix: --threads
  - id: treat_single_copy_as_haploid
    type:
      - 'null'
      - boolean
    doc: "By default the SV caller ignores the expected copy number values (\"--expected-cn\"\
      \ argument in discover).\n          \n          With this option, all SVs in
      single copy regions are genotyped as haploid."
    inputBinding:
      position: 101
      prefix: --treat-single-copy-as-haploid
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
stdout: sawfish_joint-call.out
