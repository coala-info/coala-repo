cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanopore_simulation
label: nanopore_simulation
doc: "A tool for nanopore sequencing simulation. (Note: The provided help text contains
  only container runtime error messages and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/crohrandt/nanopore_simulation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopore_simulation:0.3--py36_0
stdout: nanopore_simulation.out
