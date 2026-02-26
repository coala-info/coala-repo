cwlVersion: v1.2
class: CommandLineTool
baseCommand: msisensor_scan
label: msisensor_scan
doc: "Scan for homopolymers and microsatellites in a reference genome.\n\nTool homepage:
  https://github.com/ding-lab/msisensor"
inputs:
  - id: context_length
    type:
      - 'null'
      - int
    doc: context length
    default: 5
    inputBinding:
      position: 101
      prefix: -c
  - id: max_homopolymer_size
    type:
      - 'null'
      - int
    doc: maximal homopolymer size
    default: 50
    inputBinding:
      position: 101
      prefix: -m
  - id: max_microsatellite_length
    type:
      - 'null'
      - int
    doc: maximal length of microsate
    default: 5
    inputBinding:
      position: 101
      prefix: -s
  - id: min_homopolymer_size
    type:
      - 'null'
      - int
    doc: minimal homopolymer size
    default: 5
    inputBinding:
      position: 101
      prefix: -l
  - id: min_repeat_times
    type:
      - 'null'
      - int
    doc: minimal repeat times of microsate
    default: 3
    inputBinding:
      position: 101
      prefix: -r
  - id: output_homopolymer_only
    type:
      - 'null'
      - int
    doc: 'output homopolymer only, 0: no; 1: yes'
    default: 0
    inputBinding:
      position: 101
      prefix: -p
  - id: reference_genome
    type: File
    doc: reference genome sequences file, *.fasta format
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: output_file
    type: File
    doc: output homopolymer and microsatelittes file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor:0.5--hc755212_3
