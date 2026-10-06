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
  - id: vcf
    type:
      type: array
      items: File
      inputBinding:
        prefix: --vcf
    doc: Path(s) to input VCF file(s) (bgzipped, tabix-indexed, with AD in 
      FORMAT and contig lengths in the header)
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 102
  - id: label
    type:
      type: array
      items: string
      inputBinding:
        prefix: --label
    doc: Label(s) to VCF file(s), one per VCF
    inputBinding:
      position: 102
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sample
    doc: Sample name(s) of VCF file(s). If not given, will use first sample in each VCF file
    inputBinding:
      position: 102
  - id: exclude_pattern
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-pattern
    doc: Regex pattern(s) to exclude from contig list
    inputBinding:
      position: 102
  - id: output
    type: string
    doc: Path to output file (PNG)
    inputBinding:
      position: 102
      prefix: --output
  - id: color_palette
    type:
      - 'null'
      - string
    doc: The name of a color palette to pass to seaborn.set_palette
    inputBinding:
      position: 102
      prefix: --color-palette
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'DPI for output PNGs (default: 300)'
    inputBinding:
      position: 102
      prefix: --dpi
  - id: kde_only
    type:
      - 'null'
      - boolean
    doc: Only show kernel density plot (histogram command only)
    inputBinding:
      position: 102
      prefix: --kde-only
outputs:
  - id: plot
    type: File
    doc: Output plot
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1
stdout: afplot_whole-genome.out
