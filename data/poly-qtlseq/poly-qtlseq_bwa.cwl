cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa
label: poly-qtlseq_bwa
doc: "alignment via Burrows-Wheeler transformation\n\nTool homepage: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., index, mem, aln)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the selected command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
stdout: poly-qtlseq_bwa.out
