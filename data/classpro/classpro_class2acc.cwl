cwlVersion: v1.2
class: CommandLineTool
baseCommand: classpro_class2acc
label: classpro_class2acc
doc: "A tool from the ClassPro suite (detailed description and usage information not
  available in the provided log text).\n\nTool homepage: https://github.com/yoshihikosuzuki/ClassPro/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/classpro:1.0.2--hda11466_1
stdout: classpro_class2acc.out
