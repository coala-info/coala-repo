cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_sp_manage_IDs.pl
label: agat_agat_sp_manage_ids.pl
doc: "This script allows to manage IDs in a GFF file. It can be used to add, remove,
  or change IDs.\n\nTool homepage: https://github.com/NBISweden/AGAT"
inputs:
  - id: collective
    type:
      - 'null'
      - boolean
    doc: Set a collective ID for discontinuous features (CDS, UTR) instead of a
      uniq ID per line.
    inputBinding:
      position: 101
      prefix: --collective
  - id: gff
    type: File
    doc: Input GFF3 file that will be read
    inputBinding:
      position: 101
      prefix: --gff
  - id: type
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -p
    doc: Primary tag (feature type, column 3) or level (level1, level2, level3)
      to handle. Repeat for several. Default all.
    inputBinding:
      position: 101
  - id: prefix
    type:
      - 'null'
      - string
    doc: Add a specific prefix to the ID. By default it is the feature type.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ensembl
    type:
      - 'null'
      - boolean
    doc: Build Ensembl-like IDs (e.g. PREFIXG00000000022).
    inputBinding:
      position: 101
      prefix: --ensembl
  - id: tair
    type:
      - 'null'
      - boolean
    doc: TAIR-like output IDs.
    inputBinding:
      position: 101
      prefix: --tair
  - id: type_dependent
    type:
      - 'null'
      - boolean
    doc: Number IDs per feature type.
    inputBinding:
      position: 101
      prefix: --type_dependent
  - id: gap
    type:
      - 'null'
      - int
    doc: Increment the next gene (level1 feature) suffix with this value. 
      Default 0.
    inputBinding:
      position: 101
      prefix: --gap
  - id: nb
    type:
      - 'null'
      - int
    doc: Start numbering at this value. Default 1.
    inputBinding:
      position: 101
      prefix: --nb
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output GFF file. If no output file is specified, the output will be 
      written to the standard output.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
