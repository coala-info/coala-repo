cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amptk
  - summarize
label: amptk_summarize
doc: "Summarize amplicon sequencing data\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing OTU table and taxonomy files
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files without asking
    inputBinding:
      position: 102
      prefix: --force
  - id: format
    type:
      - 'null'
      - string
    doc: Format for generated plots (png, pdf, svg)
    default: png
    inputBinding:
      position: 102
      prefix: --format
  - id: level
    type:
      - 'null'
      - int
    doc: Taxonomic level to summarize (e.g., 3 for genus)
    default: 3
    inputBinding:
      position: 102
      prefix: --level
  - id: min_otu
    type:
      - 'null'
      - int
    doc: Minimum number of reads for an OTU to be included in plots
    default: 1
    inputBinding:
      position: 102
      prefix: --min_otu
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads to include a sample in plots
    default: 100
    inputBinding:
      position: 102
      prefix: --min_reads
  - id: plot_type
    type:
      - 'null'
      - string
    doc: Type of plot to generate (bar, pie, stackedbar)
    default: bar
    inputBinding:
      position: 102
      prefix: --plot
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save summary files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
