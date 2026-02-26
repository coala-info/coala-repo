cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphtyper
label: graphtyper_genotype_lr
doc: "GraphTyper\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: reference_genome
    type: File
    doc: Reference genome in FASTA format.
    inputBinding:
      position: 1
  - id: advanced
    type:
      - 'null'
      - boolean
    doc: "Set to enable advanced options. See a list of all options (including\n \
      \     advanced) with 'graphtyper genotype_sv --advanced --help'"
    inputBinding:
      position: 102
      prefix: --advanced
  - id: log_file
    type:
      - 'null'
      - File
    doc: Set path to log file.
    inputBinding:
      position: 102
      prefix: --log
  - id: region
    type:
      - 'null'
      - string
    doc: Genomic region to genotype.
    inputBinding:
      position: 102
      prefix: --region
  - id: region_file
    type:
      - 'null'
      - File
    doc: File with genomic regions to genotype.
    inputBinding:
      position: 102
      prefix: --region_file
  - id: sam_file
    type:
      - 'null'
      - File
    doc: SAM/BAM/CRAM to analyze.
    inputBinding:
      position: 102
      prefix: --sam
  - id: sam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: File with SAM/BAM/CRAMs to analyze (one per line).
    inputBinding:
      position: 102
      prefix: --sams
  - id: threads
    type:
      - 'null'
      - int
    doc: Max. number of threads to use.
    default: 20
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 102
      prefix: --vverbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
