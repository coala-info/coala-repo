cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taseq
  - draw
label: taseq_taseq_draw
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message regarding an image build failure.\n
  \nTool homepage: https://github.com/KChigira/taseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taseq:1.1.1--pyh7e72e81_0
stdout: taseq_taseq_draw.out
