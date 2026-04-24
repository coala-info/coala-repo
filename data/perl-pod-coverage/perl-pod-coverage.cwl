cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-coverage
label: perl-pod-coverage
doc: "Check POD coverage of Perl modules.\n\nTool homepage: https://github.com/richardc/perl-pod-coverage"
inputs:
  - id: module_names
    type:
      type: array
      items: string
    doc: Names of modules to check
    inputBinding:
      position: 1
  - id: color
    type:
      - 'null'
      - string
    doc: Colorize output (auto, always, never)
    inputBinding:
      position: 102
      prefix: --color
  - id: formatter
    type:
      - 'null'
      - string
    doc: Use a specific formatter (e.g., plain, html)
    inputBinding:
      position: 102
      prefix: --formatter
  - id: ignore_missing
    type:
      - 'null'
      - boolean
    doc: Do not report missing modules
    inputBinding:
      position: 102
      prefix: --ignore-missing
  - id: ignore_modules
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of modules to ignore
    inputBinding:
      position: 102
      prefix: --ignore-modules
  - id: list_formatters
    type:
      - 'null'
      - boolean
    doc: List available formatters
    inputBinding:
      position: 102
      prefix: --list-formatters
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursively check modules in subdirectories
    inputBinding:
      position: 102
      prefix: --recursive
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to a file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-coverage:0.23--pl5.22.0_0
