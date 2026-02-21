cwlVersion: v1.2
class: CommandLineTool
baseCommand: survindel2_run_classifier.py
label: survindel2_run_classifier.py
doc: "The provided text does not contain help information for survindel2_run_classifier.py;
  it contains container runtime error logs. No arguments could be extracted.\n\nTool
  homepage: https://github.com/kensung-lab/SurVIndel2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survindel2:1.1.4--h503566f_0
stdout: survindel2_run_classifier.py.out
