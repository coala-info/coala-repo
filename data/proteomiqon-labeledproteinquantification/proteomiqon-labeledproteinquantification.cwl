cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProteomIQon.LabeledProteinQuantification
label: proteomiqon-labeledproteinquantification
doc: "Labeled Protein Quantification\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs:
  - id: paramfile
    type: File
    doc: Specify parameter file.
    inputBinding:
      position: 101
      prefix: --paramfile
  - id: proteinassignedquantpepions
    type:
      type: array
      items: File
    doc: Specify the a single, list or directory containing .quantAndProt files.
    inputBinding:
      position: 101
      prefix: --proteinassignedquantpepions
outputs:
  - id: outputdirectory
    type: Directory
    doc: Specify the output directory.
    outputBinding:
      glob: $(inputs.outputdirectory)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-labeledproteinquantification:0.0.3--hdfd78af_1
