cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_sort
label: mercat_sort
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs regarding a container runtime failure.\n\nTool
  homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_sort.out
