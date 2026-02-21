cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss-sealer
label: abyss_abyss-sealer
doc: "abyss-sealer is a tool to fill gaps in genome assemblies using a Bloom filter
  representation of a k-mer set.\n\nTool homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
stdout: abyss_abyss-sealer.out
