cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslDropOverlap
label: ucsc-psldropoverlap
doc: "deletes all overlapping (trivial/diagonal) self-alignment blocks. This discards information in mismatch, repMatch and nCount, lumping all into match.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: "Input PSL file (self-alignments)."
    inputBinding:
      position: 1
  - id: out_psl
    type: string
    doc: "Output PSL file name."
    inputBinding:
      position: 2
outputs:
  - id: out_file
    type: File
    doc: "PSL without overlapping blocks."
    outputBinding:
      glob: $(inputs.out_psl)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psldropoverlap:482--h0b57e2e_0
stderr: ucsc-psldropoverlap.err
