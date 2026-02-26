cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - clear_filters
label: tombo_clear_filters
doc: "Clear filters from FAST5 files in the specified directories.\n\nTool homepage:
  https://github.com/nanoporetech/tombo"
inputs:
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    default: RawGenomeCorrected_000
    inputBinding:
      position: 101
      prefix: --corrected-group
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 101
      prefix: --fast5-basedirs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
stdout: tombo_clear_filters.out
