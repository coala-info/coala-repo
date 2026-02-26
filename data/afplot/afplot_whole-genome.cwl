cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - afplot
  - whole-genome
label: afplot_whole-genome
doc: "Create whole-genome plots for one or multiple VCFs. If only one VCF is supplied,
  plots will be colored on call type (het/hom_ref/hom_alt). If multiple VCF files
  are supplied, plots will be colored per file/label. Only one sample per VCF file
  can be plotted.\n\nTool homepage: https://github.com/sndrtj/afplot"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (distance, histogram, or scatter)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1
stdout: afplot_whole-genome.out
