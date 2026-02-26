cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msstitch
  - merge
label: msstitch_merge
doc: "Merge results from multiple msstitch runs.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Multiple input files of {} format
    inputBinding:
      position: 1
  - id: dbfile
    type: File
    doc: Database lookup file
    inputBinding:
      position: 102
      prefix: --dbfile
  - id: fdrcolpattern
    type:
      - 'null'
      - string
    doc: Unique text pattern to identify FDR column in input table.
    inputBinding:
      position: 102
      prefix: --fdrcolpattern
  - id: featcol
    type:
      - 'null'
      - int
    doc: Column number in table in which desired accessions are. stored. First 
      column number is 1. Use in case of not using default column 1
    inputBinding:
      position: 102
      prefix: --featcol
  - id: flrcolpattern
    type:
      - 'null'
      - string
    doc: Unique text pattern to identify FLR (peptide PTM false localization 
      rate) column in input table.
    inputBinding:
      position: 102
      prefix: --flrcolpattern
  - id: genecentric
    type:
      - 'null'
      - boolean
    doc: For peptide table merging. Do not include protein group data in output,
      but use gene names instead to count peptides per feature, determine 
      peptide- uniqueness.
    inputBinding:
      position: 102
      prefix: --genecentric
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: Load sqlite lookup in memory in case of not having access to a fast 
      file system
    inputBinding:
      position: 102
      prefix: --in-memory
  - id: isobquantcolpattern
    type:
      - 'null'
      - string
    doc: Unique text pattern to identify isobaric quant columns in input table.
    inputBinding:
      position: 102
      prefix: --isobquantcolpattern
  - id: mergecutoff
    type:
      - 'null'
      - float
    doc: FDR cutoff when building merged protein table, to use when a cutoff has
      been used before storing the table to lookup. FDR values need to be stored
      in the lookup
    inputBinding:
      position: 102
      prefix: --mergecutoff
  - id: ms1quantcolpattern
    type:
      - 'null'
      - string
    doc: Unique text pattern to identify precursor quant column in input table.
    inputBinding:
      position: 102
      prefix: --ms1quantcolpattern
  - id: no_group_annotation
    type:
      - 'null'
      - boolean
    doc: For protein/peptide table merging. Do not include protein group or gene
      data in output, just use protein accessions.
    inputBinding:
      position: 102
      prefix: --no-group-annotation
  - id: pepcolpattern
    type:
      - 'null'
      - string
    doc: Unique text pattern to identify PEP column (given by percolator for 
      peptides) in input table.
    inputBinding:
      position: 102
      prefix: --pepcolpattern
  - id: setnames
    type:
      type: array
      items: string
    doc: Names of biological sets. Can be specified with quotation marks if 
      spaces are used
    inputBinding:
      position: 102
      prefix: --setnames
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_directory)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
