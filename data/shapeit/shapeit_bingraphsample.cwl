cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit
label: shapeit_bingraphsample
doc: "The provided text is an error log indicating a failure to build or extract the
  container image (no space left on device) and does not contain help text or usage
  information for the tool.\n\nTool homepage: https://github.com/odelaneau/shapeit4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit:2.r837--h09b0a5c_1
stdout: shapeit_bingraphsample.out
