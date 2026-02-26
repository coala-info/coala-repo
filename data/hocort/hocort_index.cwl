cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hocort
  - index
label: hocort_index
doc: "build index/-es for supported tools\n\nTool homepage: https://github.com/ignasrum/hocort"
inputs:
  - id: tool
    type: string
    doc: 'tool to generate index for (available: bbmap, biobloom, bowtie2, bwamem2,
      hisat2, kraken2, minimap2)'
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: --debug
  - id: log_file
    type:
      - 'null'
      - File
    doc: path to log file
    inputBinding:
      position: 102
      prefix: --log-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet output (overrides -d/--debug)
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
stdout: hocort_index.out
