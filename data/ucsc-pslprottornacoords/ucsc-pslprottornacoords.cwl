cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslProtToRnaCoords
label: ucsc-pslprottornacoords
doc: "Convert either a protein/protein or protein/NA PSL to NA/NA PSL. This multiplies coordinates and statistics by three. As this can occasionally result in blocks overlapping, overlap is trimmed as needed.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: "Input protein PSL file."
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
    doc: "NA/NA PSL file."
    outputBinding:
      glob: $(inputs.out_psl)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslprottornacoords:482--h0b57e2e_0
stderr: ucsc-pslprottornacoords.err
