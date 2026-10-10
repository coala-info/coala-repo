cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz-tools
  - taxonomy_ranks
label: mitoz_tools_taxonomy_ranks
doc: "Get the lineage information of input taxids, species names or higher ranks (e.g. Family, Order) with the ETE3 package. ETE3 downloads the NCBI Taxonomy database on first use, so network access is needed.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: input_list
    type: File
    doc: "A file with a list of ncbi taxa ids or species names (or higher ranks, e.g. Family, Order), or a mixture of them."
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file
    type: string
    doc: "outfile"
    inputBinding:
      position: 2
      prefix: -o
  - id: print_taxid
    type:
      - 'null'
      - boolean
    doc: "Also print out the taxid for each rank"
    inputBinding:
      position: 3
      prefix: -t
  - id: print_missing
    type:
      - 'null'
      - boolean
    doc: "Also print out the records without lineage information found to the '-o <file>'"
    inputBinding:
      position: 4
      prefix: -e
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 5
      prefix: -v
outputs:
  - id: lineages
    type: File
    doc: "Lineage table."
    outputBinding:
      glob: $(inputs.output_file)
  - id: errors
    type:
      - 'null'
      - File
    doc: "Inputs without a result."
    outputBinding:
      glob: $(inputs.output_file).err
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
