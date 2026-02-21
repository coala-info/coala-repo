cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptgaul_msbwt
label: ptgaul_msbwt
doc: "Phylogenetic Tree Generation using Allele-specific Universal Loci (MSBWT component).
  Note: The provided text is a container build log and does not contain CLI usage
  information.\n\nTool homepage: https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_msbwt.out
