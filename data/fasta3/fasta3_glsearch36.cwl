cwlVersion: v1.2
class: CommandLineTool
baseCommand: glsearch36
label: fasta3_glsearch36
doc: "The provided text is a system error message regarding a container runtime failure
  and does not contain help documentation or usage information for the tool.\n\nTool
  homepage: http://faculty.virginia.edu/wrpearson/fasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8--h779adbc_6
stdout: fasta3_glsearch36.out
