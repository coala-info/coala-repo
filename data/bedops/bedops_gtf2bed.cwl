cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtf2bed
label: bedops_gtf2bed
doc: "A script to convert GTF (Gene Transfer Format) files to BED format. Note: The
  provided input text appears to be a container execution error log rather than help
  text, so no arguments could be extracted.\n\nTool homepage: http://bedops.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedops_gtf2bed.out
