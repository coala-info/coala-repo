cwlVersion: v1.2
class: CommandLineTool
baseCommand: busco
label: busco_phylogenomics
doc: "Benchmarking Universal Single-Copy Orthologs (BUSCO) assessment tool. Note:
  The provided help text contains only system error messages regarding container execution
  and disk space, and does not list available command-line arguments.\n\nTool homepage:
  https://github.com/jamiemcg/BUSCO_phylogenomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/busco:6.0.0--pyhdfd78af_2
stdout: busco_phylogenomics.out
