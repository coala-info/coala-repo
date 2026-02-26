cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virprof
  - export-fasta
label: virprof_export-fasta
doc: "Exports blastbin hits in FASTA format\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: bin_by
    type:
      - 'null'
      - string
    doc: Field to use for binning
    inputBinding:
      position: 101
      prefix: --bin-by
  - id: fasta_id_format
    type:
      - 'null'
      - string
    doc: Format for output FASTA header
    inputBinding:
      position: 101
      prefix: --fasta-id-format
  - id: file_per_bin
    type:
      - 'null'
      - boolean
    doc: Create separate file for each bin
    inputBinding:
      position: 101
      prefix: --file-per-bin
  - id: filter_lineage
    type:
      - 'null'
      - string
    doc: Filter by lineage prefix
    inputBinding:
      position: 101
      prefix: --filter-lineage
  - id: in_bins
    type: File
    doc: Bins CSV from blastbin command
    inputBinding:
      position: 101
      prefix: --in-bins
  - id: in_fasta
    type: File
    doc: FASTA file containing contigs
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_hits
    type: File
    doc: Hits CSV from blastbin command
    inputBinding:
      position: 101
      prefix: --in-hits
  - id: max_fill_length
    type:
      - 'null'
      - int
    doc: Break scaffolds if connecting contigs would require inserting more 
      basepairsthan this number.
    inputBinding:
      position: 101
      prefix: --max-fill-length
  - id: no_scaffold
    type:
      - 'null'
      - boolean
    doc: Do not merge overlapping regions
    inputBinding:
      position: 101
      prefix: --no-scaffold
  - id: out
    type:
      - 'null'
      - string
    doc: FASTA output containing bins
    inputBinding:
      position: 101
      prefix: --out
  - id: out_bins
    type:
      - 'null'
      - File
    doc: Output list of created bins
    inputBinding:
      position: 101
      prefix: --out-bins
  - id: out_scaffolds
    type:
      - 'null'
      - File
    doc: Metadata for scaffolds (CSV)
    inputBinding:
      position: 101
      prefix: --out-scaffolds
  - id: scaffold
    type:
      - 'null'
      - boolean
    doc: Do not merge overlapping regions
    inputBinding:
      position: 101
      prefix: --scaffold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
stdout: virprof_export-fasta.out
