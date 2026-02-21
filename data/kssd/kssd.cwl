cwlVersion: v1.2
class: CommandLineTool
baseCommand: kssd
label: kssd
doc: "K-mer Substring Space Decomposition (KSSD) for genomic distance estimation.
  (Note: The provided help text contains only container runtime error messages and
  does not list specific command-line arguments.)\n\nTool homepage: https://github.com/yhg926/public_kssd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kssd:2.21--h577a1d6_3
stdout: kssd.out
