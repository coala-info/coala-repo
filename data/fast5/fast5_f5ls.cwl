cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast5_f5ls
label: fast5_f5ls
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. Based on the tool name, it is likely used for
  listing contents of fast5 files.\n\nTool homepage: https://github.com/mateidavid/fast5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5:0.6.5--0
stdout: fast5_f5ls.out
