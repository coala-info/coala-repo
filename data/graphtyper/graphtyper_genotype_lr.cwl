cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - genotype_lr
label: graphtyper_genotype_lr
doc: "(WIP) Run the camou long-read genotyping pipeline.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sam_files)
inputs:
  - id: reference_fasta
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: "Reference genome in FASTA format."
    inputBinding:
      position: 1
  - id: log
    type:
      - 'null'
      - string
    doc: "Set path to log file."
    inputBinding:
      position: 10
      prefix: "--log="
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Set to output verbose logging."
    inputBinding:
      position: 10
      prefix: "--verbose"
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: "Set to output very verbose logging."
    inputBinding:
      position: 10
      prefix: "--vverbose"
  - id: advanced
    type:
      - 'null'
      - boolean
    doc: "Set to enable advanced options."
    inputBinding:
      position: 10
      prefix: "--advanced"
  - id: output
    type: string
    default: sv_results
    doc: "Output directory."
    inputBinding:
      position: 10
      prefix: "--output="
      separate: false
  - id: region
    type:
      - 'null'
      - string
    doc: "Genomic region to genotype. Use region_file if you have more than one region."
    inputBinding:
      position: 10
      prefix: "--region="
      separate: false
  - id: region_file
    type:
      - 'null'
      - File
    doc: "File with a list of genomic regions to genotype (one per line)."
    inputBinding:
      position: 10
      prefix: "--region_file="
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: "Max. number of threads to use (default 20). Note that it is not possible to utilize more threads than input BAM/CRAMs."
    inputBinding:
      position: 10
      prefix: "--threads="
      separate: false
  - id: sam
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.bai
        required: false
    doc: "Input BAM/CRAM to analyze. If you have more than one file then create a list and use sams instead."
    inputBinding:
      position: 10
      prefix: "--sam="
      separate: false
  - id: sams
    type:
      - 'null'
      - File
    doc: "File with BAM/CRAM paths to analyze (one per line); list the files in sam_files as well so that the paths resolve."
    inputBinding:
      position: 10
      prefix: "--sams="
      separate: false
  - id: sam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "BAM/CRAM files (with indices) named in the sams list, staged in the working directory."
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the genotyped VCF files per contig and region
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_genotype_lr.out
