cwlVersion: v1.2
class: CommandLineTool
baseCommand: xcfinfo
label: xcftools_xcfinfo
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime logs and a fatal error message regarding an image build failure.\n
  \nTool homepage: https://github.com/j-jorge/xcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xcftools:1.0.7--0
stdout: xcftools_xcfinfo.out
