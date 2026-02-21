cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_chmod
label: mercat_chmod
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_chmod.out
