cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_reads
label: fast5-research_filter_reads
doc: "Extract reads from multi-read .fast5 files.\n\nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs:
  - id: input
    type:
      - File
      - Directory
    doc: Path to input multi-read .fast5 files (or list of files).
    inputBinding:
      position: 101
  - id: output
    type: string
    doc: Output folder (must not exist).
    inputBinding:
      position: 102
  - id: filter
    type: File
    doc: A .tsv file with column `read_id` defining required reads. If a `filename`
      column is present, this will be used as the location of the read.
    inputBinding:
      position: 103
  - id: tsv_field
    type:
      - 'null'
      - string
    doc: Field name from `filter` file to obtain read IDs.
    inputBinding:
      position: 1
      prefix: --tsv_field
  - id: prefix
    type:
      - 'null'
      - string
    doc: Read file prefix.
    inputBinding:
      position: 1
      prefix: --prefix
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search recursively under `input` for source files.
    inputBinding:
      position: 1
      prefix: --recursive
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 1
      prefix: --workers
  - id: multi
    type:
      - 'null'
      - boolean
    doc: Output multi-read files.
    inputBinding:
      position: 1
      prefix: --multi
  - id: single
    type:
      - 'null'
      - boolean
    doc: Output single-read files (not implemented in the tool).
    inputBinding:
      position: 1
      prefix: --single
outputs:
  - id: output_dir
    type: Directory
    doc: Folder with the extracted multi-read .fast5 files.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
