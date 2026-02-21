cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_gromacs_genion
label: biobb_gromacs_genion
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a 'no space left on device' failure during image extraction. It does
  not contain the help text or usage information for the tool.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
stdout: biobb_gromacs_genion.out
