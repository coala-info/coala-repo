cwlVersion: v1.2
class: CommandLineTool
baseCommand: sibsim4
label: sibsim4
doc: sibsim4 is a tool for spliced alignment of cDNA/EST sequences to genomic 
  DNA. It is a modified version of the sim4 algorithm.
inputs:
  - id: genomic_sequence
    type: File
    doc: Genomic sequence file (FASTA)
    inputBinding:
      position: 1
  - id: cdna_sequence
    type: File
    doc: cDNA/EST sequence file (FASTA)
    inputBinding:
      position: 2
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Cutoff value
    inputBinding:
      position: 103
      prefix: -C
  - id: msp_threshold
    type:
      - 'null'
      - int
    doc: MSP threshold for the first stage
    inputBinding:
      position: 103
      prefix: -K
  - id: output_format
    type:
      - 'null'
      - int
    doc: Output format (0-4)
    inputBinding:
      position: 103
      prefix: -A
  - id: reverse_complement
    type:
      - 'null'
      - int
    doc: Search the reverse complement of the second sequence as well (0=no, 
      1=yes)
    inputBinding:
      position: 103
      prefix: -R
  - id: splice_sites
    type:
      - 'null'
      - int
    doc: Use splice site information (0=no, 1=yes)
    inputBinding:
      position: 103
      prefix: -S
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size
    inputBinding:
      position: 103
      prefix: -W
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sibsim4:v0.20-4-deb_cv1
