cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_read_list
label: samsifter_filter_read_list
doc: "Filtering reads by a list of QNAMES (read identifiers) given in a tab-separated CSV file.\n\nTool homepage: https://github.com/BioInf-Wuerzburg/SamSifter"
inputs:
  - id: input_sam
    type: File
    doc: "SAM file to be analysed (default: STDIN)"
    inputBinding:
      position: 1
      prefix: -i
  - id: list
    type: File
    doc: "tab-separated CSV file with QNAMES in first column (.csv extension required)"
    inputBinding:
      position: 2
      prefix: -l
  - id: discard
    type:
      - 'null'
      - int
    doc: "keep or discard entries passing the filter criteria? (0 = discard, 1 = keep)"
    inputBinding:
      position: 3
      prefix: --discard
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print additional information to STDERR"
    inputBinding:
      position: 4
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "print debug messages to STDERR"
    inputBinding:
      position: 5
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the processed SAM)
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter_filter_read_list.out
stderr: samsifter_filter_read_list.err
