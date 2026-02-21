cwlVersion: v1.2
class: CommandLineTool
baseCommand: accusnv
label: accusnv_accusnv_snakemake
doc: "AccuSNV is a tool for calling single-nucleotide variants (SNVs) with high sensitivity
  and specificity. (Note: The provided text is an error log and does not contain usage
  information; arguments could not be extracted from the input.)\n\nTool homepage:
  https://github.com/liaoherui/AccuSNV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/accusnv:1.0.0.5--pyhdfd78af_0
stdout: accusnv_accusnv_snakemake.out
