cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3ToPsl
label: ucsc-gff3topsl
doc: "Convert a GFF3 CIGAR file to a PSL file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: drop_q
    type: ['null', boolean]
    doc: Drop record when the query is not found in queryChromSizes
    inputBinding:
      prefix: -dropQ
      position: 1
  - id: drop_t
    type: ['null', boolean]
    doc: Drop record when the target is not found in targetChromSizes
    inputBinding:
      prefix: -dropT
      position: 2
  - id: query_chrom_sizes
    type: File
    doc: File with query (main coordinates) chromosome sizes, formatted as chromName<tab>chromSize
    inputBinding:
      position: 3
  - id: target_chrom_sizes
    type: File
    doc: File with target (Target attribute) chromosome sizes
    inputBinding:
      position: 4
  - id: in_gff3
    type: File
    doc: GFF3 formatted file with Gap attribute in match records
    inputBinding:
      position: 5
  - id: out_psl
    type: string
    doc: PSL formatted output file name
    inputBinding:
      position: 6
outputs:
  - id: psl
    type: File
    doc: PSL formatted output
    outputBinding:
      glob: $(inputs.out_psl)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gff3topsl:482--h0b57e2e_0
