cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - catalogue_errors
  - analyse
label: pomoxis_catalogue_errors_analyse
doc: "Analyse existing error counts, optionally merging multiple counters.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: pkl
    type:
      type: array
      items: File
    doc: Input .pkl file(s) from `catalogue_errors count`.
    inputBinding:
      position: 1
  - id: outdir
    type:
      - 'null'
      - string
    default: error_catalogue
    doc: Output directory (will be created).
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: analysis_dir
    type: Directory
    doc: Directory with the error catalogue tables and plots.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
