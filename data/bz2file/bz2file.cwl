cwlVersion: v1.2
class: CommandLineTool
baseCommand: bz2file
label: bz2file
doc: "A Python library/tool for reading and writing bzip2-compressed files. (Note:
  The provided text contains system error messages regarding a failed container build
  and does not include functional help text or argument definitions.)\n\nTool homepage:
  https://github.com/nvawda/bz2file"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bz2file:v0.98-2-deb-py2_cv1
stdout: bz2file.out
