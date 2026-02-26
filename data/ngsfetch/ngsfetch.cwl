cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsfetch
label: ngsfetch
doc: "fast retrieval of metadata and fastq files with ffq and aria2c\n\nTool homepage:
  https://github.com/NaotoKubota/ngsfetch"
inputs:
  - id: attempts
    type:
      - 'null'
      - int
    doc: Number of attempts to fetch metadata and fastq files
    inputBinding:
      position: 101
      prefix: --attempts
  - id: id
    type:
      - 'null'
      - string
    doc: ID of the data to fetch
    inputBinding:
      position: 101
      prefix: --id
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes to use (up to 16)
    inputBinding:
      position: 101
      prefix: --processes
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsfetch:0.1.1--pyh7e72e81_0
stdout: ngsfetch.out
