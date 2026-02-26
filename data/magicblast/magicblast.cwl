cwlVersion: v1.2
class: CommandLineTool
baseCommand: magicblast
label: magicblast
doc: "Short read mapper\n\nTool homepage: https://ncbi.github.io/magicblast/"
inputs:
  - id: database_name
    type:
      - 'null'
      - string
    doc: BLAST database name
    inputBinding:
      position: 101
      prefix: -db
  - id: db_hard_mask
    type:
      - 'null'
      - string
    doc: Filtering algorithm ID to apply to the BLAST database as hard masking
    inputBinding:
      position: 101
      prefix: -db_hard_mask
  - id: db_soft_mask
    type:
      - 'null'
      - string
    doc: Filtering algorithm ID to apply to the BLAST database as soft masking
    inputBinding:
      position: 101
      prefix: -db_soft_mask
  - id: fr
    type:
      - 'null'
      - boolean
    doc: Strand specific reads forward/reverse
    inputBinding:
      position: 101
      prefix: -fr
  - id: gapextend
    type:
      - 'null'
      - int
    doc: Cost to extend a gap
    default: 4
    inputBinding:
      position: 101
      prefix: -gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Cost to open a gap
    default: 0
    inputBinding:
      position: 101
      prefix: -gapopen
  - id: gilist
    type:
      - 'null'
      - File
    doc: Restrict search of database to list of GIs
    inputBinding:
      position: 101
      prefix: -gilist
  - id: gzo
    type:
      - 'null'
      - boolean
    doc: Output will be compressed
    inputBinding:
      position: 101
      prefix: -gzo
  - id: infmt
    type:
      - 'null'
      - string
    doc: Input format for sequences
    default: fasta
    inputBinding:
      position: 101
      prefix: -infmt
  - id: lcase_masking
    type:
      - 'null'
      - boolean
    doc: Use lower case filtering in subject sequence(s)?
    inputBinding:
      position: 101
      prefix: -lcase_masking
  - id: limit_lookup
    type:
      - 'null'
      - boolean
    doc: Remove word seeds with high frequency in the searched database
    default: true
    inputBinding:
      position: 101
      prefix: -limit_lookup
  - id: lookup_stride
    type:
      - 'null'
      - int
    doc: Number of words to skip after collecting one while creating a lookup 
      table
    default: 0
    inputBinding:
      position: 101
      prefix: -lookup_stride
  - id: max_db_word_count
    type:
      - 'null'
      - int
    doc: Words that appear more than this number of times in the database will 
      be masked in the lookup table
    default: 30
    inputBinding:
      position: 101
      prefix: -max_db_word_count
  - id: max_edit_dist
    type:
      - 'null'
      - int
    doc: Cutoff edit distance for accepting an alignment
    inputBinding:
      position: 101
      prefix: -max_edit_dist
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Maximum allowed intron length
    default: 500000
    inputBinding:
      position: 101
      prefix: -max_intron_length
  - id: md_tag
    type:
      - 'null'
      - boolean
    doc: Include MD tag in SAM report
    inputBinding:
      position: 101
      prefix: -md_tag
  - id: negative_gilist
    type:
      - 'null'
      - File
    doc: Restrict search of database to everything except the specified GIs
    inputBinding:
      position: 101
      prefix: -negative_gilist
  - id: negative_seqidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to everything except the specified SeqIDs
    inputBinding:
      position: 101
      prefix: -negative_seqidlist
  - id: negative_taxidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to everything except the specified taxonomy
      IDs
    inputBinding:
      position: 101
      prefix: -negative_taxidlist
  - id: negative_taxids
    type:
      - 'null'
      - string
    doc: Restrict search of database to everything except the specified taxonomy
      IDs (multiple IDs delimited by ',')
    inputBinding:
      position: 101
      prefix: -negative_taxids
  - id: no_discordant
    type:
      - 'null'
      - boolean
    doc: Suppress discordant alignments for paired reads
    inputBinding:
      position: 101
      prefix: -no_discordant
  - id: no_query_id_trim
    type:
      - 'null'
      - boolean
    doc: Do not trim '.1', '/1', '.2', or '/2' at the end of read ids for SAM 
      format andpaired runs
    inputBinding:
      position: 101
      prefix: -no_query_id_trim
  - id: no_unaligned
    type:
      - 'null'
      - boolean
    doc: Do not report unaligned reads
    inputBinding:
      position: 101
      prefix: -no_unaligned
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (CPUs) to use in the BLAST search
    default: 1
    inputBinding:
      position: 101
      prefix: -num_threads
  - id: outfmt
    type:
      - 'null'
      - string
    doc: 'alignment view options: sam = SAM format, tabular = Tabular format, asn
      = text ASN.1'
    default: sam
    inputBinding:
      position: 101
      prefix: -outfmt
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Input query sequences are paired
    inputBinding:
      position: 101
      prefix: -paired
  - id: parse_deflines
    type:
      - 'null'
      - boolean
    doc: Should the query and subject defline(s) be parsed?
    default: true
    inputBinding:
      position: 101
      prefix: -parse_deflines
  - id: penalty
    type:
      - 'null'
      - int
    doc: Penalty for a nucleotide mismatch
    default: -4
    inputBinding:
      position: 101
      prefix: -penalty
  - id: perc_identity
    type:
      - 'null'
      - float
    doc: Percent identity cutoff for alignments
    default: 0.0
    inputBinding:
      position: 101
      prefix: -perc_identity
  - id: query
    type:
      - 'null'
      - File
    doc: Input file name
    inputBinding:
      position: 101
      prefix: -query
  - id: query_mate
    type:
      - 'null'
      - File
    doc: FASTA file with mates for query sequences (if given in another file)
    inputBinding:
      position: 101
      prefix: -query_mate
  - id: reftype
    type:
      - 'null'
      - string
    doc: 'Type of the reference: genome or transcriptome'
    default: genome
    inputBinding:
      position: 101
      prefix: -reftype
  - id: rf
    type:
      - 'null'
      - boolean
    doc: Strand specific reads reverse/forward
    inputBinding:
      position: 101
      prefix: -rf
  - id: score
    type:
      - 'null'
      - string
    doc: 'Cutoff score for accepting alignments. Can be expressed as a number or a
      function of read length: L,b,a for a * length + b.'
    default: '0'
    inputBinding:
      position: 101
      prefix: -score
  - id: seqidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to list of SeqIDs
    inputBinding:
      position: 101
      prefix: -seqidlist
  - id: splice
    type:
      - 'null'
      - boolean
    doc: Search for spliced alignments
    default: true
    inputBinding:
      position: 101
      prefix: -splice
  - id: sra
    type:
      - 'null'
      - string
    doc: Comma-separated SRA accessions
    inputBinding:
      position: 101
      prefix: -sra
  - id: sra_batch
    type:
      - 'null'
      - File
    doc: File with a list of SRA accessions, one per line
    inputBinding:
      position: 101
      prefix: -sra_batch
  - id: sra_cache
    type:
      - 'null'
      - boolean
    doc: Enable SRA caching in local files
    inputBinding:
      position: 101
      prefix: -sra_cache
  - id: subject
    type:
      - 'null'
      - File
    doc: Subject sequence(s) to search
    inputBinding:
      position: 101
      prefix: -subject
  - id: subject_loc
    type:
      - 'null'
      - string
    doc: 'Location on the subject sequence in 1-based offsets (Format: start-stop)'
    inputBinding:
      position: 101
      prefix: -subject_loc
  - id: tag
    type:
      - 'null'
      - string
    doc: A user tag to add to each alignment
    inputBinding:
      position: 101
      prefix: -tag
  - id: taxidlist
    type:
      - 'null'
      - File
    doc: Restrict search of database to include only the specified taxonomy IDs
    inputBinding:
      position: 101
      prefix: -taxidlist
  - id: taxids
    type:
      - 'null'
      - string
    doc: Restrict search of database to include only the specified taxonomy IDs 
      (multiple IDs delimited by ',')
    inputBinding:
      position: 101
      prefix: -taxids
  - id: unaligned_fmt
    type:
      - 'null'
      - string
    doc: 'format for reporting unaligned reads: sam = SAM format, tabular = Tabular
      format, fasta = sequences in FASTA format'
    inputBinding:
      position: 101
      prefix: -unaligned_fmt
  - id: validate_seqs
    type:
      - 'null'
      - boolean
    doc: Reject low quality sequences
    default: true
    inputBinding:
      position: 101
      prefix: -validate_seqs
  - id: word_size
    type:
      - 'null'
      - int
    doc: Minimum number of consecutive bases matching exactly
    default: 18
    inputBinding:
      position: 101
      prefix: -word_size
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
  - id: out_unaligned
    type:
      - 'null'
      - File
    doc: Report unaligned reads to this file
    outputBinding:
      glob: $(inputs.out_unaligned)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magicblast:1.7.0--hf1761c0_0
