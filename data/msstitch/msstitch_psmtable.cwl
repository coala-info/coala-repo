cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msstitch
  - psmtable
label: msstitch_psmtable
doc: "Processes PSM tables with various options for analysis and output.\n\nTool homepage:
  https://github.com/lehtiolab/msstitch"
inputs:
  - id: add_bio_set
    type:
      - 'null'
      - boolean
    doc: Add biological setname from DB lookup to PSM table
    inputBinding:
      position: 101
      prefix: --addbioset
  - id: add_miscleavage
    type:
      - 'null'
      - boolean
    doc: Add missed cleavages to PSM table
    inputBinding:
      position: 101
      prefix: --addmiscleav
  - id: db_file
    type: File
    doc: Database lookup file
    inputBinding:
      position: 101
      prefix: --dbfile
  - id: fasta_delimiter
    type:
      - 'null'
      - string
    doc: Delimiter in FASTA header, used to parse gene names in case of 
      non-ENSEMBL/Uniprot
    inputBinding:
      position: 101
      prefix: --fastadelim
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: FASTA sequence database
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gene_field
    type:
      - 'null'
      - int
    doc: Field nr (first=1) in FASTA that contains gene name when using 
      --fastadelim to parse the gene names
    inputBinding:
      position: 101
      prefix: --genefield
  - id: genes
    type:
      - 'null'
      - boolean
    doc: Specifies to add genes to PSM table
    inputBinding:
      position: 101
      prefix: --genes
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: Load sqlite lookup in memory in case of not having access to a fast 
      file system
    inputBinding:
      position: 101
      prefix: --in-memory
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: isobaric
    type:
      - 'null'
      - boolean
    doc: Specifies to add isobaric quant data from lookup DB to output table
    inputBinding:
      position: 101
      prefix: --isobaric
  - id: min_precursor_purity
    type:
      - 'null'
      - float
    doc: Minimum purity of precursor required to output isobaric quantification 
      data, MS2 scans with purity below this value will be assigned NA in 
      isobaric channels
    inputBinding:
      position: 101
      prefix: --min-precursor-purity
  - id: ms1_quant
    type:
      - 'null'
      - boolean
    doc: Specifies to add precursor quant data from lookup DB to output table
    inputBinding:
      position: 101
      prefix: --ms1quant
  - id: old_psm_file
    type:
      - 'null'
      - File
    doc: PSM table file containing previously analysed PSMs to append new PSM 
      table to.
    inputBinding:
      position: 101
      prefix: --oldpsms
  - id: protein_group
    type:
      - 'null'
      - boolean
    doc: Specifies to add protein groups to PSM table
    inputBinding:
      position: 101
      prefix: --proteingroup
  - id: spectra_column
    type:
      - 'null'
      - int
    doc: Column number in which spectra file names are, in case some framework 
      has changed the file names. First column number is 1.
    inputBinding:
      position: 101
      prefix: --spectracol
  - id: unroll
    type:
      - 'null'
      - boolean
    doc: PSM table from Mzid2TSV contains either one PSM per line with all the 
      proteins of that shared peptide on the same line (not unrolled, default), 
      or one PSM/protein match per line where each protein from that shared 
      peptide gets its own line (unrolled).
    inputBinding:
      position: 101
      prefix: --unroll
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
