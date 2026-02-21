cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_join
label: mercat_join
doc: "The provided text does not contain help information for mercat_join; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_join.out
