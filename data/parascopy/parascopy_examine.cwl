cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - examine
label: parascopy_examine
doc: "Split input regions by reference copy number.\n\nTool homepage: https://github.com/tprodanov/parascopy"
inputs:
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude duplications for which the expression is true
    default: length < 500
    inputBinding:
      position: 101
      prefix: --exclude
  - id: min_length
    type:
      - 'null'
      - int
    doc: Do not output entries shorter that the minimal length
    default: 0
    inputBinding:
      position: 101
      prefix: --min-length
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
    doc: Output bed[.gz] file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
