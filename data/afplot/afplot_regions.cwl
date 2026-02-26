cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - afplot
  - regions
label: afplot_regions
doc: "Create plots for regions of interest for one VCF. Plots will be colored on call
  type (het/hom_alt/hom_ref). Your VCF file MUST contain an AD column in the FORMAT
  field, have contig names and lengths in the header, and be indexed with tabix.\n\
  \nTool homepage: https://github.com/sndrtj/afplot"
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
stdout: afplot_regions.out
