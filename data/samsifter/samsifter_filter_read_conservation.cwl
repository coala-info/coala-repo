cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_read_conservation
label: samsifter_filter_read_conservation
doc: "Filters reads assigned to multiple taxa with similar identity. Excludes reads mapping to different accessions/taxa with similar alignment scores.\n\nTool homepage: https://github.com/BioInf-Wuerzburg/SamSifter"
inputs:
  - id: input_sam
    type: File
    doc: "SAM file to be analysed; it is read from standard input, because the -i option of this tool crashes"
  - id: discard
    type:
      - 'null'
      - int
    doc: "keep or discard entries passing the filter criteria? (0 = discard, 1 = keep)"
    inputBinding:
      position: 2
      prefix: --discard
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print additional information to STDERR"
    inputBinding:
      position: 3
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "print debug messages to STDERR"
    inputBinding:
      position: 4
      prefix: -d
  - id: modify
    type:
      - 'null'
      - boolean
    doc: "modify header by adding PG record"
    inputBinding:
      position: 5
      prefix: -m
  - id: as_dev
    type:
      - 'null'
      - int
    doc: "permitted deviation from max alignment score [5]"
    inputBinding:
      position: 6
      prefix: --as_dev
  - id: max_taxa
    type:
      - 'null'
      - int
    doc: "maximum number of taxa [10]"
    inputBinding:
      position: 7
      prefix: --max_taxa
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
stdout: samsifter_filter_read_conservation.out
stderr: samsifter_filter_read_conservation.err
stdin: $(inputs.input_sam.path)
