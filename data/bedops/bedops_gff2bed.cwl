cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff2bed
label: bedops_gff2bed
doc: "The provided text does not contain help information for the tool; it is an error
  log describing a container build failure (no space left on device).\n\nTool homepage:
  http://bedops.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedops_gff2bed.out
