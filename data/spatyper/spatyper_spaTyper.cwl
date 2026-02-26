cwlVersion: v1.2
class: CommandLineTool
baseCommand: spaTyper
label: spatyper_spaTyper
doc: "Get spa types\n\nTool homepage: https://github.com/HCGB-IGTP/spaTyper"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Developer messages
    inputBinding:
      position: 101
      prefix: --debug
  - id: do_enrich
    type:
      - 'null'
      - boolean
    doc: Do PCR product enrichment.
    default: false
    inputBinding:
      position: 101
      prefix: --do_enrich
  - id: fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: List of one or more fasta files.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: folder
    type:
      - 'null'
      - Directory
    doc: Folder to save downloaded files from Ridom/Spa server
    inputBinding:
      position: 101
      prefix: --folder
  - id: glob
    type:
      - 'null'
      - string
    doc: "Uses unix style pathname expansion to run spa typing\n                 \
      \       on all files. If your shell autoexpands wildcards use\n            \
      \            -f."
    inputBinding:
      position: 101
      prefix: --glob
  - id: info
    type:
      - 'null'
      - boolean
    doc: Prints additional information
    inputBinding:
      position: 101
      prefix: --info
  - id: output
    type:
      - 'null'
      - string
    doc: "Provide a name for the output file. Default: Standard\n                \
      \        out"
    inputBinding:
      position: 101
      prefix: --output
  - id: repeat_file
    type:
      - 'null'
      - File
    doc: "List of spa repeats\n                        (http://spa.ridom.de/dynamic/sparepeats.fasta)"
    inputBinding:
      position: 101
      prefix: --repeat_file
  - id: repeat_order_file
    type:
      - 'null'
      - File
    doc: "List spa types and order of repeats\n                        (http://spa.ridom.de/dynamic/spatypes.txt)"
    inputBinding:
      position: 101
      prefix: --repeat_order_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spatyper:0.3.3--pyhdfd78af_3
stdout: spatyper_spaTyper.out
