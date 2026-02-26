cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk
label: hictk_multi-resolution
doc: "Blazing fast tools to work with .hic and .cool files.\n\nTool homepage: https://github.com/paulsengroup/hictk"
inputs:
  - id: help_build_meta
    type:
      - 'null'
      - boolean
    doc: Print information regarding hictk's build options and third-party 
      dependencies, and exit.
    inputBinding:
      position: 101
      prefix: --help-build-meta
  - id: help_cite
    type:
      - 'null'
      - boolean
    doc: Print hictk's citation in Bibtex format and exit.
    inputBinding:
      position: 101
      prefix: --help-cite
  - id: help_docs
    type:
      - 'null'
      - boolean
    doc: Print the URL to hictk's documentation and exit.
    inputBinding:
      position: 101
      prefix: --help-docs
  - id: help_license
    type:
      - 'null'
      - boolean
    doc: Print the hictk license and exit.
    inputBinding:
      position: 101
      prefix: --help-license
  - id: help_telemetry
    type:
      - 'null'
      - boolean
    doc: Print information regarding telemetry collection and exit.
    inputBinding:
      position: 101
      prefix: --help-telemetry
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
stdout: hictk_multi-resolution.out
