cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_reads
label: fast5-research_extract_reads
doc: "Bulk .fast5 to read .fast5 conversion.\n\nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs:
  - id: input
    type: File
    doc: Bulk .fast5 file for input.
    inputBinding:
      position: 101
  - id: output
    type: string
    doc: Output folder (must not exist).
    inputBinding:
      position: 102
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
    doc: Output single-read files.
    inputBinding:
      position: 1
      prefix: --single
  - id: flat
    type:
      - 'null'
      - boolean
    doc: Create all .fast5 files in one directory
    inputBinding:
      position: 1
      prefix: --flat
  - id: by_id
    type:
      - 'null'
      - boolean
    doc: Name single-read .fast5 files by read_id.
    inputBinding:
      position: 1
      prefix: --by_id
  - id: prefix
    type:
      - 'null'
      - string
    doc: Read file prefix.
    inputBinding:
      position: 1
      prefix: --prefix
  - id: channel_range
    type:
      - 'null'
      - type: array
        items: int
    doc: Channel range (inclusive), two values.
    inputBinding:
      position: 1
      prefix: --channel_range
  - id: summary
    type:
      - 'null'
      - File
    doc: Strand summary file containing at least columns channel, start_time and duration).
    inputBinding:
      position: 1
      prefix: --summary
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 1
      prefix: --workers
  - id: limit
    type:
      - 'null'
      - int
    doc: Limit reads per channel.
    inputBinding:
      position: 1
      prefix: --limit
outputs:
  - id: output_dir
    type: Directory
    doc: Folder with the extracted read .fast5 files.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
