cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - psvs
label: parascopy_psvs
doc: "Output PSVs (paralogous-sequence variants) between homologous regions.\n\nTool
  homepage: https://github.com/tprodanov/parascopy"
inputs:
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude duplications for which the expression is true
    inputBinding:
      position: 101
      prefix: --exclude
  - id: fasta_ref
    type: File
    doc: Input reference fasta file.
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) in format "chr" or "chr:start-end"). Start and end are 1-based
      inclusive. Commas are ignored.
    inputBinding:
      position: 101
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).
    inputBinding:
      position: 101
      prefix: --regions-file
  - id: table
    type: File
    doc: Input indexed bed.gz homology table.
    inputBinding:
      position: 101
      prefix: --table
outputs:
  - id: output
    type: File
    doc: Output vcf[.gz] file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
