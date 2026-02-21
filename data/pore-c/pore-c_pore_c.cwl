cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pore-c
  - pore_c
label: pore-c_pore_c
doc: "Pore-C tool for chromosome conformation capture (Note: The provided text contains
  container build logs rather than CLI help documentation)\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
stdout: pore-c_pore_c.out
