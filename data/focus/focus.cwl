cwlVersion: v1.2
class: CommandLineTool
baseCommand: focus
label: focus
doc: "An Agile Profiler for Metagenomic Data\n\nTool homepage: https://edwards.sdsu.edu/FOCUS"
inputs:
  - id: alternate_directory
    type:
      - 'null'
      - Directory
    doc: Alternate directory for your databases
    inputBinding:
      position: 101
      prefix: --alternate_directory
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size (6 or 7)
    inputBinding:
      position: 101
      prefix: --kmer_size
  - id: list_output
    type:
      - 'null'
      - boolean
    doc: Output results as a list
    inputBinding:
      position: 101
      prefix: --list_output
  - id: log
    type:
      - 'null'
      - File
    doc: Path to log file
    inputBinding:
      position: 101
      prefix: --log
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: query
    type: File
    doc: Path to FAST(A/Q) file or directory with these files.
    inputBinding:
      position: 101
      prefix: --query
  - id: threads
    type:
      - 'null'
      - int
    doc: Number Threads used in the k-mer counting
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_directory
    type: Directory
    doc: Path to output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/focus:1.8--pyhdfd78af_0
