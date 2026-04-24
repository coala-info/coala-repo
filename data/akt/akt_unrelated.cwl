cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - akt
  - unrelated
label: akt_unrelated
doc: "Print a list of unrelated individuals taking the output from akt kin as input.\n
  \nTool homepage: https://github.com/Illumina/akt"
inputs:
  - id: ibd_file
    type: File
    doc: Input IBD file from akt kin
    inputBinding:
      position: 1
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of iterations to find unrelated
    inputBinding:
      position: 102
      prefix: --its
  - id: kmin
    type:
      - 'null'
      - float
    doc: threshold for relatedness
    inputBinding:
      position: 102
      prefix: --kmin
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
stdout: akt_unrelated.out
