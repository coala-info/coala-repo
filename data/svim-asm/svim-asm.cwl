cwlVersion: v1.2
class: CommandLineTool
baseCommand: svim-asm
label: svim-asm
doc: "SVIM-asm is a structural variant caller for haploid and diploid genome assemblies.
  It allows to detect five different types of structural variants (deletions, insertions,
  tandem duplications, interspersed duplications, and inversions) from assembly-to-assembly
  alignments.\n\nTool homepage: https://github.com/eldariont/svim-asm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svim-asm:1.0.3--pyhdfd78af_0
stdout: svim-asm.out
