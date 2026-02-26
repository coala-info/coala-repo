cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/run.sh
label: pisad_run.sh
doc: "Runs the PISAD pipeline.\n\nTool homepage: https://github.com/ZhantianXu/PISAD"
inputs:
  - id: cutoff_threshold
    type:
      - 'null'
      - float
    doc: cutoff threshold
    default: 0.95
    inputBinding:
      position: 101
      prefix: -cutoff
  - id: dsk_dir
    type:
      - 'null'
      - Directory
    doc: Directory for dsk files
    default: current directory
    inputBinding:
      position: 101
      prefix: -d1
  - id: est_kmercov
    type:
      - 'null'
      - string
    doc: est_kmercov
    default: Estimated by algorithm
    inputBinding:
      position: 101
      prefix: -est
  - id: heterozygosity
    type: int
    doc: Heterozygosity parameter (0 for <1.2%, 1 otherwise)
    inputBinding:
      position: 101
      prefix: -m
  - id: initial_heterozygosity
    type:
      - 'null'
      - string
    doc: Initial heterozygosity
    default: 0/0.12
    inputBinding:
      position: 101
      prefix: -het
  - id: initial_rho
    type:
      - 'null'
      - float
    doc: Initial rho value
    default: 0.2
    inputBinding:
      position: 101
      prefix: -rho
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files (space-separated *.fastq or *.fastq.gz files, no quotes 
      needed)
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer-size
    default: 21
    inputBinding:
      position: 101
      prefix: -k
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "Output prefix (defaults: first input file's prefix)"
    inputBinding:
      position: 101
      prefix: -o
  - id: plot_output_dir
    type:
      - 'null'
      - Directory
    doc: Directory for output plot
    default: current directory
    inputBinding:
      position: 101
      prefix: -d2
  - id: set_left_boundary
    type:
      - 'null'
      - string
    doc: Left boundary of the heterozygous region
    default: Estimated by algorithm
    inputBinding:
      position: 101
      prefix: -setleft
  - id: set_right_boundary
    type:
      - 'null'
      - string
    doc: Right boundary of the heterozygous region
    default: Estimated by algorithm
    inputBinding:
      position: 101
      prefix: -setright
  - id: snp_output_dir
    type:
      - 'null'
      - Directory
    doc: Directory for SNP output
    default: current directory
    inputBinding:
      position: 101
      prefix: -d3
  - id: threads
    type:
      - 'null'
      - int
    doc: thread
    default: 8
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
stdout: pisad_run.sh.out
