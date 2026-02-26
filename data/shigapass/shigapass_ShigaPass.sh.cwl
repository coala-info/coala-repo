cwlVersion: v1.2
class: CommandLineTool
baseCommand: ShigaPass.sh
label: shigapass_ShigaPass.sh
doc: "This tool is used to predict Shigella serotypes\n\nTool homepage: https://github.com/imanyass/ShigaPass/"
inputs:
  - id: databases_path
    type: Directory
    doc: Path to databases directory
    inputBinding:
      position: 101
      prefix: -p
  - id: initialize_databases
    type:
      - 'null'
      - boolean
    doc: Call the makeblastdb utility for databases initialisation (optional, 
      but required when running the script for the first time)
    inputBinding:
      position: 101
      prefix: -u
  - id: input_files
    type:
      type: array
      items: File
    doc: List of input file(s) (FASTA) with their path(s)
    inputBinding:
      position: 101
      prefix: -l
  - id: keep_subdirectories
    type:
      - 'null'
      - boolean
    doc: Do not remove subdirectories
    inputBinding:
      position: 101
      prefix: -k
  - id: output_directory
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 2
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shigapass:1.5.0--hdfd78af_0
stdout: shigapass_ShigaPass.sh.out
