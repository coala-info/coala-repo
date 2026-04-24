cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - clonotypes
label: igdiscover_clonotypes
doc: "Group assigned sequences by clonotype\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: table
    type: File
    doc: Table with parsed and filtered IgBLAST results
    inputBinding:
      position: 1
  - id: amino_acid_mismatches
    type:
      - 'null'
      - boolean
    doc: 'Count CDR3 mismatches on amino-acid level. Default: Compare nucleotides.'
    inputBinding:
      position: 102
      prefix: --aa
  - id: cdr3_core
    type:
      - 'null'
      - string
    doc: 'START:END defines the non-junction region of CDR3 sequences. Use negative
      numbers for END to count from the end. Regions before and after are considered
      to be junction sequence, and for two CDR3s to be considered similar, at least
      one of the junctions must be identical. Default: no junction region.'
    inputBinding:
      position: 102
      prefix: --cdr3-core
  - id: limit
    type:
      - 'null'
      - int
    doc: Print out only the first N groups
    inputBinding:
      position: 102
      prefix: --limit
  - id: mismatches
    type:
      - 'null'
      - string
    doc: 'No. of allowed mismatches between CDR3 sequences. Can also be a fraction
      between 0 and 1 (such as 0.15), interpreted relative to the length of the CDR3
      (minus the front non-core). Default: 1'
    inputBinding:
      position: 102
      prefix: --mismatches
  - id: no_mindiffrate
    type:
      - 'null'
      - boolean
    doc: Do not add _mindiffrate columns
    inputBinding:
      position: 102
      prefix: --no-mindiffrate
  - id: sort_by_group_size
    type:
      - 'null'
      - boolean
    doc: 'Sort by group size (largest first). Default: Sort by V/D/J gene names'
    inputBinding:
      position: 102
      prefix: --sort
  - id: v_shm_threshold
    type:
      - 'null'
      - string
    doc: V SHM threshold for _mindiffrate computations
    inputBinding:
      position: 102
      prefix: --v-shm-threshold
outputs:
  - id: members_file
    type:
      - 'null'
      - File
    doc: Write member table to FILE
    outputBinding:
      glob: $(inputs.members_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
