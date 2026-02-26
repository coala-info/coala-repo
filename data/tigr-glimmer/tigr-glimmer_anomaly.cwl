cwlVersion: v1.2
class: CommandLineTool
baseCommand: anomaly
label: tigr-glimmer_anomaly
doc: Read DNA sequence in <sequence-file> and for each region specified by the 
  coordinates in <coord-file>, check whether the region represents a normal 
  gene, i.e., it begins with a start codon, ends with a stop codon, and has no 
  frame shifts. Output goes to standard output.
inputs:
  - id: sequence_file
    type: File
    doc: DNA sequence file
    inputBinding:
      position: 1
  - id: coord_file
    type: File
    doc: Coordinate file specifying regions
    inputBinding:
      position: 2
  - id: check_preceding_stop_codon
    type:
      - 'null'
      - boolean
    doc: Check whether the codon preceding the start coordinate position is a 
      stop codon. This is useful if the coordinates represent the entire region 
      between stop codons.
    inputBinding:
      position: 103
      prefix: -t
  - id: omit_start_codon_check
    type:
      - 'null'
      - boolean
    doc: Omit the check that the first codon is a start codon.
    inputBinding:
      position: 103
      prefix: -s
  - id: start_codons
    type:
      - 'null'
      - string
    doc: Comma-separated list of codons to use as start codons
    default: atg,gtg,ttg
    inputBinding:
      position: 103
      prefix: -A
  - id: stop_codons
    type:
      - 'null'
      - string
    doc: Comma-separated list of codons to use as stop codons
    inputBinding:
      position: 103
      prefix: -Z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer_anomaly.out
