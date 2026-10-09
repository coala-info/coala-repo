cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_kreport.py
label: krakentools_make_kreport.py
doc: "Make a Kraken report file from a Kraken output file and a taxonomy file from make_ktaxonomy.py.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: kraken_file
    type: File
    doc: "Kraken output file (5 tab-delimited columns, taxid in 3rd column)"
    inputBinding:
      position: 1
      prefix: -i
  - id: taxonomy_file
    type: File
    doc: "Output taxonomy file from make_ktaxonomy.py"
    inputBinding:
      position: 1
      prefix: -t
  - id: use_read_len
    type:
      - 'null'
      - boolean
    doc: "Make report file using sum of read lengths [default: read counts]"
    inputBinding:
      position: 101
      prefix: --use-read-len
  - id: output_file_path
    type: string
    doc: "Output kraken report file"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: "Kraken report"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
