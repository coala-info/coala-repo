cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_xargs
label: mercat_xargs
doc: "The provided text contains error logs and environment information rather than
  help documentation. No arguments or tool descriptions could be extracted from the
  input.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_xargs.out
