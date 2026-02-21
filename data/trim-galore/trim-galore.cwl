cwlVersion: v1.2
class: CommandLineTool
baseCommand: trim_galore
label: trim-galore
doc: "The provided text does not contain help documentation for trim-galore; it is
  a system error log indicating a failure to build a container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/FelixKrueger/TrimGalore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trim-galore:0.6.10--hdfd78af_2
stdout: trim-galore.out
