cwlVersion: v1.2
class: CommandLineTool
baseCommand: priorcons
label: priorcons
doc: "Prioritizing conserved elements (Note: The provided text is a container build
  error log and does not contain usage information or argument definitions).\n\nTool
  homepage: https://github.com/GERMAN00VP/priorcons"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/priorcons:0.1.0--pyhdfd78af_0
stdout: priorcons.out
