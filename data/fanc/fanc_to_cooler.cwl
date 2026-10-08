cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - to-cooler
label: fanc_to_cooler
doc: "Convert a FAN-C Hic file into cooler format (multi-resolution by default).\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type: File
    doc: "Input .hic file, FAN-C format."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output cooler file."
    inputBinding:
      position: 2
  - id: uncorrected
    type:
      - 'null'
      - boolean
    doc: "Output uncorrected matrix."
    inputBinding:
      position: 20
      prefix: --uncorrected
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads used for balancing."
    inputBinding:
      position: 20
      prefix: --threads
  - id: no_multi
    type:
      - 'null'
      - boolean
    doc: "Do not produce a multi-resolution file. This is fast, as it does not \"coarsen\" the matrix at multiple resolutions, but the resulting file will be incompatible with HiGlass!"
    inputBinding:
      position: 20
      prefix: --no-multi
  - id: resolutions
    type:
      - 'null'
      - type: array
        items: int
    doc: "Resolutions in bp at which to \"coarsen\" the cooler matrix. Default resolutions are calculated as base- resolution * 2 ** z, where z is an increasing integer zoom level."
    inputBinding:
      position: 20
      prefix: --resolutions
  - id: no_natural_sort
    type:
      - 'null'
      - boolean
    doc: "Do not sort regions by their natural chromosome order. When using this option, chromosomes will appear in the Cooler file in the order they are listed in the FAN-C file."
    inputBinding:
      position: 20
      prefix: --no-natural-sort
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: cooler
    type: File
    doc: "Cooler file."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
