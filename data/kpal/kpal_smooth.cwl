cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal_smooth
label: kpal_smooth
doc: "Smooth two profiles by collapsing sub-profiles. If the files contain more than
  one profile, they are linked by name and processed pairwise.\n\nTool homepage: https://github.com/LUMC/kPAL"
inputs:
  - id: input_left
    type: File
    doc: input k-mer profile file (left)
    inputBinding:
      position: 1
  - id: input_right
    type: File
    doc: input k-mer profile file (right)
    inputBinding:
      position: 2
  - id: custom_summary
    type:
      - 'null'
      - string
    doc: custom Python summary function, specified either by an expression over 
      the NumPy ndarray "values" (e.g., "np.max(values)"), or an importable name
      (e.g., "package.module.summary") that can be called with an ndarray as 
      argument
    inputBinding:
      position: 103
      prefix: --custom-summary
  - id: profiles_left
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the k-mer profiles to consider (left)
    inputBinding:
      position: 103
      prefix: --profiles-left
  - id: profiles_right
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the k-mer profiles to consider (right)
    inputBinding:
      position: 103
      prefix: --profiles-right
  - id: summary_function
    type:
      - 'null'
      - string
    doc: summary function for dynamic smoothing
    inputBinding:
      position: 103
      prefix: --summary
  - id: threshold
    type:
      - 'null'
      - int
    doc: threshold for the summary function
    inputBinding:
      position: 103
      prefix: --threshold
outputs:
  - id: output_left
    type: File
    doc: output k-mer profile file (left)
    outputBinding:
      glob: '*.out'
  - id: output_right
    type: File
    doc: output k-mer profile file (right)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
