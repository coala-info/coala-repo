cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pod5
  - convert
  - to_fast5
label: pod5_convert_to_fast5
doc: "Convert pod5 file(s) into fast5 file(s)\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input pod5 file(s)
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Output directory for the fast5 file(s)
    inputBinding:
      position: 102
      prefix: --output
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
    inputBinding:
      position: 102
      prefix: --recursive
  - id: threads
    type:
      - 'null'
      - int
    doc: 'How many file writers to keep active (default: 4)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite destination files
    inputBinding:
      position: 102
      prefix: --force-overwrite
  - id: file_read_count
    type:
      - 'null'
      - int
    doc: 'Number of reads to write per file (default: 4000)'
    inputBinding:
      position: 102
      prefix: --file-read-count
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Directory with the converted fast5 files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
stdout: pod5_convert_to_fast5.out
