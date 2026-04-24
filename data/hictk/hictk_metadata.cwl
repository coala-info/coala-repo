cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk metadata
label: hictk_metadata
doc: "Print file metadata to stdout.\n\nTool homepage: https://github.com/paulsengroup/hictk"
inputs:
  - id: uri
    type: string
    doc: Path to a .hic or .[ms]cool file (Cooler URI syntax supported).
    inputBinding:
      position: 1
  - id: exclude_file_path
    type:
      - 'null'
      - boolean
    doc: Output the given input path using attribute "uri".
    inputBinding:
      position: 102
      prefix: --exclude-file-path
  - id: include_file_path
    type:
      - 'null'
      - boolean
    doc: Output the given input path using attribute "uri".
    inputBinding:
      position: 102
      prefix: --include-file-path
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Format used to return file metadata. Should be one of: json, toml, or yaml.'
    inputBinding:
      position: 102
      prefix: --output-format
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Print metadata for each resolution or cell contained in a 
      multi-resolution or single-cell file.
    inputBinding:
      position: 102
      prefix: --recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
stdout: hictk_metadata.out
