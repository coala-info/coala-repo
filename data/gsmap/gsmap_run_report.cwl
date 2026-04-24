cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsmap_run_report
label: gsmap_run_report
doc: "Generate a report for a GWAS analysis.\n\nTool homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: annotation
    type: string
    doc: Annotation layer name.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: fig_height
    type:
      - 'null'
      - int
    doc: Height of the generated figures in pixels.
    inputBinding:
      position: 101
      prefix: --fig_height
  - id: fig_style
    type:
      - 'null'
      - string
    doc: Style of the generated figures.
    inputBinding:
      position: 101
      prefix: --fig_style
  - id: fig_width
    type:
      - 'null'
      - int
    doc: Width of the generated figures in pixels.
    inputBinding:
      position: 101
      prefix: --fig_width
  - id: point_size
    type:
      - 'null'
      - float
    doc: Point size for the figures.
    inputBinding:
      position: 101
      prefix: --point_size
  - id: sample_name
    type: string
    doc: Name of the sample.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: selected_genes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of specific genes to include in the report (optional).
    inputBinding:
      position: 101
      prefix: --selected_genes
  - id: sumstats_file
    type: File
    doc: Path to GWAS summary statistics file.
    inputBinding:
      position: 101
      prefix: --sumstats_file
  - id: top_corr_genes
    type:
      - 'null'
      - int
    doc: Number of top correlated genes to display.
    inputBinding:
      position: 101
      prefix: --top_corr_genes
  - id: trait_name
    type: string
    doc: Name of the trait to generate the report for.
    inputBinding:
      position: 101
      prefix: --trait_name
  - id: workdir
    type: Directory
    doc: Path to the working directory.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
stdout: gsmap_run_report.out
