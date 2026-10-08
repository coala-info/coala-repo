cwlVersion: v1.2
class: CommandLineTool
baseCommand: esimsa
label: esimsa
doc: "Deconvolutes an electrospray mass spectrometry peak list into isotopic clusters and writes the deconvoluted masses.\n\nTool homepage: http://www.ms-utils.org/esimsa.html"
inputs:
  - id: peaklist
    type: File
    doc: peaklist
    inputBinding:
      position: 1
  - id: max_charge
    type: int
    doc: max charge
    inputBinding:
      position: 2
  - id: output_path
    type: string
    doc: Name of the output file
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: output
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esimsa:1.0--0
