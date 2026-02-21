cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - afreq
label: svtools_svtools afreq
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a container runtime error log.\n\nTool homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools afreq.out
