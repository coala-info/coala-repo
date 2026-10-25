cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslRecalcMatch
label: ucsc-pslrecalcmatch
doc: "Recalculate match, mismatch and repMatch columns in a PSL file, using the actual
  target and query sequences. Useful if the PSL went through pslMap, or if lower-case
  repeat masking was added after the fact.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file (simple, non-translated alignments). Faster if sorted on target.
    inputBinding:
      position: 1
  - id: target_seq
    type: File
    doc: Target sequence, a .2bit file (or a nib directory).
    inputBinding:
      position: 2
  - id: query_seq
    type: File
    doc: Query sequence, a fasta, nib or .2bit file (or a list of such files).
    inputBinding:
      position: 3
  - id: out_psl
    type: string
    doc: Output PSL file name.
    inputBinding:
      position: 4
  - id: ignore_q_uniq
    type:
      - 'null'
      - boolean
    doc: Ignore everything after the last '-' in the qName field, which is
      sometimes used to generate a unique identifier.
    inputBinding:
      position: 0
      prefix: -ignoreQUniq
  - id: ignore_q_missing
    type:
      - 'null'
      - boolean
    doc: Pass through the record if querySeq does not include qName.
    inputBinding:
      position: 0
      prefix: -ignoreQMissing
outputs:
  - id: out_psl_file
    type: File
    doc: Output PSL file with recalculated match columns.
    outputBinding:
      glob: $(inputs.out_psl)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslrecalcmatch:482--h0b57e2e_0
