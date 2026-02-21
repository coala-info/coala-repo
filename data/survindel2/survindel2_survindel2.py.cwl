cwlVersion: v1.2
class: CommandLineTool
baseCommand: survindel2_survindel2.py
label: survindel2_survindel2.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime logs and a fatal error message regarding image
  fetching.\n\nTool homepage: https://github.com/kensung-lab/SurVIndel2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survindel2:1.1.4--h503566f_0
stdout: survindel2_survindel2.py.out
