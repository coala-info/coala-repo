cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat
label: mercat
doc: "The provided text does not contain help information for the tool 'mercat'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat.out
