cwlVersion: v1.2
class: CommandLineTool
baseCommand: genewise
label: wise2_genewise
doc: "genewise <protein-file> <dna-file> in fasta format\n\nTool homepage: https://www.ebi.ac.uk/~birney/wise2/"
inputs:
  - id: protein_file
    type: File
    doc: Protein file
    inputBinding:
      position: 1
  - id: dna_file
    type: File
    doc: DNA file
    inputBinding:
      position: 2
  - id: algorithm
    type:
      - 'null'
      - string
    doc: Algorithm used
    inputBinding:
      position: 103
  - id: alln_prob
    type:
      - 'null'
      - float
    doc: Probability of matching a NNN codon
    inputBinding:
      position: 103
  - id: codon_table
    type:
      - 'null'
      - File
    doc: Codon file
    inputBinding:
      position: 103
  - id: compare_both_strands
    type:
      - 'null'
      - boolean
    doc: Both strands
    inputBinding:
      position: 103
      prefix: -both
  - id: compare_forward_strand
    type:
      - 'null'
      - boolean
    doc: Compare on the forward strand
    inputBinding:
      position: 103
      prefix: -tfor
  - id: compare_reverse_strand
    type:
      - 'null'
      - boolean
    doc: Compare on the reverse strand
    inputBinding:
      position: 103
      prefix: -trev
  - id: comparison_matrix
    type:
      - 'null'
      - string
    doc: Comparison matrix
    inputBinding:
      position: 103
      prefix: -matrix
  - id: dna_end_pos
    type:
      - 'null'
      - string
    doc: end position in dna
    inputBinding:
      position: 103
      prefix: -v
  - id: dna_start_pos
    type:
      - 'null'
      - string
    doc: start position in dna
    inputBinding:
      position: 103
      prefix: -u
  - id: dycache
    type:
      - 'null'
      - boolean
    doc: implicitly cache dy matrix usage
    inputBinding:
      position: 103
  - id: dydebug
    type:
      - 'null'
      - boolean
    doc: drop into dynamite dp matrix debugger
    inputBinding:
      position: 103
  - id: dynamic_memory_kbytes
    type:
      - 'null'
      - int
    doc: memory amount to use
    inputBinding:
      position: 103
      prefix: -kbyte
  - id: dynamic_memory_style
    type:
      - 'null'
      - string
    doc: memory style
    inputBinding:
      position: 103
      prefix: -dymem
  - id: error_reporting_style
    type:
      - 'null'
      - string
    doc: style of error reporting
    inputBinding:
      position: 103
      prefix: -errorstyle
  - id: errorlog_file
    type:
      - 'null'
      - File
    doc: Log warning messages to file
    inputBinding:
      position: 103
      prefix: -errorlog
  - id: erroroffstd
    type:
      - 'null'
      - boolean
    doc: No warning messages to stderr
    inputBinding:
      position: 103
      prefix: -erroroffstd
  - id: extension_penalty
    type:
      - 'null'
      - int
    doc: extension penalty
    inputBinding:
      position: 103
      prefix: -ext
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: gap penalty
    inputBinding:
      position: 103
      prefix: -gap
  - id: genestats_file
    type:
      - 'null'
      - File
    doc: gene statistics file
    inputBinding:
      position: 103
  - id: gw_edge_query_expand
    type:
      - 'null'
      - int
    doc: at start/end, amount of protein area to expand
    inputBinding:
      position: 103
  - id: gw_edge_target_expand
    type:
      - 'null'
      - int
    doc: at start/end, amount of DNA area to expand
    inputBinding:
      position: 103
  - id: gw_splicesite_spread
    type:
      - 'null'
      - int
    doc: spread around splice sites in codons
    inputBinding:
      position: 103
  - id: gwdebug
    type:
      - 'null'
      - boolean
    doc: print out debugging of heuristics on stdout
    inputBinding:
      position: 103
  - id: init_policy
    type:
      - 'null'
      - string
    doc: startend policy for the HMM/protein
    inputBinding:
      position: 103
  - id: insert_model
    type:
      - 'null'
      - string
    doc: Use protein insert model
    inputBinding:
      position: 103
  - id: insertion_deletion_error_rate
    type:
      - 'null'
      - float
    doc: Insertion/deletion error rate
    inputBinding:
      position: 103
  - id: is_embl_file
    type:
      - 'null'
      - boolean
    doc: File is an EMBL file native format
    inputBinding:
      position: 103
      prefix: -fembl
  - id: is_hmmer_file
    type:
      - 'null'
      - boolean
    doc: Protein file is HMMer file (version 2 compatible)
    inputBinding:
      position: 103
      prefix: -hmmer
  - id: mark_pseudogenes
    type:
      - 'null'
      - boolean
    doc: Mark genes with frameshifts as pseudogenes
    inputBinding:
      position: 103
      prefix: -pseudo
  - id: multiple_output_divide_string
    type:
      - 'null'
      - string
    doc: divide string for multiple outputs
    inputBinding:
      position: 103
      prefix: -divide
  - id: no_dycache
    type:
      - 'null'
      - boolean
    doc: implicitly cache dy matrix usage
    inputBinding:
      position: 103
  - id: no_gwhsp
    type:
      - 'null'
      - boolean
    doc: use heuristics for proteins
    inputBinding:
      position: 103
  - id: no_new_gene
    type:
      - 'null'
      - boolean
    doc: use new gene stats (default), no for reverting to old system
    inputBinding:
      position: 103
  - id: no_splice_gtag
    type:
      - 'null'
      - boolean
    doc: make just gtag splice sites (default is gtag, ie no model)
    inputBinding:
      position: 103
  - id: null_model
    type:
      - 'null'
      - string
    doc: Random Model as synchronous or flat
    inputBinding:
      position: 103
  - id: paldebug
    type:
      - 'null'
      - boolean
    doc: print PackAln after debugger run if used
    inputBinding:
      position: 103
  - id: phase_help
    type:
      - 'null'
      - boolean
    doc: prints longer help on phase file and exits
    inputBinding:
      position: 103
  - id: phase_intron_file
    type:
      - 'null'
      - File
    doc: Intron positions and phases
    inputBinding:
      position: 103
  - id: phase_marked_intron_prob
    type:
      - 'null'
      - float
    doc: Probability of marked introns
    inputBinding:
      position: 103
  - id: phase_unmarked_intron_prob
    type:
      - 'null'
      - float
    doc: Probability of unmarked introns
    inputBinding:
      position: 103
  - id: pretty_output
    type:
      - 'null'
      - boolean
    doc: show pretty ascii output
    inputBinding:
      position: 103
      prefix: -pretty
  - id: pretty_output_block_length
    type:
      - 'null'
      - int
    doc: Length of main block in pretty output
    inputBinding:
      position: 103
      prefix: -block
  - id: protein_end_pos
    type:
      - 'null'
      - string
    doc: end position in protein
    inputBinding:
      position: 103
      prefix: -t
  - id: protein_start_pos
    type:
      - 'null'
      - string
    doc: start position in protein
    inputBinding:
      position: 103
      prefix: -s
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No report/info on stderr
    inputBinding:
      position: 103
      prefix: -quiet
  - id: report_abs_truncated_reverse
    type:
      - 'null'
      - boolean
    doc: Report positions as absolute to truncated/reverse sequence
    inputBinding:
      position: 103
      prefix: -tabs
  - id: show_ace_gene_structure
    type:
      - 'null'
      - boolean
    doc: ace file gene structure
    inputBinding:
      position: 103
      prefix: -ace
  - id: show_cdna
    type:
      - 'null'
      - boolean
    doc: show cDNA
    inputBinding:
      position: 103
      prefix: -cdna
  - id: show_embl_feature_cds
    type:
      - 'null'
      - boolean
    doc: show EMBL feature format with CDS key
    inputBinding:
      position: 103
      prefix: -embl
  - id: show_embl_feature_diana
    type:
      - 'null'
      - boolean
    doc: show EMBL feature format with misc_feature key (for diana)
    inputBinding:
      position: 103
      prefix: -diana
  - id: show_gene_structure
    type:
      - 'null'
      - boolean
    doc: show gene structure
    inputBinding:
      position: 103
      prefix: -genes
  - id: show_gene_structure_with_evidence
    type:
      - 'null'
      - boolean
    doc: show gene structure with supporting evidence
    inputBinding:
      position: 103
      prefix: -genesf
  - id: show_gff
    type:
      - 'null'
      - boolean
    doc: Gene Feature Format file
    inputBinding:
      position: 103
      prefix: -gff
  - id: show_logical_alnblock_alignment
    type:
      - 'null'
      - boolean
    doc: show logical AlnBlock alignment
    inputBinding:
      position: 103
      prefix: -alb
  - id: show_parameters
    type:
      - 'null'
      - boolean
    doc: show parameters
    inputBinding:
      position: 103
      prefix: -para
  - id: show_raw_gene_structure
    type:
      - 'null'
      - boolean
    doc: raw gene structure
    inputBinding:
      position: 103
      prefix: -gener
  - id: show_raw_matrix_alignment
    type:
      - 'null'
      - boolean
    doc: show raw matrix alignment
    inputBinding:
      position: 103
      prefix: -pal
  - id: show_summary
    type:
      - 'null'
      - boolean
    doc: show summary output
    inputBinding:
      position: 103
      prefix: -sum
  - id: show_translation_breaking_frameshifts
    type:
      - 'null'
      - boolean
    doc: show protein translation, breaking at frameshifts
    inputBinding:
      position: 103
      prefix: -trans
  - id: show_translation_splicing_frameshifts
    type:
      - 'null'
      - boolean
    doc: show protein translation, splicing frameshifts
    inputBinding:
      position: 103
      prefix: -pep
  - id: silent
    type:
      - 'null'
      - boolean
    doc: No messages on stderr
    inputBinding:
      position: 103
      prefix: -silent
  - id: splice_gtag
    type:
      - 'null'
      - boolean
    doc: make just gtag splice sites (default is gtag, ie no model)
    inputBinding:
      position: 103
  - id: splice_gtag_prob
    type:
      - 'null'
      - float
    doc: probability for gt/ag
    inputBinding:
      position: 103
  - id: splice_max_collar
    type:
      - 'null'
      - float
    doc: maximum Bits value for a splice site
    inputBinding:
      position: 103
  - id: splice_min_collar
    type:
      - 'null'
      - float
    doc: minimum Bits value for a splice site
    inputBinding:
      position: 103
  - id: splice_score_offset
    type:
      - 'null'
      - float
    doc: score offset for splice sites
    inputBinding:
      position: 103
  - id: splice_type
    type:
      - 'null'
      - string
    doc: splice type (model/flat) [LEGACY only for -splice flat. use 
      -splice_gtag]
    inputBinding:
      position: 103
  - id: substitution_error_rate
    type:
      - 'null'
      - float
    doc: Substitution error rate
    inputBinding:
      position: 103
  - id: use_hmmer_filename_as_name
    type:
      - 'null'
      - boolean
    doc: Use this as the name of the HMM, not filename
    inputBinding:
      position: 103
      prefix: -hname
  - id: use_new_gene_stats
    type:
      - 'null'
      - boolean
    doc: use new gene stats (default), no for reverting to old system
    inputBinding:
      position: 103
  - id: use_protein_heuristics
    type:
      - 'null'
      - boolean
    doc: use heuristics for proteins
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
stdout: wise2_genewise.out
