cwlVersion: v1.2
class: CommandLineTool
baseCommand: malva-geno
label: malva_malva-geno
doc: "Malva (Mapping-free ALlele VAriant caller) genotyping tool. Note: The provided
  help text contains only container runtime error messages and does not list available
  command-line arguments.\n\nTool homepage: https://algolab.github.io/malva/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malva:2.0.0--h7071971_4
stdout: malva_malva-geno.out
