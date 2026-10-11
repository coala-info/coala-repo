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
    type: string
    doc: ID of the data to fetch
    inputBinding:
      position: 101
      prefix: --id
  - id: output
    type: string
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
  - id: output_dir
    type: Directory
    doc: Output directory with the metadata and the FASTQ files
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsfetch:0.1.1--pyh7e72e81_0
