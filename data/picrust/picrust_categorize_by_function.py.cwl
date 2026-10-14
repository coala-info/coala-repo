cwlVersion: v1.2
class: CommandLineTool
baseCommand: categorize_by_function.py
label: picrust_categorize_by_function.py
doc: "This script collapses hierarchical data to a specified level. For instance, often it is useful to examine KEGG results from a higher level within the pathway hierarchy. Many genes are sometimes involved in multiple pathways, and in these circumstances (also know as a one-to-many relationship), the gene is counted for each pathway.\n\nTool homepage: https://github.com/picrust/picrust"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_fp
    type: File
    doc: 'the predicted metagenome table'
    inputBinding:
      position: 101
      prefix: --input_fp
  - id: metadata_category
    type: string
    doc: 'the metadata category that describes the hierarchy (e.g. KEGG_Pathways, COG_Category)'
    inputBinding:
      position: 101
      prefix: --metadata_category
  - id: level
    type: int
    doc: 'the level in the hierarchy to collapse to; 1 is the highest level'
    inputBinding:
      position: 101
      prefix: --level
  - id: ignore
    type:
      - 'null'
      - string
    doc: 'Ignore the comma separated list of names while collapsing'
    inputBinding:
      position: 101
      prefix: --ignore
  - id: format_tab_delimited
    type:
      - 'null'
      - boolean
    doc: 'output the table in tab-delimited format instead of BIOM'
    inputBinding:
      position: 101
      prefix: --format_tab_delimited
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print information during execution'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_fp_path
    type: string
    doc: 'the resulting table'
    inputBinding:
      position: 102
      prefix: --output_fp
outputs:
  - id: output_fp
    type: File
    doc: 'the resulting table'
    outputBinding:
      glob: $(inputs.output_fp_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
