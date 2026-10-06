cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, flatten]
requirements:
  - class: InlineJavascriptRequirement
label: bart_flatten
doc: "Flattens a nested structure.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: The input file or directory to flatten.
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 11
outputs:
  - id: output
    type: File
    doc: The output file or directory for the flattened structure.
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
