cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygenetic_code
label: pygenetic_code
doc: "The provided text does not contain help information for the tool, as it is a
  log of a container execution failure.\n\nTool homepage: https://github.com/linsalrob/genetic_codes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenetic_code:0.20.0--py312he4a0461_0
stdout: pygenetic_code.out
