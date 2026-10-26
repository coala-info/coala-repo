cwlVersion: v1.2
class: CommandLineTool
baseCommand: vadr-map-model-coords.pl
label: vadr_vadr-map-model-coords.pl
doc: "Map the model coordinates in a VADR .alt.list file, .alt file or GenBank submission portal detailed error report to coordinates of another model of the same model library, using a model map (mmap) file. A column with the mapped model coordinates is added.\n\nTool homepage: https://github.com/ncbi/vadr"
inputs:
  - id: alt_file
    type: File
    doc: detailed-error-report.tsv or .alt.list file (or .alt file with --alt)
    inputBinding:
      position: 2
  - id: mmap_file
    type: File
    doc: model map (mmap) file with the pairwise alignments of the models
    inputBinding:
      position: 3
  - id: model_to
    type: string
    doc: model to map positions to
    inputBinding:
      position: 4
  - id: alt
    type:
      - 'null'
      - boolean
    doc: file listed in first argument is an .alt file (not a detailed-error-report.tsv or .alt.list file)
    inputBinding:
      position: 1
      prefix: --alt
outputs:
  - id: stdout
    type: stdout
    doc: The input file with an added column of mapped model coordinates
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
stdout: vadr_vadr-map-model-coords.pl.out
