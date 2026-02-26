cwlVersion: v1.2
class: CommandLineTool
baseCommand: python clair.py
label: clair_clair.py
doc: "Clair submodule invocator\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: submodule
    type: string
    doc: Submodule to invoke
    inputBinding:
      position: 1
  - id: submodule_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified submodule
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
stdout: clair_clair.py.out
