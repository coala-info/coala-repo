cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - clonotypes
label: igdiscover_clonotypes
doc: "Group assigned sequences by clonotype. The output is a table with one row per clonotype, written to standard output; optionally a table of all members can be written.\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: table
    type: File
    doc: "Table with parsed and filtered IgBLAST results"
    inputBinding:
      position: 1
  - id: sort_by_group_size
    type: ['null', boolean]
    doc: "Sort by group size (largest first). Default: sort by V/D/J gene names"
    inputBinding:
      position: 2
      prefix: --sort
  - id: limit
    type: ['null', int]
    doc: "Print out only the first N groups"
    inputBinding:
      position: 2
      prefix: --limit
  - id: v_shm_threshold
    type: ['null', string]
    doc: "V SHM threshold for _mindiffrate computations"
    inputBinding:
      position: 2
      prefix: --v-shm-threshold
  - id: cdr3_core
    type: ['null', string]
    doc: "START:END defines the non-junction region of CDR3 sequences. Default: no junction region."
    inputBinding:
      position: 2
      prefix: --cdr3-core
  - id: mismatches
    type: ['null', string]
    doc: "No. of allowed mismatches between CDR3 sequences, or a fraction between 0 and 1. Default: 1"
    inputBinding:
      position: 2
      prefix: --mismatches
  - id: amino_acid_mismatches
    type: ['null', boolean]
    doc: "Count CDR3 mismatches on amino-acid level. Default: compare nucleotides."
    inputBinding:
      position: 2
      prefix: --aa
  - id: no_mindiffrate
    type: ['null', boolean]
    doc: "Do not add _mindiffrate columns"
    inputBinding:
      position: 2
      prefix: --no-mindiffrate
  - id: members_file_path
    type: ['null', string]
    doc: "Write member table to FILE"
    inputBinding:
      position: 3
      prefix: --members
outputs:
  - id: stdout
    type: stdout
    doc: "Table with one row per clonotype"
  - id: members_file
    type: ['null', File]
    doc: "Member table, one row per input sequence"
    outputBinding:
      glob: $(inputs.members_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_clonotypes.out
