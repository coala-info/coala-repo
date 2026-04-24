cwlVersion: v1.2
class: CommandLineTool
baseCommand: GIXmake
label: fastga_GIXmake
doc: "Builds a GIX index for a given source file.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: source_file
    type: File
    doc: Source file (can be a GIX database or a sequence file).
    inputBinding:
      position: 1
  - id: target_file
    type:
      - 'null'
      - File
    doc: Target GIX file (optional).
    inputBinding:
      position: 2
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: index k-mer size
    inputBinding:
      position: 103
      prefix: -k
  - id: log_file
    type:
      - 'null'
      - File
    doc: Output log to specified file.
    inputBinding:
      position: 103
      prefix: -L
  - id: seed_cutoff
    type:
      - 'null'
      - int
    doc: adaptive seed count cutoff
    inputBinding:
      position: 103
      prefix: -f
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    inputBinding:
      position: 103
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 103
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXmake.out
