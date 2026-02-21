cwlVersion: v1.2
class: CommandLineTool
baseCommand: capcruncher
label: capcruncher
doc: "Capture-C and Tri-C analysis pipeline\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
stdout: capcruncher.out
