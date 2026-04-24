cwlVersion: v1.2
class: CommandLineTool
baseCommand: panisa_ISFinder_search.py
label: panisa_ISFinder_search.py
doc: "automate search IS homology in ISFinder from panISa output\n\nTool homepage:
  https://github.com/bvalot/panISa"
inputs:
  - id: file
    type: File
    doc: PanISa result files to merge
    inputBinding:
      position: 1
  - id: alignment
    type:
      - 'null'
      - int
    doc: Percentage of expected alignment
    inputBinding:
      position: 102
      prefix: --alignment
  - id: evalue
    type:
      - 'null'
      - float
    doc: Expected max evalue
    inputBinding:
      position: 102
      prefix: --evalue
  - id: identity
    type:
      - 'null'
      - int
    doc: Percentage of expected identity
    inputBinding:
      position: 102
      prefix: --identity
  - id: length
    type:
      - 'null'
      - int
    doc: Length of the IRR-IRL search
    inputBinding:
      position: 102
      prefix: --length
  - id: remove
    type:
      - 'null'
      - string
    doc: Remove suffix at the end of the filename
    inputBinding:
      position: 102
      prefix: --remove
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Return potential IS found in ISFinder (default:stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panisa:0.1.7--pyhdfd78af_0
