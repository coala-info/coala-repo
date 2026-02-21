cwlVersion: v1.2
class: CommandLineTool
baseCommand: quickmerge
label: quickmerge
doc: "A tool for merging genome assemblies. (Note: The provided text is a system error
  log and does not contain the tool's help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/mahulchak/quickmerge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickmerge:0.3--pl5321h503566f_6
stdout: quickmerge.out
