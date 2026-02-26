cwlVersion: v1.2
class: CommandLineTool
baseCommand: parallel-virfinder.py
label: parallel-virfinder_parallel-virfinder.py
doc: "Execute virfinder on a FASTA file in parallel\n\nTool homepage: https://github.com/quadram-institute-bioscience/parallel-virfinder"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output and do not remove temporary files
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --input
  - id: max_p_value
    type:
      - 'null'
      - float
    doc: Maximum p-value
    default: 0.05
    inputBinding:
      position: 101
      prefix: --max-p-value
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum score
    default: 0.9
    inputBinding:
      position: 101
      prefix: --min-score
  - id: no_check
    type:
      - 'null'
      - boolean
    doc: Do not check dependencies at startup
    inputBinding:
      position: 101
      prefix: --no-check
  - id: parallel_processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes
    default: 4
    inputBinding:
      position: 101
      prefix: --parallel
  - id: save_fasta
    type:
      - 'null'
      - File
    doc: Save FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output CSV file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-virfinder:0.3.1--py310hdfd78af_0
