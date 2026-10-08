cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldcomp
  - rmsd
label: foldcomp_rmsd
doc: "Calculate the RMSD between two protein structures (PDB/mmCIF), e.g. an original and its Foldcomp round-trip.\n\nTool homepage: https://github.com/steineggerlab/foldcomp"
inputs:
  - id: structure1
    type: File
    doc: "First PDB/mmCIF file."
    inputBinding:
      position: 10
  - id: structure2
    type: File
    doc: "Second PDB/mmCIF file."
    inputBinding:
      position: 11
outputs:
  - id: rmsd_report
    type: stdout
    doc: "RMSD report."
stdout: foldcomp_rmsd.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
