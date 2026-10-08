cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - corrplot
label: transit_corrplot
doc: "Correlation plot of the gene means of the samples (needs R and rpy2).\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: gene_means
    type: File
    doc: "Gene means file (output of anova or zinb)"
    inputBinding:
      position: 1
  - id: output_filename
    type: string
    doc: "Output .png file name"
    inputBinding:
      position: 2
  - id: anova
    type: ['null', boolean]
    doc: "Input is the output of anova"
    inputBinding:
      position: 20
      prefix: -anova
  - id: zinb
    type: ['null', boolean]
    doc: "Input is the output of zinb"
    inputBinding:
      position: 20
      prefix: -zinb
outputs:
  - id: output_file
    type: File
    doc: "Output plot"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
