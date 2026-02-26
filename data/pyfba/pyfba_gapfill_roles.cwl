cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba
label: pyfba_gapfill_roles
doc: "Run Flux Balance Analysis on a set of gapfilled functional roles\n\nTool homepage:
  https://linsalrob.github.io/PyFBA/"
inputs:
  - id: assigned_functions
    type: File
    doc: RAST assigned functions (tab separated PEG/Functional Role)
    inputBinding:
      position: 101
      prefix: --assigned_functions
  - id: close
    type:
      - 'null'
      - File
    doc: a file with roles from close organisms
    inputBinding:
      position: 101
      prefix: --close
  - id: features
    type: File
    doc: PATRIC features.txt file (with 5 columns)
    inputBinding:
      position: 101
      prefix: --features
  - id: genera
    type:
      - 'null'
      - File
    doc: a file with roles from similar genera
    inputBinding:
      position: 101
      prefix: --genera
  - id: media
    type: string
    doc: media name
    inputBinding:
      position: 101
      prefix: --media
  - id: roles
    type: File
    doc: A list of functional roles in this genome, one per line
    inputBinding:
      position: 101
      prefix: --roles
  - id: type
    type:
      - 'null'
      - string
    doc: organism type for the model (currently allowed are ['gramnegative', 
      'grampositive', 'microbial', 'mycobacteria', 'plant'])
    default: gramnegative
    inputBinding:
      position: 101
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: file to save new reaction list to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
