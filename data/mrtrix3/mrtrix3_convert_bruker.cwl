cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_convert_bruker
doc: "Convert Bruker 2dseq data to an MRtrix image. The command prints only a usage line as help.\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [convert_bruker]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: in_2dseq
    type: File
    doc: "The Bruker 2dseq file (its parent directory must hold the Bruker parameter files)."
    inputBinding:
      position: 10
  - id: header
    type: string
    doc: "The output MRtrix header file (.mih)."
    inputBinding:
      position: 11
outputs:
  - id: header_file
    type: File
    doc: "The output MRtrix header file (.mih)."
    outputBinding:
      glob: $(inputs.header)
