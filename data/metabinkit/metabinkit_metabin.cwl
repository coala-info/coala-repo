cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabin
label: metabinkit_metabin
doc: "metabin\n\nTool homepage: https://github.com/envmetagen/metabinkit"
inputs:
  - id: above_family_threshold
    type:
      - 'null'
      - float
    doc: above family %id threshold
    inputBinding:
      position: 101
      prefix: --AboveF
  - id: family_blacklist
    type:
      - 'null'
      - File
    doc: families blacklist (file with one taxid per line)
    inputBinding:
      position: 101
      prefix: --FamilyBL
  - id: family_threshold
    type:
      - 'null'
      - float
    doc: family %id threshold
    inputBinding:
      position: 101
      prefix: --Family
  - id: filter_column
    type:
      - 'null'
      - string
    doc: Column name to look for the values found the the file provided in the 
      --Filter parameter
    inputBinding:
      position: 101
      prefix: --FilterCol
  - id: filter_file
    type:
      - 'null'
      - File
    doc: file name with the entries from the input to exclude (on entry per 
      line)
    inputBinding:
      position: 101
      prefix: --FilterFile
  - id: genus_blacklist
    type:
      - 'null'
      - File
    doc: genera blacklist (file with one taxid per line)
    inputBinding:
      position: 101
      prefix: --GenusBL
  - id: genus_threshold
    type:
      - 'null'
      - float
    doc: genus %id threshold
    inputBinding:
      position: 101
      prefix: --Genus
  - id: input_file
    type:
      - 'null'
      - File
    doc: TSV file name
    inputBinding:
      position: 101
      prefix: --input
  - id: minimal_cols
    type:
      - 'null'
      - boolean
    doc: Include only the seqid and lineage information in the output table
    inputBinding:
      position: 101
      prefix: --minimal_cols
  - id: no_mbk
    type:
      - 'null'
      - boolean
    doc: 'Do not use mbk: codes in the output file to explain why a sequence was not
      binned at a given level (NA is used throughout)'
    inputBinding:
      position: 101
      prefix: --no_mbk
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: enable quiet mode (less messages are printed to stdout)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rm_predicted_column
    type:
      - 'null'
      - string
    doc: Where to look (column name) for in-silico 'predicted' entries (XM_,XR_,
      and XP_). If no column is given then the filter is not applied.
    inputBinding:
      position: 101
      prefix: --rm_predicted
  - id: sp_discard_mt2w
    type:
      - 'null'
      - boolean
    doc: Discard species with more than two words
    inputBinding:
      position: 101
      prefix: --sp_discard_mt2w
  - id: sp_discard_num
    type:
      - 'null'
      - boolean
    doc: Discard species with numbers
    inputBinding:
      position: 101
      prefix: --sp_discard_num
  - id: sp_discard_sp
    type:
      - 'null'
      - boolean
    doc: Discard species with sp. in the name
    inputBinding:
      position: 101
      prefix: --sp_discard_sp
  - id: species_blacklist
    type:
      - 'null'
      - File
    doc: species blacklist (file with one taxid per line)
    inputBinding:
      position: 101
      prefix: --SpeciesBL
  - id: species_neg_filter
    type:
      - 'null'
      - File
    doc: negative filter (file with one word per line)
    inputBinding:
      position: 101
      prefix: --SpeciesNegFilter
  - id: species_threshold
    type:
      - 'null'
      - float
    doc: species %id threshold
    inputBinding:
      position: 101
      prefix: --Species
  - id: taxonomy_db_dir
    type:
      - 'null'
      - Directory
    doc: directory containing the taxonomy db (nodes.dmp and names.dmp)
    inputBinding:
      position: 101
      prefix: --db
  - id: top_af
    type:
      - 'null'
      - int
    doc: above family?
    inputBinding:
      position: 101
      prefix: --TopAF
  - id: top_family
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --TopFamily
  - id: top_genus
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --TopGenus
  - id: top_species
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --TopSpecies
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file prefix
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinkit:0.2.3--r44h1104d80_3
