cwlVersion: v1.2
class: CommandLineTool
baseCommand: eido_convert
label: eido_convert
doc: "Convert PEP format using filters\n\nTool homepage: https://github.com/mayneyao/eidos"
inputs:
  - id: pep
    type: File
    doc: Path to a PEP configuration file in yaml format.
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Provide arguments to the filter function (e.g. arg1=val1 arg2=val2).
    inputBinding:
      position: 102
      prefix: --args
  - id: describe
    type:
      - 'null'
      - boolean
    doc: Show description for a given filter.
    inputBinding:
      position: 102
      prefix: --describe
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (name of filter; use -l to see available).
    inputBinding:
      position: 102
      prefix: --format
  - id: list
    type:
      - 'null'
      - boolean
    doc: List available filters.
    inputBinding:
      position: 102
      prefix: --list
  - id: paths
    type:
      - 'null'
      - type: array
        items: string
    doc: Paths to dump conversion result as key=value pairs.
    inputBinding:
      position: 102
      prefix: --paths
  - id: sample_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of the samples to inspect.
    inputBinding:
      position: 102
      prefix: --sample-name
  - id: st_index
    type:
      - 'null'
      - string
    doc: Sample table index to use, samples are identified by 'sample_name' by 
      default.
    inputBinding:
      position: 102
      prefix: --st-index
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/eido:0.1.9_cv2
stdout: eido_convert.out
