cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - clonoquery
label: igdiscover_clonoquery
doc: "Query a table of assigned sequences by clonotype\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: reftable
    type: File
    doc: Reference table with parsed and filtered IgBLAST results (filtered.tab)
    inputBinding:
      position: 1
  - id: querytable
    type: File
    doc: Query table with IgBLAST results (assigned.tab or filtered.tab)
    inputBinding:
      position: 2
  - id: aa
    type:
      - 'null'
      - boolean
    doc: 'Count CDR3 mismatches on amino-acid level. Default: Compare nucleotides.'
    inputBinding:
      position: 103
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
      position: 103
      prefix: --cdr3-core
  - id: minimum_count
    type:
      - 'null'
      - int
    doc: Discard all rows with count less than N.
    inputBinding:
      position: 103
      prefix: --minimum-count
  - id: mismatches
    type:
      - 'null'
      - string
    doc: No. of allowed mismatches between CDR3 sequences. Can also be a 
      fraction between 0 and 1 (such as 0.15), interpreted relative to the 
      length of the CDR3 (minus the front non-core).
    inputBinding:
      position: 103
      prefix: --mismatches
outputs:
  - id: summary
    type:
      - 'null'
      - File
    doc: Write summary table to FILE
    outputBinding:
      glob: $(inputs.summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
