cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimi_cache_create
label: mimi_mimi_cache_create
doc: "Molecular Isotope Mass Identifier: build a binary cache of theoretical isotope masses from a compound\
  \ list.\n\nTool homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs:
  - id: label
    type:
      - 'null'
      - File
    doc: JSON file with labeled atoms (isotope abundance override).
    inputBinding:
      position: 101
      prefix: --label
  - id: noise
    type:
      - 'null'
      - double
    doc: Threshold for filtering molecular isotope variants with relative abundance below CUTOFF w.r.t.
      the monoisotopic mass (default 1e-5).
    inputBinding:
      position: 101
      prefix: --noise
  - id: dbfile
    type:
      type: array
      items: File
    doc: File(s) with the list of compounds (TSV with CF, ID and Name columns).
    inputBinding:
      position: 101
      prefix: --dbfile
  - id: ion
    type: string
    doc: 'Ionisation mode: pos or neg.'
    inputBinding:
      position: 101
      prefix: --ion
  - id: cache
    type: string
    doc: Binary DB output file.
    inputBinding:
      position: 101
      prefix: --cache
outputs:
  - id: cache_files
    type:
      type: array
      items: File
    doc: Binary cache file(s).
    outputBinding:
      glob: $(inputs.cache)*
  - id: log
    type: stdout
    doc: Standard output.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
stdout: mimi_mimi_cache_create.out
