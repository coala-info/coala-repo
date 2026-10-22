cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtobt
label: smartdenovo_wtobt
doc: "WTOBT: Overlap based trimming (SMARTdenovo)\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: long_reads
    type:
      type: array
      items: File
      inputBinding:
        prefix: -i
    doc: "Long reads sequences file(s), +, *"
    inputBinding:
      position: 101
  - id: retained_region
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -b
    doc: "Long reads retained region, often from wtobt/wtcyc, +. Format: read_name\\toffset\\tlength\\toriginal_len"
    inputBinding:
      position: 101
  - id: overlap_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: -j
    doc: "Overlap file(s), +, *. Format: reads1\\t+/-\\tlen1\\tbeg1\\tend1\\treads2\\t+/-\\tlen2\\tbeg2\\tend2\\tscore\\tidentity\\tmat\\tmis\\tins\\tdel\\tcigar"
    inputBinding:
      position: 101
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwrite output file"
    inputBinding:
      position: 101
      prefix: -f
  - id: no_special_trim
    type:
      - 'null'
      - boolean
    doc: "Turn off special trim for reads contained by others"
    inputBinding:
      position: 101
      prefix: -C
  - id: min_score
    type:
      - 'null'
      - int
    doc: "Minimum score of alignment, [200]"
    inputBinding:
      position: 101
      prefix: -s
  - id: min_identity
    type:
      - 'null'
      - float
    doc: "Minimum identity of alignment, [0.5]"
    inputBinding:
      position: 101
      prefix: -m
  - id: max_margin
    type:
      - 'null'
      - int
    doc: "Maximum margin of alignment, [200]"
    inputBinding:
      position: 101
      prefix: -w
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "Minimum depth of overlap between anchored reads along reference read, to detect chimeric reads, [1]"
    inputBinding:
      position: 101
      prefix: -c
  - id: output_path
    type: string
    doc: "Output of reads' regions after trimming. Format: read_name\\toffset\\tlength"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type: File
    doc: "Reads' regions after trimming"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
