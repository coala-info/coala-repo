cwlVersion: v1.2
class: CommandLineTool
baseCommand: vidjil-algo
label: vidjil-algo
doc: "Vidjil is an open-source platform for high-throughput V(D)J recombination analysis.\n
  \nTool homepage: https://gitlab.inria.fr/vidjil/vidjil"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vidjil-algo:2025.02--h077b44d_0
stdout: vidjil-algo.out
