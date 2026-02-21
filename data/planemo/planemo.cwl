cwlVersion: v1.2
class: CommandLineTool
baseCommand: planemo
label: planemo
doc: "The provided text appears to be a system error log from a container runtime
  (Singularity/Apptainer) rather than command-line help text. No usage information
  or arguments could be extracted from this input.\n\nTool homepage: https://github.com/galaxyproject/planemo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/planemo:0.75.35--pyhdfd78af_0
stdout: planemo.out
