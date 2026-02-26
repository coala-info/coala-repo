cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk validate
label: hictk_validate
doc: "Validate .hic and Cooler files.\n\nTool homepage: https://github.com/paulsengroup/hictk"
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
    default: false
    inputBinding:
      position: 102
      prefix: --exclude-file-path
  - id: exhaustive
    type:
      - 'null'
      - boolean
    doc: When processing multi-resolution or single-cell files, do not fail as 
      soon as the first error is detected.
    inputBinding:
      position: 102
      prefix: --exhaustive
  - id: fail_fast
    type:
      - 'null'
      - boolean
    doc: When processing multi-resolution or single-cell files, do not fail as 
      soon as the first error is detected.
    default: false
    inputBinding:
      position: 102
      prefix: --fail-fast
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
    doc: 'Format used to report the outcome of file validation. Should be one of:
      json, toml, or yaml.'
    default: json
    inputBinding:
      position: 102
      prefix: --output-format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print anything to stdout. Success/failure is reported through 
      exit codes.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: validate_index
    type:
      - 'null'
      - boolean
    doc: Validate Cooler index (may take a long time).
    inputBinding:
      position: 102
      prefix: --validate-index
  - id: validate_pixels
    type:
      - 'null'
      - boolean
    doc: Validate pixels found in Cooler files (may take a long time).
    inputBinding:
      position: 102
      prefix: --validate-pixels
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
stdout: hictk_validate.out
