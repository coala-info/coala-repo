cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastn
label: blast_blastn
doc: Nucleotide-Nucleotide BLAST 2.17.0+
inputs:
  - id: query
    type: File
    doc: Input file name
    inputBinding:
      position: 101
      prefix: -query
  - id: query_loc
    type:
      - 'null'
      - string
    doc: 'Location on the query sequence in 1-based offsets (Format: start-stop)'
    inputBinding:
      position: 101
      prefix: -query_loc
  - id: strand
    type:
      - 'null'
      - string
    doc: Query strand(s) to search against database/subject
    inputBinding:
      position: 101
      prefix: -strand
  - id: task
    type:
      - 'null'
      - string
    doc: Task to execute (blastn, blastn-short, dc-megablast, megablast, 
      rmblastn)
    inputBinding:
      position: 101
      prefix: -task
  - id: db
    type:
      - 'null'
      - string
    doc: BLAST database name
    inputBinding:
      position: 101
      prefix: -db
  - id: out
    type: string
    doc: Output file name
    inputBinding:
      position: 101
      prefix: -out
  - id: evalue
    type:
      - 'null'
      - float
    doc: Expectation value (E) threshold for saving hits
    inputBinding:
      position: 101
      prefix: -evalue
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size for wordfinder algorithm
    inputBinding:
      position: 101
      prefix: -word_size
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Cost to open a gap
    inputBinding:
      position: 101
      prefix: -gapopen
  - id: gapextend
    type:
      - 'null'
      - int
    doc: Cost to extend a gap
    inputBinding:
      position: 101
      prefix: -gapextend
  - id: penalty
    type:
      - 'null'
      - int
    doc: Penalty for a nucleotide mismatch
    inputBinding:
      position: 101
      prefix: -penalty
  - id: reward
    type:
      - 'null'
      - int
    doc: Reward for a nucleotide match
    inputBinding:
      position: 101
      prefix: -reward
  - id: use_index
    type:
      - 'null'
      - boolean
    doc: Use MegaBLAST database index
    inputBinding:
      position: 101
      prefix: -use_index
  - id: index_name
    type:
      - 'null'
      - string
    doc: MegaBLAST database index name
    inputBinding:
      position: 101
      prefix: -index_name
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
    doc: Location on the subject sequence in 1-based offsets
    inputBinding:
      position: 101
      prefix: -subject_loc
  - id: outfmt
    type:
      - 'null'
      - string
    doc: Alignment view options
    inputBinding:
      position: 101
      prefix: -outfmt
  - id: show_gis
    type:
      - 'null'
      - boolean
    doc: Show NCBI GIs in deflines?
    inputBinding:
      position: 101
      prefix: -show_gis
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: Number of database sequences to show one-line descriptions for
    inputBinding:
      position: 101
      prefix: -num_descriptions
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: Number of database sequences to show alignments for
    inputBinding:
      position: 101
      prefix: -num_alignments
  - id: line_length
    type:
      - 'null'
      - int
    doc: Line length for formatting alignments
    inputBinding:
      position: 101
      prefix: -line_length
  - id: html
    type:
      - 'null'
      - boolean
    doc: Produce HTML output?
    inputBinding:
      position: 101
      prefix: -html
  - id: sorthits
    type:
      - 'null'
      - int
    doc: Sorting option for hits
    inputBinding:
      position: 101
      prefix: -sorthits
  - id: sorthsps
    type:
      - 'null'
      - int
    doc: Sorting option for hps
    inputBinding:
      position: 101
      prefix: -sorthsps
  - id: dust
    type:
      - 'null'
      - string
    doc: Filter query sequence with DUST
    inputBinding:
      position: 101
      prefix: -dust
  - id: filtering_db
    type:
      - 'null'
      - string
    doc: BLAST database containing filtering elements
    inputBinding:
      position: 101
      prefix: -filtering_db
  - id: window_masker_taxid
    type:
      - 'null'
      - int
    doc: Enable WindowMasker filtering using a Taxonomic ID
    inputBinding:
      position: 101
      prefix: -window_masker_taxid
  - id: window_masker_db
    type:
      - 'null'
      - string
    doc: Enable WindowMasker filtering using this repeats database
    inputBinding:
      position: 101
      prefix: -window_masker_db
  - id: soft_masking
    type:
      - 'null'
      - boolean
    doc: Apply filtering locations as soft masks
    inputBinding:
      position: 101
      prefix: -soft_masking
  - id: lcase_masking
    type:
      - 'null'
      - boolean
    doc: Use lower case filtering in query and subject sequence(s)?
    inputBinding:
      position: 101
      prefix: -lcase_masking
  - id: gilist
    type:
      - 'null'
      - string
    doc: Restrict search of database to list of GIs
    inputBinding:
      position: 101
      prefix: -gilist
  - id: seqidlist
    type:
      - 'null'
      - string
    doc: Restrict search of database to list of SeqIDs
    inputBinding:
      position: 101
      prefix: -seqidlist
  - id: taxids
    type:
      - 'null'
      - string
    doc: Restrict search of database to include only the specified taxonomy IDs
    inputBinding:
      position: 101
      prefix: -taxids
  - id: no_taxid_expansion
    type:
      - 'null'
      - boolean
    doc: Do not expand the taxonomy IDs provided to their descendant taxonomy 
      IDs
    inputBinding:
      position: 101
      prefix: -no_taxid_expansion
  - id: perc_identity
    type:
      - 'null'
      - float
    doc: Percent identity
    inputBinding:
      position: 101
      prefix: -perc_identity
  - id: qcov_hsp_perc
    type:
      - 'null'
      - float
    doc: Percent query coverage per hsp
    inputBinding:
      position: 101
      prefix: -qcov_hsp_perc
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of aligned sequences to keep
    inputBinding:
      position: 101
      prefix: -max_target_seqs
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (CPUs) to use in the BLAST search
    inputBinding:
      position: 101
      prefix: -num_threads
  - id: remote
    type:
      - 'null'
      - boolean
    doc: Execute search remotely?
    inputBinding:
      position: 101
      prefix: -remote
  - id: import_search_strategy
    type:
      - 'null'
      - File
    doc: Search strategy to use
    inputBinding:
      position: 101
      prefix: -import_search_strategy
  - id: export_search_strategy
    type: string
    doc: File name to record the search strategy used
    inputBinding:
      position: 101
      prefix: -export_search_strategy
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out)
  - id: output_export_search_strategy
    type:
      - 'null'
      - File
    doc: File name to record the search strategy used
    outputBinding:
      glob: $(inputs.export_search_strategy)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0
s:url: https://blast.ncbi.nlm.nih.gov/doc/blast-help/
$namespaces:
  s: https://schema.org/
