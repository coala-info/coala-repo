cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jellyfish
  - dump
label: jellyfish_dump
doc: "Dump k-mer counts\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: db_path
    type: string
    doc: Path to the k-mer database
    inputBinding:
      position: 1
  - id: column_format
    type:
      - 'null'
      - boolean
    doc: Column format
    inputBinding:
      position: 102
      prefix: --column
  - id: lower_count
    type:
      - 'null'
      - string
    doc: Don't output k-mer with count < lower-count
    inputBinding:
      position: 102
      prefix: --lower-count
  - id: tab_separator
    type:
      - 'null'
      - boolean
    doc: Tab separator
    inputBinding:
      position: 102
      prefix: --tab
  - id: upper_count
    type:
      - 'null'
      - string
    doc: Don't output k-mer with count > upper-count
    inputBinding:
      position: 102
      prefix: --upper-count
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
