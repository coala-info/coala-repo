cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamToPsl
label: ucsc-bamtopsl
doc: "Convert a BAM file to a PSL file.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: allow_skipped_query
    type:
      - 'null'
      - boolean
    doc: Allow skipped query bases (e.g. RNA-seq)
    inputBinding:
      position: 102
      prefix: -allowSkippedQuery
  - id: chrom_alias
    type:
      - 'null'
      - File
    doc: 'Specifies a two-column file: <alias> <chromName>'
    inputBinding:
      position: 102
      prefix: -chromAlias
  - id: dots
    type:
      - 'null'
      - int
    doc: Output a dot every N alignments
    inputBinding:
      position: 102
      prefix: -dots
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not output the psl header
    inputBinding:
      position: 102
      prefix: -noHeader
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bamtopsl:482--h0b57e2e_0
