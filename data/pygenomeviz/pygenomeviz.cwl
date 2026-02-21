cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygenomeviz
label: pygenomeviz
doc: "A genome visualization tool for drawing genome track diagrams.\n\nTool homepage:
  https://github.com/moshi4/pyGenomeViz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
stdout: pygenomeviz.out
