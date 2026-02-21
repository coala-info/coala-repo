cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanometa-live
  - nanometa-sim
label: nanometa-live_nanometa-sim
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding disk space
  during a container build process.\n\nTool homepage: https://github.com/FOI-Bioinformatics/nanometa_live"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanometa-live:0.4.3--pyhdfd78af_0
stdout: nanometa-live_nanometa-sim.out
