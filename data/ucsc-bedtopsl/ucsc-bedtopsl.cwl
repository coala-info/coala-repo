cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedToPsl
label: ucsc-bedtopsl
doc: "Convert bed format files to psl format. The result is an alignment, intended
  to allow processing by tools that operate on PSL. If the BED has at least 12 columns,
  then a PSL with blocks is created. Otherwise single-exon PSLs are created.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: chrom_sizes
    type: File
    doc: 'Chromosome sizes file (two columns: name and size).'
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: Input BED file.
    inputBinding:
      position: 2
  - id: psl_file
    type: string
    doc: Name of the output PSL file.
    inputBinding:
      position: 3
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: Use tab as a separator.
    inputBinding:
      position: 0
      prefix: -tabs
  - id: keep_query
    type:
      - 'null'
      - boolean
    doc: Instead of creating a fake query, create PSL with identical query and target
      specs. Useful if bed features are to be lifted with pslMap and one wants to
      keep the source location in the lift result.
    inputBinding:
      position: 0
      prefix: -keepQuery
outputs:
  - id: output_psl
    type: File
    doc: PSL file.
    outputBinding:
      glob: $(inputs.psl_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtopsl:482--h0b57e2e_0
