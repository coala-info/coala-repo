cwlVersion: v1.2
class: CommandLineTool
baseCommand: igblast-parser
label: igblast-parser
doc: "Parser of IgBLAST results into a csv (or tab-separated) file, one row per query
  sequence.\n\nTool homepage: https://github.com/aerijman/igblast-parser"
inputs:
  - id: in_igblast_output
    type: File
    doc: IgBLAST output file (classic format, -outfmt 3)
    inputBinding:
      position: 1
      prefix: --in
  - id: out_filename_prefix
    type: ['null', string]
    default: igblast_output
    doc: Output filename prefix; the output is <prefix>.csv, or <prefix>.tsv with tabular
    inputBinding:
      position: 2
      prefix: --out
  - id: tabular
    type: ['null', boolean]
    doc: Write a tab-separated .tsv file instead of a .csv file
    inputBinding:
      position: 3
      prefix: --tabular
outputs:
  - id: parsed_table
    type: File
    doc: Parsed IgBLAST table (.csv, or .tsv with tabular)
    outputBinding:
      glob: "$(inputs.out_filename_prefix + (inputs.tabular ? '.tsv' : '.csv'))"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igblast-parser:0.0.4--py39hf95cd2a_6
