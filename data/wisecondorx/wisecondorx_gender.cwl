cwlVersion: v1.2
class: CommandLineTool
baseCommand: wisecondorx gender
label: wisecondorx_gender
doc: "Returns the gender of a .npz resulting from convert, based on a Gaussian mixture
  model trained during the newref phase\n\nTool homepage: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX"
inputs:
  - id: infile
    type: File
    doc: .npz input file
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: Reference .npz, as previously created with newref
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wisecondorx:1.2.9--pyhdfd78af_0
stdout: wisecondorx_gender.out
