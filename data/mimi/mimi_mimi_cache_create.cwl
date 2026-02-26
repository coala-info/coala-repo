cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimi_cache_create
label: mimi_mimi_cache_create
doc: "Molecular Isotope Mass Identifier\n\nTool homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs:
  - id: dbfile
    type:
      type: array
      items: File
    doc: File(s) with list of compounds
    inputBinding:
      position: 1
  - id: cache_dbbinary
    type: File
    doc: Binary DB output file (if not specified, will use base name from JSON 
      file)
    inputBinding:
      position: 102
      prefix: --cache
  - id: ion_mode
    type: string
    doc: Ionisation mode
    inputBinding:
      position: 102
      prefix: -i
  - id: label_json
    type:
      - 'null'
      - string
    doc: Labeled atoms
    inputBinding:
      position: 102
      prefix: --label
  - id: noise_cutoff
    type:
      - 'null'
      - float
    doc: Threshold for filtering molecular isotope variants with relative 
      abundance below CUTOFF w.r.t. the monoisotopic mass
    default: '1e-5'
    inputBinding:
      position: 102
      prefix: --noise
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
stdout: mimi_mimi_cache_create.out
