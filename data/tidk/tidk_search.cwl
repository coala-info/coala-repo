cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tidk
  - search
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
    type: string
    doc: Output directory to write files to
    inputBinding:
      position: 103
      prefix: --dir
  - id: log
    type:
      - 'null'
      - boolean
    doc: Output a log file
    inputBinding:
      position: 104
      prefix: --log
  - id: output_path
    type: string
    doc: Output filename for the TSVs (without extension)
    inputBinding:
      position: 105
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Telomeric repeat window table, written as <dir>/<output>_telomeric_repeat_windows.<extension>
    outputBinding:
      glob: $(inputs.dir_path)/$(inputs.output_path)_telomeric_repeat_windows.*
  - id: dir
    type: Directory
    doc: Output directory to write files to
    outputBinding:
      glob: $(inputs.dir_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file written as <dir>/<output>.log
    outputBinding:
      glob: $(inputs.dir_path)/$(inputs.output_path).log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
