cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicebox_scripts
label: juicebox_scripts
doc: "The provided text is an error log indicating a failure to initialize the container
  environment (no space left on device) and does not contain help or usage information
  for the tool.\n\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
stdout: juicebox_scripts.out
