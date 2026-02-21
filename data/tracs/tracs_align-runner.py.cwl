cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_align-runner.py
label: tracs_align-runner.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log indicating a failure to build or extract
  a Singularity/Apptainer container image due to insufficient disk space ('no space
  left on device').\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
stdout: tracs_align-runner.py.out
