cwlVersion: v1.2
class: CommandLineTool
baseCommand: reframed
label: reframed
doc: "A Python package for metabolic modeling (Note: The provided text appears to
  be a container build log rather than CLI help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/cdanielmachado/reframed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reframed:1.6.0--pyhdfd78af_0
stdout: reframed.out
