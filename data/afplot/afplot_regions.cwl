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
  - id: vcf
    type: File
    doc: Path to input VCF file (bgzipped, tabix-indexed, with AD in FORMAT and 
      contig lengths in the header)
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 102
      prefix: --vcf
  - id: output_dir
    type: string
    default: afplot_regions_out
    doc: Path to output directory (created before the run)
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: name
    type:
      - 'null'
      - string
    doc: Optional title for plot
    inputBinding:
      position: 102
      prefix: --name
  - id: region_file
    type:
      - 'null'
      - File
    doc: Path to region file (BED)
    inputBinding:
      position: 102
      prefix: --region-file
  - id: region
    type:
      - 'null'
      - string
    doc: Region string. Must be of format <contig:start-end>
    inputBinding:
      position: 102
      prefix: --region
  - id: margin
    type:
      - 'null'
      - int
    doc: Margin around regions to plot
    inputBinding:
      position: 102
      prefix: --margin
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
  - id: plots_dir
    type: Directory
    doc: Output directory with one PNG per region
    outputBinding:
      glob: $(inputs.output_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: "$({'class': 'Directory', 'listing': []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1
stdout: afplot_regions.out
