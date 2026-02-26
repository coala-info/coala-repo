cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyamilyseq
label: pyamilyseq_partial
doc: "A tool for gene clustering and pangenome analysis.\n\nTool homepage: https://github.com/NickJD/PyamilySeq"
inputs:
  - id: run_mode
    type: string
    doc: Mode of operation for PyamilySeq. Choose from 'Full' or 'Partial'.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyamilyseq:1.3.3--pyhdfd78af_0
stdout: pyamilyseq_partial.out
