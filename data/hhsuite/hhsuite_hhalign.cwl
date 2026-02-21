cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhalign
label: hhsuite_hhalign
doc: "The provided text does not contain help information for hhalign, but rather
  a system error log indicating a failure to build a Singularity/Apptainer container
  due to lack of disk space.\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_hhalign.out
