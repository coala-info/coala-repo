cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgpbigwig_bwcat
label: cgpbigwig_bwcat
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/cancerit/cgpBigWig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgpbigwig:1.7.0--h523f0d1_0
stdout: cgpbigwig_bwcat.out
