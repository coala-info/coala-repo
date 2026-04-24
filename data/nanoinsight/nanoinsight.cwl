cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoinsight
label: nanoinsight
doc: "NanoINSight is a repeat annotation tool for insertions called by NanoVar\n\n\
  Tool homepage: https://github.com/AsmaaSamyMohamedMahmoud/nanoinsight"
inputs:
  - id: input_vcf
    type: File
    doc: path to input VCF file
    inputBinding:
      position: 1
  - id: work_directory
    type: Directory
    doc: path to work directory
    inputBinding:
      position: 2
  - id: insfa_path
    type:
      - 'null'
      - File
    doc: specify path to ins_seq.fa file from NanoVar, otherwise assumed in work
      directory
    inputBinding:
      position: 103
      prefix: --insfa
  - id: mafft_path
    type:
      - 'null'
      - File
    doc: specify path to 'mafft' executable
    inputBinding:
      position: 103
      prefix: --mafftpath
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: hide verbose
    inputBinding:
      position: 103
      prefix: --quiet
  - id: repeatmasker_path
    type:
      - 'null'
      - File
    doc: specify path to 'RepeatMasker' executable
    inputBinding:
      position: 103
      prefix: --repmaskpath
  - id: species
    type: string
    doc: specify species for repeatmasker (e.g. human)
    inputBinding:
      position: 103
      prefix: --species
  - id: suptsv_path
    type:
      - 'null'
      - File
    doc: specify path to sv_support_reads.tsv file from NanoVar, otherwise 
      assumed in work directory
    inputBinding:
      position: 103
      prefix: --suptsv
  - id: threads
    type:
      - 'null'
      - int
    doc: specify number of threads
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoinsight:0.0.3--pyhdfd78af_0
stdout: nanoinsight.out
