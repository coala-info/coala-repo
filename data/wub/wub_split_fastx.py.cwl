cwlVersion: v1.2
class: CommandLineTool
baseCommand: split_fastx.py
label: wub_split_fastx.py
doc: "Split sequence records in file to one record per file or batches of records.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: in_format
    type:
      - 'null'
      - string
    doc: "Input format (fastq)."
    inputBinding:
      position: 1
      prefix: -i
  - id: out_format
    type:
      - 'null'
      - string
    doc: "Output format (fastq)."
    inputBinding:
      position: 2
      prefix: -o
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Batch size (None)."
    inputBinding:
      position: 3
      prefix: -b
  - id: input_fastx
    type: File
    doc: "Input file (default: stdin)."
    inputBinding:
      position: 100
  - id: output_dir
    type:
      - 'null'
      - string
    default: "split_fastx_out"
    doc: "Output directory (split_fastx_out; the tool needs it to exist, so the wrapper creates it)."
    inputBinding:
      position: 101
outputs:
  - id: split_files
    type:
      type: array
      items: File
    doc: "Files with one record or one batch of records each"
    outputBinding:
      glob: $(inputs.output_dir)/*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
