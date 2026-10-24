cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainToPsl
label: ucsc-chaintopsl
doc: "Convert chain file to psl format. The target and query sequences can be fasta
  files, nib files, 2bit files or a list of fasta, 2bit and/or nib files, one per
  line.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: target_sizes
    type: File
    doc: Tab-delimited file with <seqName> <size> columns for the target
    inputBinding:
      position: 2
  - id: query_sizes
    type: File
    doc: Tab-delimited file with <seqName> <size> columns for the query
    inputBinding:
      position: 3
  - id: target_seq
    type: File
    doc: Target sequence (fasta, nib or 2bit file, or a list of such files)
    inputBinding:
      position: 4
  - id: query_seq
    type: File
    doc: Query sequence (fasta, nib or 2bit file, or a list of such files)
    inputBinding:
      position: 5
  - id: out_psl
    type: string
    doc: Name of the output psl file
    inputBinding:
      position: 6
outputs:
  - id: output_psl
    type: File
    doc: Output psl file
    outputBinding:
      glob: $(inputs.out_psl)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chaintopsl:482--h0b57e2e_0
