cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfapy-mergelinear
label: gfapy_gfapy-mergelinear
doc: "Merge linear paths in a GFA graph\n\nTool homepage: https://github.com/ggonnella/gfapy"
inputs:
  - id: filename
    type: File
    doc: Input GFA filename
    inputBinding:
      position: 1
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: do not show progress log
    inputBinding:
      position: 102
      prefix: --no-progress
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: redundant
    type:
      - 'null'
      - boolean
    doc: create redundant paths, similar to the contigs constructed by 
      Readjoiner
    inputBinding:
      position: 102
      prefix: --redundant
  - id: short_names
    type:
      - 'null'
      - boolean
    doc: use short names for merged segments
    inputBinding:
      position: 102
      prefix: --short
  - id: vlevel
    type:
      - 'null'
      - string
    doc: validation level
    inputBinding:
      position: 102
      prefix: --vlevel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
stdout: gfapy_gfapy-mergelinear.out
