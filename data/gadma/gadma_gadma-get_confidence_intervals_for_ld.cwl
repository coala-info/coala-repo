cwlVersion: v1.2
class: CommandLineTool
baseCommand: gadma-get_confidence_intervals_for_ld
label: gadma_gadma-get_confidence_intervals_for_ld
doc: "GADMA module for calculating confidence intervals from calculated LD params\n\nTool homepage: https://github.com/ctlab/GADMA"
inputs:
  - id: result_py_file
    type: File
    doc: 'Filename (.py) with result from run on data. Output of gadma.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Confidence intervals
stdout: gadma_gadma-get_confidence_intervals_for_ld.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
