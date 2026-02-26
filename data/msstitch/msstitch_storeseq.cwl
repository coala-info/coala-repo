cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch storeseq
label: msstitch_storeseq
doc: "Store sequence information\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: cutproline
    type:
      - 'null'
      - boolean
    doc: Flag to make trypsin before a proline residue. Then filtering will be 
      done against both cut and non-cut peptides.
    inputBinding:
      position: 101
      prefix: --cutproline
  - id: dbfile
    type:
      - 'null'
      - File
    doc: Database lookup file
    inputBinding:
      position: 101
      prefix: --dbfile
  - id: fullprotein
    type:
      - 'null'
      - boolean
    doc: Store (storeseq) or use (seqfilt, seqmatch) full protein sequences (at 
      a minimum-match length) in the SQLite file rather than tryptic sequences
    inputBinding:
      position: 101
      prefix: --fullprotein
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
  - id: insourcefrag
    type:
      - 'null'
      - boolean
    doc: Apply filter against both intact peptides and those that match to the 
      C-terminal part of a tryptic peptide from the database, resulting from 
      in-source fragmentation, where some amino acids will be missing from the 
      N-terminus. Specify the max number of amino acids that may be missing. 
      Database should be built with this flag in order for the lookup to work, 
      since sequences will be stored and looked up reversed
    inputBinding:
      position: 101
      prefix: --insourcefrag
  - id: map_accessions
    type:
      - 'null'
      - boolean
    doc: Use this flag when building a peptide lookup (not --fullprotein) where 
      you want to keep the protein mapping for later use in e.g. annotating PSM 
      table with sequence hits to the passed FASTA
    inputBinding:
      position: 101
      prefix: --map-accessions
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum length of peptide to be included
    inputBinding:
      position: 101
      prefix: --minlen
  - id: miscleav
    type:
      - 'null'
      - int
    doc: Amount of missed cleavages to allow when trypsinizing, default is 0
    default: 0
    inputBinding:
      position: 101
      prefix: --miscleav
  - id: notrypsin
    type:
      - 'null'
      - boolean
    doc: Do not trypsinize. In case of using a pretrypsinized FASTA file
    inputBinding:
      position: 101
      prefix: --notrypsin
  - id: nterm_meth_loss
    type:
      - 'null'
      - boolean
    doc: Include peptides in trypsinization where the protein N-term methionine 
      residue has been lost. When used in storeseq, the filter database should 
      be built with this flag in order for the filtering to work.
    inputBinding:
      position: 101
      prefix: --nterm-meth-loss
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
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
