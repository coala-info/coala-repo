cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptgaul
label: ptgaul
doc: "Phylogenetic Tree Generation and Ancestral Unit Linkage\n\nTool homepage: https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul.out
