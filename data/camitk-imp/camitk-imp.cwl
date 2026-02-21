cwlVersion: v1.2
class: CommandLineTool
baseCommand: camitk-imp
label: camitk-imp
doc: 'CamiTK Image Manipulation Program (Note: The provided help text contains only
  system error logs and no usage information. Arguments could not be extracted.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/camitk-imp:v4.1.2-3-deb_cv1
stdout: camitk-imp.out
