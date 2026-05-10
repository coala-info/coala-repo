cwlVersion: v1.2
class: CommandLineTool
baseCommand: tidk_search
label: tidk_search
doc: "Search the input genome with a specific telomeric repeat search string.\n\n\
  Tool homepage: https://github.com/tolkit/telomeric-identifier"
inputs:
  - id: fasta
    type: File
    doc: The input fasta file
    inputBinding:
      position: 1
  - id: extension
    type:
      - 'null'
      - string
    doc: The extension, defining the output type of the file
    inputBinding:
      position: 102
      prefix: --extension
  - id: string
    type: string
    doc: The DNA string to query the genome with
    inputBinding:
      position: 102
      prefix: --string
  - id: window
    type:
      - 'null'
      - int
    doc: Window size to calculate telomeric repeat counts in
    inputBinding:
      position: 102
      prefix: --window
  - id: dir_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `dir_path`
    inputBinding:
      position: 103
      prefix: --dir
  - id: log_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `log_path`
    inputBinding:
      position: 104
      prefix: --log
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 105
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output filename for the TSVs (without extension)
    outputBinding:
      glob: $(inputs.output_path)
  - id: dir
    type: Directory
    doc: Output directory to write files to
    outputBinding:
      glob: $(inputs.dir_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Output a log file
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
