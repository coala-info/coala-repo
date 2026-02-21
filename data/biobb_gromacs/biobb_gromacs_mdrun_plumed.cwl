cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_gromacs_mdrun_plumed
label: biobb_gromacs_mdrun_plumed
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a failure to build a Singularity/Apptainer
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/bioexcel/biobb_gromacs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
stdout: biobb_gromacs_mdrun_plumed.out
