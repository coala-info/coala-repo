cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslProtToRnaCoords
label: ucsc-pslprottornacoords
doc: "Convert protein PSL alignments to RNA coordinates.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input protein PSL file.
    inputBinding:
      position: 1
  - id: cds_fa
    type: File
    doc: FASTA file containing the CDS sequences.
    inputBinding:
      position: 2
outputs:
  - id: psl_out
    type: File
    doc: Output PSL file with RNA coordinates.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslprottornacoords:482--h0b57e2e_0
