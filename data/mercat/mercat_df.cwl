cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_df
label: mercat_df
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error message regarding container image building
  and disk space.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_df.out
