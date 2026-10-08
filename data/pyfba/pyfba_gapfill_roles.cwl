cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfba
  - gapfill_roles
label: pyfba_gapfill_roles
doc: "Run Flux Balance Analysis on a set of gapfilled functional roles (give exactly one of roles, assigned_functions or features)\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: roles
    type:
      - 'null'
      - File
    doc: "A list of functional roles in this genome, one per line"
    inputBinding:
      position: 1
      prefix: --roles
  - id: assigned_functions
    type:
      - 'null'
      - File
    doc: "RAST assigned functions (tab separated PEG/Functional Role)"
    inputBinding:
      position: 1
      prefix: --assigned_functions
  - id: features
    type:
      - 'null'
      - File
    doc: "PATRIC features.txt file (with 5 columns)"
    inputBinding:
      position: 1
      prefix: --features
  - id: media
    type: string
    doc: "media name (a predefined PyFBA media name or a media file path)"
    inputBinding:
      position: 1
      prefix: --media
  - id: close
    type:
      - 'null'
      - File
    doc: "a file with roles from close organisms"
    inputBinding:
      position: 1
      prefix: --close
  - id: genera
    type:
      - 'null'
      - File
    doc: "a file with roles from similar genera"
    inputBinding:
      position: 1
      prefix: --genera
  - id: output_path
    type: string
    doc: "file to save new reaction list to"
    inputBinding:
      position: 1
      prefix: --output
  - id: type
    type:
      - 'null'
      - string
    doc: "organism type for the model (currently allowed are ['gramnegative', 'grampositive', 'microbial', 'mycobacteria', 'plant']). Default=gramnegative"
    inputBinding:
      position: 1
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: File
    doc: "Gap-filled reaction list"
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_gapfill_roles.out
