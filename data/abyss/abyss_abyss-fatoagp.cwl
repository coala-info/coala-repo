cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss-fatoagp
label: abyss_abyss-fatoagp
doc: "Convert FASTA files to AGP format (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
stdout: abyss_abyss-fatoagp.out
