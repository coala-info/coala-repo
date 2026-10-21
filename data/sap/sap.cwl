cwlVersion: v1.2
class: CommandLineTool
baseCommand: sap
label: sap
doc: "Aligns two protein sequences and outputs the alignment in PDB format.\n\nTool
  homepage: https://github.com/mathbio-nimr-mrc-ac-uk/SAP"
inputs:
  - id: file1
    type: File
    doc: First PDB file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: file2
    type: File
    doc: Second PDB file
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: one2one
    type:
      - 'null'
      - int
    doc: Integer value added to the diagonal. Any negative value selects the 
      default value of 1000.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: superposition
    type:
      - 'null'
      - File
    doc: Second structure superposed on the first, in PDB format
    outputBinding:
      glob: super.pdb
  - id: rms_plot
    type:
      - 'null'
      - File
    doc: Per-residue RMS plot data
    outputBinding:
      glob: plot.rms
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.file1)
      - $(inputs.file2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sap:1.1.3--h7b50bb2_5
stdout: sap.out
