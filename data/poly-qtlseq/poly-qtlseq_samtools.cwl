cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: poly-qtlseq_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq"
inputs:
  - id: command
    type: string
    doc: Samtools command to execute
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the samtools command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
stdout: poly-qtlseq_samtools.out
