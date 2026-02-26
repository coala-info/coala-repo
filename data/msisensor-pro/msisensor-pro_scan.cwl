cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msisensor-pro
  - scan
label: msisensor-pro_scan
doc: "This module scan the reference genome to get microsatellites information. You
  need to input (-d) a reference file (*.fa or *.fasta), and you will get a microsatellites
  file (-o) for following analysis. If you use GRCh38.d1.vd1 , you can download the
  file on out github directly.\n\nTool homepage: https://github.com/xjtu-omics/msisensor-pro"
inputs:
  - id: context_length
    type:
      - 'null'
      - int
    doc: context length (5-32)
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
    doc: maximal length of microsatellite (1-32)
    default: 6
    inputBinding:
      position: 101
      prefix: -s
  - id: min_homopolymer_size
    type:
      - 'null'
      - int
    doc: minimal homopolymer(repeat unit length = 1) size
    default: 8
    inputBinding:
      position: 101
      prefix: -l
  - id: min_microsatellite_repeat_times
    type:
      - 'null'
      - int
    doc: minimal repeat times of microsatellite(repeat unit length>=2)
    default: 5
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
    doc: reference genome sequences file, *.fasta or *.fa format
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: output_file
    type: File
    doc: output homopolymers and microsatellites file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
