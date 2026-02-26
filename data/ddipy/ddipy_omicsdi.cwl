cwlVersion: v1.2
class: CommandLineTool
baseCommand: omicsdi
label: ddipy_omicsdi
doc: "Command Line Interface to fetch data from OmicsDi.\n\nTool homepage: https://github.com/OmicsDI/ddipy"
inputs:
  - id: acc_number
    type: string
    doc: Accession Number
    inputBinding:
      position: 1
  - id: download
    type:
      - 'null'
      - boolean
    doc: Use this flag to download the files in the current directory or a 
      specified output directory
    inputBinding:
      position: 102
      prefix: --download
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: Output directory when downloading files
    default: CWD
    inputBinding:
      position: 102
      prefix: --input
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory when downloading files
    default: CWD
    inputBinding:
      position: 102
      prefix: --output
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use this flag to display th extensions
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddipy:0.0.5--py_0
stdout: ddipy_omicsdi.out
