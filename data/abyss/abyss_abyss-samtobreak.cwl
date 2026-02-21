cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss-samtobreak
label: abyss_abyss-samtobreak
doc: "The provided text does not contain help information as it is an error log indicating
  a container build failure (no space left on device).\n\nTool homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
stdout: abyss_abyss-samtobreak.out
