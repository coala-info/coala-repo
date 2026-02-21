cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnv-phenopacket
label: cnv-phenopacket
doc: "A tool for converting CNV (Copy Number Variation) data to Phenopacket format.
  (Note: The provided text is a container runtime error log and does not contain the
  standard help documentation or argument list).\n\nTool homepage: https://github.com/conda-forge/cnv-phenopacket-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnv-phenopacket:1.0.2
stdout: cnv-phenopacket.out
