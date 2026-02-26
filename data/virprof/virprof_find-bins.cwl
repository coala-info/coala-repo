cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virprof
  - find-bins
label: virprof_find-bins
doc: "Collects recovered sequences into per-species files\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: bin_by
    type:
      - 'null'
      - string
    doc: Field to use for binning
    inputBinding:
      position: 101
      prefix: --bin-by
  - id: filter_lineage
    type:
      - 'null'
      - string
    doc: Filter by lineage prefix
    inputBinding:
      position: 101
      prefix: --filter-lineage
  - id: in_call_files
    type: string
    doc: Calls CSV from blastbin command
    inputBinding:
      position: 101
      prefix: --in-call-files
  - id: in_fasta_files
    type: string
    doc: FASTA matching
    inputBinding:
      position: 101
      prefix: --in-fasta-files
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: FASTA output containing bins
    outputBinding:
      glob: $(inputs.out)
  - id: out_bins
    type:
      - 'null'
      - File
    doc: Output list of created bins
    outputBinding:
      glob: $(inputs.out_bins)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
