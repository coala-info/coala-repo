cwlVersion: v1.2
class: CommandLineTool
baseCommand: fineradstructure
label: fineradstructure
doc: "fineRADstructure: population structure inference from RADseq data. (Note: The
  provided text contains system error messages regarding container image conversion
  and does not include usage instructions or argument definitions.)\n\nTool homepage:
  http://cichlid.gurdon.cam.ac.uk/fineRADstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fineradstructure:0.3.2r109--h76b9af2_7
stdout: fineradstructure.out
