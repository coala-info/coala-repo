cwlVersion: v1.2
class: CommandLineTool
baseCommand: FAtoGDB
label: fastga_FAtoGDB
doc: "Converts FASTA files to a 1GDB database.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: source_path
    type: File
    doc: Path to the source FASTA file.
    inputBinding:
      position: 1
  - id: fa_extension
    type:
      - 'null'
      - string
    doc: Extension for FASTA files (e.g., .fa, .fna, .fasta, .gz).
    inputBinding:
      position: 2
  - id: one_code_extension
    type:
      - 'null'
      - string
    doc: Extension for 1-code sequence files.
    inputBinding:
      position: 3
  - id: target_path
    type:
      - 'null'
      - Directory
    doc: Path to the target 1GDB database. If not provided, it will be created 
      in the current directory.
    inputBinding:
      position: 4
  - id: runs_of_ns_to_as
    type:
      - 'null'
      - int
    doc: "Turn runs of n's of length < # into a's."
    inputBinding:
      position: 105
      prefix: -n
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 105
      prefix: -v
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Output log to specified file.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
