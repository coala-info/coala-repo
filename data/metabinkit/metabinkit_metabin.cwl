cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabin
label: metabinkit_metabin
doc: "Taxonomic binning of BLAST results by percent identity thresholds at species, genus, family and above-family level.\n\nTool homepage: https://github.com/envmetagen/metabinkit"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type: File
    doc: "TSV file name (BLAST table)"
    inputBinding:
      position: 100
      prefix: --input
  - id: out_prefix
    type: string
    doc: "Output file prefix"
    inputBinding:
      position: 100
      prefix: --out
  - id: species_threshold
    type: 
      - 'null'
      - float
    doc: "species %id threshold [default= 99]"
    inputBinding:
      position: 100
      prefix: --Species
  - id: genus_threshold
    type: 
      - 'null'
      - float
    doc: "genus %id threshold [default= 97]"
    inputBinding:
      position: 100
      prefix: --Genus
  - id: family_threshold
    type: 
      - 'null'
      - float
    doc: "family %id threshold [default= 95]"
    inputBinding:
      position: 100
      prefix: --Family
  - id: above_family_threshold
    type: 
      - 'null'
      - float
    doc: "above family %id threshold [default= 90]"
    inputBinding:
      position: 100
      prefix: --AboveF
  - id: taxonomy_db_dir
    type: 
      - 'null'
      - Directory
    doc: "directory containing the taxonomy db (nodes.dmp and names.dmp) [default: db folder of the image]"
    inputBinding:
      position: 100
      prefix: --db
  - id: species_neg_filter
    type: 
      - 'null'
      - File
    doc: "negative filter (file with one word per line)"
    inputBinding:
      position: 100
      prefix: --SpeciesNegFilter
  - id: species_blacklist
    type: 
      - 'null'
      - File
    doc: "species blacklist (file with one taxid per line)"
    inputBinding:
      position: 100
      prefix: --SpeciesBL
  - id: genus_blacklist
    type: 
      - 'null'
      - File
    doc: "genera blacklist (file with one taxid per line)"
    inputBinding:
      position: 100
      prefix: --GenusBL
  - id: family_blacklist
    type: 
      - 'null'
      - File
    doc: "families blacklist (file with one taxid per line)"
    inputBinding:
      position: 100
      prefix: --FamilyBL
  - id: filter_file
    type: 
      - 'null'
      - File
    doc: "file name with the entries from the input to exclude (one entry per line)"
    inputBinding:
      position: 100
      prefix: --FilterFile
  - id: filter_column
    type: 
      - 'null'
      - string
    doc: "Column name to look for the values found in the file given with --FilterFile [default= sseqid]"
    inputBinding:
      position: 100
      prefix: --FilterCol
  - id: rm_predicted
    type: 
      - 'null'
      - string
    doc: "Column name where to look for in-silico 'predicted' entries (XM_, XR_, XP_); no filter if not given"
    inputBinding:
      position: 100
      prefix: --rm_predicted
  - id: top_species
    type: 
      - 'null'
      - int
    doc: "Top species hits to consider [default= 100]"
    inputBinding:
      position: 100
      prefix: --TopSpecies
  - id: top_genus
    type: 
      - 'null'
      - int
    doc: "Top genus hits to consider [default= 100]"
    inputBinding:
      position: 100
      prefix: --TopGenus
  - id: top_family
    type: 
      - 'null'
      - int
    doc: "Top family hits to consider [default= 100]"
    inputBinding:
      position: 100
      prefix: --TopFamily
  - id: top_af
    type: 
      - 'null'
      - int
    doc: "Top above-family hits to consider [default= 100]"
    inputBinding:
      position: 100
      prefix: --TopAF
  - id: quiet
    type: 
      - 'null'
      - boolean
    doc: "enable quiet mode (less messages are printed to stdout)"
    inputBinding:
      position: 100
      prefix: --quiet
  - id: no_mbk
    type: 
      - 'null'
      - boolean
    doc: "Do not use mbk: codes in the output file to explain why a sequence was not binned at a given level (NA is used throughout)"
    inputBinding:
      position: 100
      prefix: --no_mbk
  - id: sp_discard_sp
    type: 
      - 'null'
      - boolean
    doc: "Discard species with sp. in the name"
    inputBinding:
      position: 100
      prefix: --sp_discard_sp
  - id: sp_discard_mt2w
    type: 
      - 'null'
      - boolean
    doc: "Discard species with more than two words"
    inputBinding:
      position: 100
      prefix: --sp_discard_mt2w
  - id: sp_discard_num
    type: 
      - 'null'
      - boolean
    doc: "Discard species with numbers"
    inputBinding:
      position: 100
      prefix: --sp_discard_num
  - id: minimal_cols
    type: 
      - 'null'
      - boolean
    doc: "Include only the seqid and lineage information in the output table [FALSE]"
    inputBinding:
      position: 100
      prefix: --minimal_cols
outputs:
  - id: outputs
    type: File[]
    doc: "Binned tables with the output prefix (<out>.tsv, <out>.info.tsv, <out>.versions.txt)"
    outputBinding:
      glob: $(inputs.out_prefix)*
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinkit:0.2.3--r44h1104d80_3
stdout: metabin.out
stderr: metabin.log
