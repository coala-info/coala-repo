cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taseq
  - genotype
label: taseq_taseq_genotype
doc: "The provided text does not contain help information; it contains container build
  logs and a fatal error message regarding an OCI image fetch failure.\n\nTool homepage:
  https://github.com/KChigira/taseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taseq:1.1.1--pyh7e72e81_0
stdout: taseq_taseq_genotype.out
