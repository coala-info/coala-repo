cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kma
  - index
label: kma_kma index
doc: "No description available: The provided text is a container runtime error log,
  not help text.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
stdout: kma_kma index.out
