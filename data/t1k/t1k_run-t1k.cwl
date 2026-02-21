cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-t1k
label: t1k_run-t1k
doc: "T1K (The One-stop KIR/HLA/TCR/BCR typer) is a tool for inferring the alleles
  of highly polymorphic genes from NGS data. (Note: The provided text contained only
  system error logs and no usage information; arguments could not be extracted from
  the input.)\n\nTool homepage: https://github.com/mourisl/T1K"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/t1k:1.0.9--h5ca1c30_0
stdout: t1k_run-t1k.out
