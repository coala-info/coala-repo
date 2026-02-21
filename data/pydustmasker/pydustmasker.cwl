cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydustmasker
label: pydustmasker
doc: "A Python wrapper for the DustMasker algorithm used to identify and mask low-complexity
  regions in DNA sequences. (Note: The provided text contains container build logs
  and does not list specific CLI arguments.)\n\nTool homepage: https://github.com/apcamargo/pydustmasker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydustmasker:2.0.0--py314hc948c43_0
stdout: pydustmasker.out
