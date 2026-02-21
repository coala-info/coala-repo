cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_find
label: mercat_find
doc: "The provided text does not contain help information; it contains container runtime
  error messages indicating a failure to build the SIF image due to lack of disk space.\n
  \nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_find.out
