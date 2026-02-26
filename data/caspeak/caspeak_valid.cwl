cwlVersion: v1.2
class: CommandLineTool
baseCommand: caspeak_valid
label: caspeak_valid
doc: "Validate peaks\n\nTool homepage: https://github.com/Rye-lxy/CasPeak"
inputs:
  - id: lib
    type:
      - 'null'
      - string
    doc: the library (a set of closely related sequences) used to distinguish 
      true insertion from these related sequences
    inputBinding:
      position: 101
      prefix: --lib
  - id: min_asb_seq
    type:
      - 'null'
      - int
    doc: minimum number of assembled sequences
    default: 1
    inputBinding:
      position: 101
      prefix: --min-asb-seq
  - id: min_inslen
    type:
      - 'null'
      - int
    doc: minimum length of the MEI in the insert sequence
    default: 80
    inputBinding:
      position: 101
      prefix: --min-inslen
  - id: min_insprop
    type:
      - 'null'
      - float
    doc: minimum proportion of the MEI in the insert sequence
    default: 0.2
    inputBinding:
      position: 101
      prefix: --min-insprop
  - id: names
    type:
      - 'null'
      - string
    doc: names of the insertion sequences in the library
    inputBinding:
      position: 101
      prefix: --names
  - id: names_re
    type:
      - 'null'
      - string
    doc: regular expression to match the name of the insertion sequences
    inputBinding:
      position: 101
      prefix: --names-re
  - id: peak_bed
    type:
      - 'null'
      - File
    doc: peak BED file
    default: ./peak/peaks.bed
    inputBinding:
      position: 101
      prefix: --peak-bed
  - id: sample
    type:
      - 'null'
      - int
    doc: at most N reads are selected for assembly
    default: 20
    inputBinding:
      position: 101
      prefix: --sample
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
  - id: trim_read
    type:
      - 'null'
      - File
    doc: read FASTA file after trimming
    default: ./peak/trimmed_reads.fasta
    inputBinding:
      position: 101
      prefix: --trim-read
  - id: vcf
    type:
      - 'null'
      - boolean
    doc: output the validated result in VCF format
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress messages and data
    inputBinding:
      position: 101
      prefix: --verbose
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: working directory
    default: current directory
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caspeak:1.1.5--pyhdfd78af_0
stdout: caspeak_valid.out
