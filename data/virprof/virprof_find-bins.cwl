cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virprof
  - find-bins
label: virprof_find-bins
doc: "Collects recovered sequences into per-species files\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: in_call_files
    type: File
    doc: Text file listing (one per line) the calls CSV files from the blastbin command
    inputBinding:
      position: 101
      prefix: --in-call-files
  - id: in_fasta_files
    type: File
    doc: Text file listing (one per line) the FASTA files (gzip-compressed) matching the calls
    inputBinding:
      position: 101
      prefix: --in-fasta-files
  - id: list_members
    type:
      type: array
      items: File
    doc: The files named in the two list files; they are staged in the working directory so the names resolve.
  - id: filter_lineage
    type: string
    doc: Filter by lineage prefix (a regular expression matched at the start of the lineage; the tool crashes when it is missing, so give at least an empty-matching pattern such as .*)
    inputBinding:
      position: 101
      prefix: --filter-lineage
  - id: bin_by
    type:
      - 'null'
      - type: enum
        symbols:
          - Sacc
          - Species
          - Taxname
    default: Sacc
    doc: Field to use for binning. The tool's own default 'sacc' is rejected by its option check, so the wrapper defaults to Sacc.
    inputBinding:
      position: 101
      prefix: --bin-by
  - id: out_pattern
    type:
      - 'null'
      - string
    doc: Output FASTA file name pattern with one %s that is replaced by the bin name (tool default out%s.fasta.gz)
    inputBinding:
      position: 102
      prefix: --out
  - id: out_bins_path
    type: string
    doc: Output list of created bins
    inputBinding:
      position: 103
      prefix: --out-bins
outputs:
  - id: bin_fastas
    type:
      type: array
      items: File
    doc: One FASTA file per bin
    outputBinding:
      glob: "${ return (inputs.out_pattern ? inputs.out_pattern : 'out%s.fasta.gz').replace('%s', '*'); }"
  - id: out_bins
    type: File
    doc: Output list of created bins
    outputBinding:
      glob: $(inputs.out_bins_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.list_members)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
