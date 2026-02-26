cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - design
label: lyner_design
doc: "Description of the experiment. Expects 2-column tsv (Sample, Class).\n\nTool
  homepage: https://github.com/tedil/lyner"
inputs:
  - id: design
    type: File
    doc: 2-column tsv (Sample, Class) describing the experiment.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_design.out
