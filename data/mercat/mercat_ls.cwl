cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_ls
label: mercat_ls
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages and a fatal error regarding disk space during a
  container build.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_ls.out
