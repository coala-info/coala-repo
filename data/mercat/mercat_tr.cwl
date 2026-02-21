cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_tr
label: mercat_tr
doc: "The provided text does not contain help information or usage instructions for
  mercat_tr. It contains system log messages and a fatal error regarding container
  image building (no space left on device).\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_tr.out
