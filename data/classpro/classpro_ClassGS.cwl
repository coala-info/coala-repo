cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - classpro
  - ClassGS
label: classpro_ClassGS
doc: "A tool within the classpro suite. (Note: The provided help text contains only
  container build error logs and does not list specific arguments or descriptions.)\n
  \nTool homepage: https://github.com/yoshihikosuzuki/ClassPro/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/classpro:1.0.2--hda11466_1
stdout: classpro_ClassGS.out
