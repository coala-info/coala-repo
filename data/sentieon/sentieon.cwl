cwlVersion: v1.2
class: CommandLineTool
baseCommand: sentieon
label: sentieon
doc: "Sentieon software package for genomic data analysis. Supported commands include
  tools for read alignment, variant calling, and utility functions.\n\nTool homepage:
  https://github.com/Sentieon/sentieon-scripts"
inputs:
  - id: subcommand
    type: string
    doc: 'The specific Sentieon command to run. Supported commands: LongReadUtil,
      STAR, bamslice, bwa, driver, fqidx, licclnt, licsrvr, minimap2, pgutil, plot,
      pyexec, rcat, umi, util'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sentieon:202503.02--h5ca1c30_0
stdout: sentieon.out
