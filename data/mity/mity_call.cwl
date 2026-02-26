cwlVersion: v1.2
class: CommandLineTool
baseCommand: mity_call
label: mity_call
doc: "BAM / CRAM files to run the analysis on. If --bam-file-list is included, this
  argument is the file containing the list of bam/cram files.\n\nTool homepage: https://github.com/KCCG/mity"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: BAM / CRAM files to run the analysis on. If --bam-file-list is 
      included, this argument is the file containing the list of bam/cram files.
    inputBinding:
      position: 1
  - id: bam_file_list
    type:
      - 'null'
      - boolean
    doc: Treat the file as a text file of BAM files to be processed. The path to
      each file should be on one row per bam file.
    inputBinding:
      position: 102
      prefix: --bam-file-list
  - id: custom_reference_fasta
    type:
      - 'null'
      - File
    doc: Specify custom reference fasta file
    inputBinding:
      position: 102
      prefix: --custom-reference-fasta
  - id: custom_reference_genome
    type:
      - 'null'
      - File
    doc: Specify custom reference genome file
    inputBinding:
      position: 102
      prefix: --custom-reference-genome
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enter debug mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate files
    inputBinding:
      position: 102
      prefix: --keep
  - id: min_alternate_count
    type:
      - 'null'
      - int
    doc: 'Require at least MIN_ALTERNATE_COUNT observations supporting an alternate
      allele within a single individual in order to evaluate the position. Default:
      4'
    default: 4
    inputBinding:
      position: 102
      prefix: --min-alternate-count
  - id: min_alternate_fraction
    type:
      - 'null'
      - float
    doc: 'Require at least MIN_ALTERNATE_FRACTION observations supporting an alternate
      allele within a single individual in the in order to evaluate the position.
      Default: 0.01, range = [0,1]'
    default: 0.01
    inputBinding:
      position: 102
      prefix: --min-alternate-fraction
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: 'Exclude alleles from analysis if their supporting base quality is less than
      MIN_BASE_QUALITY. Default: 24'
    default: 24
    inputBinding:
      position: 102
      prefix: --min-base-quality
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'Exclude alignments from analysis if they have a mapping quality less than
      MIN_MAPPING_QUALITY. Default: 30'
    default: 30
    inputBinding:
      position: 102
      prefix: --min-mapping-quality
  - id: normalise
    type:
      - 'null'
      - boolean
    doc: Run mity normalise the resulting VCF
    inputBinding:
      position: 102
      prefix: --normalise
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output files will be saved in OUTPUT_DIR. Default: '.'"
    default: .
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: p
    type:
      - 'null'
      - float
    doc: 'Minimum noise level. This is used to calculate QUAL score. Default: 0.002,
      range = [0,1]'
    default: 0.002
    inputBinding:
      position: 102
      prefix: --p
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output files will be named with PREFIX
    inputBinding:
      position: 102
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - string
    doc: 'Reference genome version to use. Default: hs37d5'
    default: hs37d5
    inputBinding:
      position: 102
      prefix: --reference
  - id: region
    type:
      - 'null'
      - string
    doc: 'Region of MT genome to call variants in. If unset will call variants in
      entire MT genome as specified in BAM header. Default: Entire MT genome.'
    inputBinding:
      position: 102
      prefix: --region
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
stdout: mity_call.out
