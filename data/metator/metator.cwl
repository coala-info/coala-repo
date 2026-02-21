cwlVersion: v1.2
class: CommandLineTool
baseCommand: metator
label: metator
doc: "Metagenomic taxonomic assignment and binning tool (Note: The provided text is
  a container execution error log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/koszullab/metator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metator:1.3.10--py310h184ae93_0
stdout: metator.out
