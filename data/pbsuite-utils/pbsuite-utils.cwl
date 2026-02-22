cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbsuite-utils
label: pbsuite-utils
doc: The provided text does not contain help documentation or usage 
  instructions. It consists of system error messages indicating a failure to 
  pull or run a Singularity/Docker container due to insufficient disk space ('no
  space left on device').
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbsuite-utils:v15.8.24dfsg-3-deb-py2_cv1
stdout: pbsuite-utils.out
