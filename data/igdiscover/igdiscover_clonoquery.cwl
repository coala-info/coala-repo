cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - clonoquery
label: igdiscover_clonoquery
doc: "Query a table of assigned sequences by clonotype. Clonotypes for the query sequences are determined and sequences in the reference table that have this clonotype are reported. The table is written to standard output.\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: reftable
    type: File
    doc: "Reference table with parsed and filtered IgBLAST results (filtered.tsv.gz)"
    inputBinding:
      position: 1
  - id: querytable
    type: File
    doc: "Query table with IgBLAST results (assigned.tsv.gz or filtered.tsv.gz)"
    inputBinding:
      position: 2
  - id: minimum_count
    type: ['null', int]
    doc: "Discard all rows with count less than N. Default: 1"
    inputBinding:
      position: 3
      prefix: --minimum-count
  - id: cdr3_core
    type: ['null', string]
    doc: "START:END defines the non-junction region of CDR3 sequences. Default: no junction region."
    inputBinding:
      position: 3
      prefix: --cdr3-core
  - id: mismatches
    type: ['null', string]
    doc: "No. of allowed mismatches between CDR3 sequences, or a fraction between 0 and 1. Default: 1"
    inputBinding:
      position: 3
      prefix: --mismatches
  - id: aa
    type: ['null', boolean]
    doc: "Count CDR3 mismatches on amino-acid level. Default: compare nucleotides."
    inputBinding:
      position: 3
      prefix: --aa
  - id: summary_path
    type: ['null', string]
    doc: "Write summary table to FILE"
    inputBinding:
      position: 4
      prefix: --summary
outputs:
  - id: stdout
    type: stdout
    doc: "Table of matching sequences"
  - id: summary
    type: ['null', File]
    doc: "Summary table"
    outputBinding:
      glob: $(inputs.summary_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_clonoquery.out
