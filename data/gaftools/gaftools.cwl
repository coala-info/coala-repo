cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaftools
label: gaftools
doc: "Gaftools is a tool for GAF (Graph Alignment Format) manipulation and analysis.\n
  \nTool homepage: https://github.com/marschall-lab/gaftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
stdout: gaftools.out
