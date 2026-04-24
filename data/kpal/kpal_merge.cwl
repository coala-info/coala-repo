cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal_merge
label: kpal_merge
doc: "Merge k-mer profiles. If the files contain more than one profile, they are linked
  by name and merged pairwise. The resulting profile name is set to that of the original
  profiles if they match, or to their concatenation otherwise.\n\nTool homepage: https://github.com/LUMC/kPAL"
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
  - id: custom_merger
    type:
      - 'null'
      - string
    doc: custom Python merge function, specified either by an expression over 
      the two NumPy ndarrays "left" and "right" (e.g., "np.add(left, right)"), 
      or an importable name (e.g., "package.module.merge") that can be called 
      with two ndarrays as arguments
    inputBinding:
      position: 103
      prefix: --custom-merger
  - id: merge_function
    type:
      - 'null'
      - string
    doc: merge function
    inputBinding:
      position: 103
      prefix: -m
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
outputs:
  - id: output
    type: File
    doc: output k-mer profile file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
