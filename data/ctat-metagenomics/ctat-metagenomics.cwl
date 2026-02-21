cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctat-metagenomics
label: ctat-metagenomics
doc: "The provided text is a system error log regarding a failed container build and
  does not contain help documentation or argument definitions.\n\nTool homepage: https://github.com/NCIP/ctat-metagenomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctat-metagenomics:1.0.1--py27_1
stdout: ctat-metagenomics.out
