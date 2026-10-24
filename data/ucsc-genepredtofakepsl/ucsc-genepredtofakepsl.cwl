cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToFakePsl
label: ucsc-genepredtofakepsl
doc: "Create a psl of fake-mRNA aligned to gene-preds from a file or table.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: db
    type: string
    doc: Database name (e.g., hg19)
    inputBinding:
      position: 1
  - id: gene_pred
    type: File
    doc: Input genePred file (if it is an existing file it is used, otherwise it names a database table)
    inputBinding:
      position: 2
  - id: psl_out_name
    type: string
    doc: Name of the fake-mRNA output psl file
    inputBinding:
      position: 3
  - id: cds_out_name
    type: string
    doc: Name of the output cds tab-separated file with genbank-style CDS records (cdsStart..cdsEnd)
    inputBinding:
      position: 4
  - id: chrom_size
    type:
      - 'null'
      - File
    doc: Read chrom sizes from this file instead of the database (two white space separated fields per line, chrom name and size)
    inputBinding:
      position: 101
      prefix: -chromSize=
      separate: false
  - id: q_sizes
    type:
      - 'null'
      - File
    doc: Read in query sizes to fix up qSize and qStarts
    inputBinding:
      position: 101
      prefix: -qSizes=
      separate: false
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: $(inputs.psl_out_name)
  - id: out_cds
    type: File
    doc: Output CDS file
    outputBinding:
      glob: $(inputs.cds_out_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtofakepsl:482--h0b57e2e_1
