cwlVersion: v1.2
class: CommandLineTool
baseCommand: libmems
label: libmems
doc: "A library for finding Maximal Exact Matches (MEMs) in DNA sequences. (Note:
  The provided text contains container runtime error messages rather than the tool's
  help documentation.)\n\nTool homepage: http://darlinglab.org/mauve/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libmems:1.6.0--h2df963e_4
stdout: libmems.out
