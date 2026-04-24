cwlVersion: v1.2
class: CommandLineTool
baseCommand: fstic
label: fstic
doc: "Calculates pairwise genetic distances between samples using standard estimators.\n\
  \nTool homepage: https://github.com/PathoGenOmics-Lab/fstic"
inputs:
  - id: formula
    type:
      - 'null'
      - string
    doc: "The distance formula to use. [default: fst]  [possible values: fst, gst,
      nei,\nchord, bray-curtis, jost_d, reynolds, rogers]"
    inputBinding:
      position: 101
      prefix: --formula
  - id: min_af
    type:
      - 'null'
      - float
    doc: 'Minimum alternate allele frequency to keep a variant. [default: 0.05]'
    inputBinding:
      position: 101
      prefix: --min-af
  - id: min_alt_reads
    type:
      - 'null'
      - int
    doc: 'Minimum number of alternate allele reads to keep a variant. [default: 2]'
    inputBinding:
      position: 101
      prefix: --min-alt-reads
  - id: min_alt_rev_reads
    type:
      - 'null'
      - int
    doc: 'Minimum number of alternate allele reverse reads to keep a variant. [default:
      2]'
    inputBinding:
      position: 101
      prefix: --min-alt-rev-reads
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'Minimum total read depth to keep a variant. [default: 30]'
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: 'Normalize by the number of loci (affects: fst, chord, bray-curtis, jost_d).'
    inputBinding:
      position: 101
      prefix: --normalize
  - id: reference
    type: File
    doc: Reference FASTA file (required for all inputs).
    inputBinding:
      position: 101
      prefix: --reference
  - id: table_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'One or more input table files (format detected by extension: .csv, .tsv,
      .tab).'
    inputBinding:
      position: 101
      prefix: --table
  - id: table_list
    type:
      - 'null'
      - File
    doc: A file containing a list of input table files.
    inputBinding:
      position: 101
      prefix: --table-list
  - id: vcf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more input VCF files.
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcf_list
    type:
      - 'null'
      - File
    doc: A file containing a list of input VCF files.
    inputBinding:
      position: 101
      prefix: --vcf-list
  - id: workers
    type:
      - 'null'
      - int
    doc: 'Number of worker threads (default: all available cores).'
    inputBinding:
      position: 101
      prefix: --workers
outputs:
  - id: output_file
    type: File
    doc: Output file name for the distance matrix.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fstic:1.0.0--h4349ce8_0
