cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_gromacs_genrestr
label: biobb_gromacs_genrestr
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract a container image due to lack
  of disk space ('no space left on device').\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
stdout: biobb_gromacs_genrestr.out
