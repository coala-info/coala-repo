cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - view
label: parascopy_view
doc: "View and filter homology table.\n\nTool homepage: https://github.com/tprodanov/parascopy"
inputs:
  - id: input_table
    type: File
    doc: Input indexed bed.gz homology table.
    inputBinding:
      position: 1
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude duplications for which the expression is true.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - string
    doc: Include duplications for which the expression is true.
    inputBinding:
      position: 102
      prefix: --include
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: Print commas as thousand separator and split info field into tab entries.
    inputBinding:
      position: 102
      prefix: --pretty
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) in format "chr" or "chr:start-end"). Start and end are 1-based
      inclusive. Commas are ignored.
    inputBinding:
      position: 102
      prefix: --regions
  - id: regions2
    type:
      - 'null'
      - type: array
        items: string
    doc: Second region must overlap region(s) in format "chr" or "chr:start-end").
      Start and end are 1-based inclusive. Commas are ignored.
    inputBinding:
      position: 102
      prefix: --regions2
  - id: regions2_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Second region must overlap regions from the input bed[.gz] file(s).
    inputBinding:
      position: 102
      prefix: --regions2-file
  - id: regions_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: skip_tangled
    type:
      - 'null'
      - boolean
    doc: Do not show tangled regions.
    inputBinding:
      position: 102
      prefix: --skip-tangled
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Optional: output path.'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
