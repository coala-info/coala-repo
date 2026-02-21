cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit
label: shapeit_WhatsHap
doc: "The provided text is a system error log indicating a failure to build or fetch
  a container image due to insufficient disk space ('no space left on device'). It
  does not contain command-line help information or argument definitions.\n\nTool
  homepage: https://github.com/odelaneau/shapeit4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit:2.r837--h09b0a5c_1
stdout: shapeit_WhatsHap.out
