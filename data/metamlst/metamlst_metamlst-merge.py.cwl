cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst_metamlst-merge.py
label: metamlst_metamlst-merge.py
doc: "Detects the MLST profiles from a collection of intermediate files from MetaMLST.py\n\
  \nTool homepage: https://github.com/SegataLab/metamlst"
inputs:
  - id: folder
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing .nfo MetaMLST.py files
    inputBinding:
      position: 1
  - id: database
    type:
      - 'null'
      - Directory
    doc: Specify a different MetaMLST-Database. If unset, use the default 
      Database. You can create a custom DB with metaMLST-index.py)
    inputBinding:
      position: 102
      prefix: --database
  - id: embed_metadata
    type:
      - 'null'
      - type: array
        items: string
    doc: Embed a LIST of metadata in the the output sequences (A or A+ 
      outseqformat modes). Requires a comma separated list of field names from 
      the metadata file specified with --meta
    inputBinding:
      position: 102
      prefix: -j
  - id: filter_species
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter for specific set of organisms only (METAMLST-KEYs, comma 
      separated. Use metaMLST-index.py --listspecies to get MLST keys)
    inputBinding:
      position: 102
      prefix: --filter
  - id: group_by_st
    type:
      - 'null'
      - boolean
    doc: Group the output sequences (A or A+ outseqformat modes) by ST, rather 
      than by sample. Requires -j
    inputBinding:
      position: 102
      prefix: --jgroup
  - id: id_field
    type:
      - 'null'
      - string
    doc: Field number pointing to the 'sampleID' value in the metadata file
    inputBinding:
      position: 102
      prefix: --idField
  - id: max_edit_distance
    type:
      - 'null'
      - int
    doc: Maximum Edit Distance from the closest reference to call a new MLST 
      allele.
    default: 5
    inputBinding:
      position: 102
      prefix: --ed
  - id: metadata_path
    type:
      - 'null'
      - File
    doc: Metadata file (CSV)
    inputBinding:
      position: 102
      prefix: --meta
  - id: output_sequence_format
    type:
      - 'null'
      - string
    doc: "A  : Concatenated Fasta (Only Detected STs)\nA+ : Concatenated Fasta (All
      STs)\nB  : Single loci (Only New Loci)\nB+ : Single loci (All loci)\nC  : CSV
      STs Table [default]"
    default: C
    inputBinding:
      position: 102
      prefix: --outseqformat
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst_metamlst-merge.py.out
