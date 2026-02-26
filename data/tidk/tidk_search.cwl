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
    default: tsv
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
    default: 10000
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: output
    type: File
    doc: Output filename for the TSVs (without extension)
    outputBinding:
      glob: $(inputs.output)
  - id: dir
    type: Directory
    doc: Output directory to write files to
    outputBinding:
      glob: $(inputs.dir)
  - id: log
    type:
      - 'null'
      - File
    doc: Output a log file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
