cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoove_plot-counts
label: smoove_plot-counts
doc: "Generate an HTML report of counts from smoove\n\nTool homepage: https://github.com/brentp/smoove"
inputs:
  - id: vcf
    type: File
    doc: path to input VCF from smoove 0.2.3 or greater.
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: html
    type: File
    doc: path to output html file to be written.
    outputBinding:
      glob: $(inputs.html)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
