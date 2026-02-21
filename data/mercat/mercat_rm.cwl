cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_rm
label: mercat_rm
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of system log messages and a fatal error regarding container image
  conversion and disk space.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_rm.out
