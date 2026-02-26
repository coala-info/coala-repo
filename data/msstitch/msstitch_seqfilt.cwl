cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch seqfilt
label: msstitch_seqfilt
doc: "Filter sequences based on a database lookup.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: dbfile
    type: File
    doc: Database lookup file
    inputBinding:
      position: 101
      prefix: --dbfile
  - id: deamidate
    type:
      - 'null'
      - boolean
    doc: Filter against both normal peptides and deamidated peptides where a 
      D->N transition has occurred.
    inputBinding:
      position: 101
      prefix: --deamidate
  - id: enforce_tryptic
    type:
      - 'null'
      - boolean
    doc: When filtering peptides against whole proteins, filter out peptides 
      that match a whole protein but only if they are fully tryptic, i.e. the 
      protein needs K,R 1 position upstream of the peptide, and the peptide 
      C-terminal should also be K,R. Useful when discerning from pseudogenes
    inputBinding:
      position: 101
      prefix: --enforce-tryptic
  - id: full_protein
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
      - int
    doc: Apply filter against both intact peptides and those that match to the 
      C-terminal part of a tryptic peptide from the database, resulting from 
      in-source fragmentation, where some amino acids will be missing from the 
      N-terminus. Specify the max number of amino acids that may be missing. 
      Database should be built with this flag in order for the lookup to work, 
      since sequences will be stored and looked up reversed
    inputBinding:
      position: 101
      prefix: --insourcefrag
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of peptide to be included
    inputBinding:
      position: 101
      prefix: --minlen
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
