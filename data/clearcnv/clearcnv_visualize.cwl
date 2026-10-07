cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clearCNV
  - visualize
label: clearcnv_visualize
doc: "The visualization script creates html files containing heatmap-like matrices containing the ratios aligned with mappability, GC-content and target size so that CNVs can be visually identified and evaluated easily.\n\nTool homepage: https://github.com/bihealth/clear-cnv"
inputs:
  - id: analysis_directory
    type: string
    doc: "Name of the directory, where analysis files are stored (created empty in the working directory)"
    inputBinding:
      position: 101
      prefix: --analysis_directory
  - id: ratio_scores
    type: File
    doc: "Ratio scores file in tsv format, generated in cnv_calling.py"
    inputBinding:
      position: 101
      prefix: --ratio_scores
  - id: z_scores
    type: File
    doc: "Z-scores file in tsv format, generated in cnv_calling.py"
    inputBinding:
      position: 101
      prefix: --z_scores
  - id: annotated
    type: File
    doc: "BED-formatted annotatins file generated with clearCNV annotations. E.g. annotations.bed."
    inputBinding:
      position: 101
      prefix: --annotated
  - id: size
    type:
      - 'null'
      - int
    doc: "Rough number of targets in each visualization. Defaults at 1000."
    inputBinding:
      position: 101
      prefix: --size
outputs:
  - id: analysis_dir
    type: Directory
    doc: "Analysis directory with the html visualizations"
    outputBinding:
      glob: "$(inputs.analysis_directory)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return {class: 'Directory', basename: inputs.analysis_directory, listing: [], writable: true}; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
