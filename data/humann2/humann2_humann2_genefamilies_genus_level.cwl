cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_genefamilies_genus_level
label: humann2_humann2_genefamilies_genus_level
doc: "Create a genus level gene families file\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input
    type: File
    doc: "the gene families input table"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: output_path
    type: string
    doc: "the output table"
    inputBinding:
      position: 102
      prefix: "--output"
outputs:
  - id: output
    type: File
    doc: "genus level gene families table"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
