cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bacpage
  - identify_files
label: bacpage_identify_files
doc: "Generate a valid sample_data.csv from a directory of FASTQs.\n\nTool homepage:
  https://github.com/CholGen/bacpage"
inputs:
  - id: directory
    type: Directory
    doc: location of FASTQ files
    default: .
    inputBinding:
      position: 1
  - id: delim
    type:
      - 'null'
      - string
    doc: deliminator to extract sample name from file name
    default: _
    inputBinding:
      position: 102
      prefix: --delim
  - id: index
    type:
      - 'null'
      - int
    doc: index of sample name after splitting file name by delim
    default: 0
    inputBinding:
      position: 102
      prefix: --index
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: location to save sample data
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
