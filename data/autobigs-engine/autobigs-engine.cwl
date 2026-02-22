cwlVersion: v1.2
class: CommandLineTool
baseCommand: autobigs-engine
label: autobigs-engine
doc: "The provided text is a system error log related to a Singularity/Docker container
  execution failure (no space left on device) and does not contain help text or argument
  definitions.\n\nTool homepage: https://github.com/RealYHD/autoBIGS.engine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autobigs-engine:0.14.2--pyhdfd78af_0
stdout: autobigs-engine.out
