cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - table
label: parascopy_table
doc: "Convert homology pre-table into homology table. This command combines overlapping
  homologous regions into longer duplications.\n\nTool homepage: https://github.com/tprodanov/parascopy"
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
    type:
      type: array
      items: File
    doc: Input reference fasta file.
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: input
    type: File
    doc: Input indexed bed.gz homology pre-table.
    inputBinding:
      position: 101
      prefix: --input
  - id: regions
    type:
      - 'null'
      - string
    doc: Region(s) in format "chr" or "chr:start-end"). Start and end are 1-based
      inclusive. Commas are ignored.
    inputBinding:
      position: 101
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).
    inputBinding:
      position: 101
      prefix: --regions-file
  - id: tabix
    type:
      - 'null'
      - File
    doc: Path to "tabix" executable
    inputBinding:
      position: 101
      prefix: --tabix
  - id: tangled
    type:
      - 'null'
      - string
    doc: Exclude duplications for which the expression is true and mark regions as
      "tangled". These regions will be discarded from downstream analysis.
    inputBinding:
      position: 101
      prefix: --tangled
  - id: threads
    type:
      - 'null'
      - int
    doc: Use <int> threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Output table bed[.gz] file with homology table.
    outputBinding:
      glob: $(inputs.output)
  - id: graph
    type:
      - 'null'
      - Directory
    doc: 'Optional: output directory with duplication graphs.'
    outputBinding:
      glob: $(inputs.graph)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
