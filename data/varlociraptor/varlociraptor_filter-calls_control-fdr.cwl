cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - filter-calls
  - control-fdr
label: varlociraptor_filter-calls_control-fdr
doc: 'Filter variant calls by controlling FDR. Filtered calls are printed to standard
  output.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: calls
    type: File
    doc: BCF file with varlociraptor calls.
    inputBinding:
      position: 1
  - id: events
    type:
      - 'null'
      - type: array
        items: string
    doc: Events to consider.
    inputBinding:
      position: 100
      prefix: --events
  - id: fdr
    type:
      - 'null'
      - float
    doc: FDR to control for.
    inputBinding:
      position: 100
      prefix: --fdr
  - id: maxlen
    type:
      - 'null'
      - int
    doc: Maximum indel length to consider (exclusive).
    inputBinding:
      position: 100
      prefix: --maxlen
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum indel length to consider.
    inputBinding:
      position: 100
      prefix: --minlen
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Mode of FDR control (recommended: local-smart). Choose between local or
      global and strict or smart, combined via a hyphen (e.g. local-smart).'
    inputBinding:
      position: 100
      prefix: --mode
  - id: vartype
    type:
      - 'null'
      - string
    doc: 'Variant type to consider: INS, DEL, METH, SNV, MNV, BND, INV, DUP, REP,
      REF'
    inputBinding:
      position: 100
      prefix: --var
  - id: smart_retain_artifacts
    type:
      - 'null'
      - boolean
    doc: Whether smart mode shall retain artifact calls instead of taking the sum
      of artifact probability and absent probability for determining whether a variant
      shall be filtered.
    inputBinding:
      position: 100
      prefix: --smart-retain-artifacts
outputs:
  - id: filtered_calls
    type: stdout
    doc: Filtered calls in BCF format
stdout: calls.filtered.bcf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
