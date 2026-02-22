cwlVersion: v1.2
class: CommandLineTool
baseCommand: scar
label: scar
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a Singularity container execution
  failure.\n\nTool homepage: https://github.com/Novartis/scAR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scar:0.7.0--pyhdfd78af_0
stdout: scar.out
