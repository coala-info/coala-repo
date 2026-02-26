cwlVersion: v1.2
class: CommandLineTool
baseCommand: otu_to_tax_name.py
label: phylotoast_otu_to_tax_name.py
doc: "Convert a list of OTU IDs to a list of OTU IDs paired with Genus_Species identifiers
  and perform reverse lookup, if needed.\n\nTool homepage: https://github.com/smdabdoub/phylotoast"
inputs:
  - id: otu_id_fp
    type: File
    doc: A single or multi-column (tab-separated) file containing the OTU IDs to
      be converted in the first column.
    inputBinding:
      position: 101
      prefix: --otu_id_fp
  - id: otu_table
    type: File
    doc: Input biom file format OTU table.
    inputBinding:
      position: 101
      prefix: --otu_table
  - id: reverse_lookup
    type:
      - 'null'
      - boolean
    doc: Get OTUIDs from genus-species OTU name.
    inputBinding:
      position: 101
      prefix: --reverse_lookup
outputs:
  - id: output_fp
    type: File
    doc: For a list input, a new file containing a list of OTU IDs and their 
      corresponding short taxonomic identifiers separated by tabs. For a BIOM 
      file input, a new mapping file with all the OTU IDs replaced by the short 
      identifier.
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
