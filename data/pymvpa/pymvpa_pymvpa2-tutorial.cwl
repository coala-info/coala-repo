cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymvpa2-tutorial
label: pymvpa_pymvpa2-tutorial
doc: "PyMVPA tutorial command. (Note: The provided text is a container runtime error
  log and does not contain usage instructions or argument definitions.)\n\nTool homepage:
  http://www.pymvpa.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymvpa:2.6.5--py36h355e19c_0
stdout: pymvpa_pymvpa2-tutorial.out
