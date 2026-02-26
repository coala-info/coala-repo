cwlVersion: v1.2
class: CommandLineTool
baseCommand: quasitools complexity
label: quasitools_complexity
doc: "Reports the per-amplicon (fasta) or k-mer complexity of the pileup, for each
  k-mer position in the reference complexity (bam and reference) of a quasispecies
  using several measures outlined in the following work:\n\nGregori, Josep, et al.
  \"Viral quasispecies complexity measures.\" Virology 493 (2016): 227-237.\n\nTool
  homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: command
    type: string
    doc: Command to run (bam or fasta)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
stdout: quasitools_complexity.out
