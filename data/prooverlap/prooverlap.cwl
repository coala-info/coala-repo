cwlVersion: v1.2
class: CommandLineTool
baseCommand: prooverlap
label: prooverlap
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains container engine log messages indicating a failure to fetch
  the OCI image.\n\nTool homepage: https://github.com/ngualand/ProOvErlap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prooverlap:0.1.2--pyhdfd78af_0
stdout: prooverlap.out
