cwlVersion: v1.2
class: CommandLineTool
baseCommand: spaln
label: spaln
doc: "SPALN is a tool for aligning sequences, particularly for gene prediction and
  mapping.\n\nTool homepage: http://www.genome.ist.i.kyoto-u.ac.jp/~aln_user/spaln/"
inputs:
  - id: aadb_faa
    type:
      - 'null'
      - File
    doc: AAdb FAA file (for writing block info)
    inputBinding:
      position: 1
  - id: genome_mfa
    type:
      - 'null'
      - File
    doc: Genome MFA file (for writing block info)
    inputBinding:
      position: 2
  - id: genomic_segment
    type:
      - 'null'
      - string
    doc: Genomic segment (for alignment)
    inputBinding:
      position: 3
  - id: cDNA_fa
    type:
      - 'null'
      - File
    doc: cDNA FASTA file (for alignment)
    inputBinding:
      position: 4
  - id: protein_fa
    type:
      - 'null'
      - File
    doc: Protein FASTA file (for alignment)
    inputBinding:
      position: 5
  - id: region
    type:
      - 'null'
      - string
    doc: Region to extract (e.g., 'chr1.fa 10001 40000')
    inputBinding:
      position: 6
  - id: aadb_bka
    type:
      - 'null'
      - File
    doc: AAdb block information file (for writing AA db info)
    inputBinding:
      position: 107
      prefix: -W
  - id: aadb_db
    type:
      - 'null'
      - string
    doc: Specify AAdb database (must run makeidx.pl -ia beforehand)
    inputBinding:
      position: 107
      prefix: -a
  - id: aadb_db_tag
    type:
      - 'null'
      - string
    doc: Specify AAdb database tag
    inputBinding:
      position: 107
      prefix: -a
  - id: aadb_memory
    type:
      - 'null'
      - string
    doc: Same as -a but db sequences are stored in memory
    inputBinding:
      position: 107
      prefix: -A
  - id: abundance_factor
    type:
      - 'null'
      - float
    doc: Abundance factor
    default: 10
    inputBinding:
      position: 107
      prefix: -Xa
  - id: alignment_mode
    type:
      - 'null'
      - string
    doc: Semi-global or local alignment
    inputBinding:
      position: 107
      prefix: -L
  - id: alignment_mode_ls
    type:
      - 'null'
      - boolean
    doc: Semi-global alignment
    inputBinding:
      position: 107
      prefix: -LS
  - id: block_info_file
    type:
      - 'null'
      - File
    doc: Read block information file *.bkn, *.bkp or *.bka
    inputBinding:
      position: 107
      prefix: -R
  - id: block_size
    type:
      - 'null'
      - int
    doc: Block size (inferred from genome|db size)
    inputBinding:
      position: 107
      prefix: -Xb
  - id: branch_point_signal_weight
    type:
      - 'null'
      - int
    doc: Weight for branch point signal
    default: 0
    inputBinding:
      position: 107
      prefix: -yB
  - id: chars_per_line
    type:
      - 'null'
      - int
    doc: Number of characters per line in alignment
    default: 60
    inputBinding:
      position: 107
      prefix: -l
  - id: coding_potential_weight
    type:
      - 'null'
      - int
    doc: Weight for coding potential
    default: 2
    inputBinding:
      position: 107
      prefix: -yz
  - id: double_affine_gap_penalty
    type:
      - 'null'
      - boolean
    doc: Double affine gap penalty
    inputBinding:
      position: 107
      prefix: -yl3
  - id: dp_band_width
    type:
      - 'null'
      - int
    doc: Band width for DP matrix scan
    default: 100
    inputBinding:
      position: 107
      prefix: -w
  - id: exclude_termination_codon
    type:
      - 'null'
      - boolean
    doc: Exclude termination codon from CDS
    inputBinding:
      position: 107
      prefix: -pT
  - id: frame_shift_error_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a frame shift error
    default: 100
    inputBinding:
      position: 107
      prefix: -yx
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: Gap-extension penalty
    default: 3
    inputBinding:
      position: 107
      prefix: -u
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: Gap-open penalty
    default: 8
    inputBinding:
      position: 107
      prefix: -v
  - id: genome_bkn
    type:
      - 'null'
      - File
    doc: Genome block information file (for writing block info)
    inputBinding:
      position: 107
      prefix: -W
  - id: genome_bkp
    type:
      - 'null'
      - File
    doc: Genome block information file (for writing block info)
    inputBinding:
      position: 107
      prefix: -W
  - id: genome_db
    type:
      - 'null'
      - string
    doc: Specify genome database (must run makeidx.pl -i[n|p] beforehand)
    inputBinding:
      position: 107
      prefix: -d
  - id: genome_db_tag
    type:
      - 'null'
      - string
    doc: Specify genome database tag
    inputBinding:
      position: 107
      prefix: -d
  - id: genome_memory
    type:
      - 'null'
      - string
    doc: Same as -d but db sequences are stored in memory
    inputBinding:
      position: 107
      prefix: -D
  - id: genome_mfa_or_aadb_faa
    type:
      - 'null'
      - File
    doc: Genome MFA or AAdb FAA file (alternative to makdbs)
    inputBinding:
      position: 107
      prefix: -W
  - id: gzipped_output
    type:
      - 'null'
      - boolean
    doc: Gzipped output
    inputBinding:
      position: 107
      prefix: -g
  - id: gzipped_output_o12
    type:
      - 'null'
      - boolean
    doc: Gzipped output in combination with -O12
    inputBinding:
      position: 107
      prefix: -g
  - id: hsp_search_mode
    type:
      - 'null'
      - int
    doc: '0:DP; 1-3:HSP-Search; 4-7: Block-Search'
    default: 3
    inputBinding:
      position: 107
      prefix: -Q
  - id: intron_length_distribution
    type:
      - 'null'
      - string
    doc: Intron length distribution
    inputBinding:
      position: 107
      prefix: -yI
  - id: intron_potential_weight
    type:
      - 'null'
      - int
    doc: Weight for intron potential
    default: 0
    inputBinding:
      position: 107
      prefix: -yZ
  - id: max_candidate_loci
    type:
      - 'null'
      - int
    doc: Max number of candidate loci (effective only for map-and-align modes)
    default: 4
    inputBinding:
      position: 107
      prefix: -M
  - id: max_expected_gene_size
    type:
      - 'null'
      - string
    doc: Maximum expected gene size (inferred from genome|db size)
    inputBinding:
      position: 107
      prefix: -XG
  - id: max_intron_length
    type:
      - 'null'
      - string
    doc: Maximum length of intron (unset)
    inputBinding:
      position: 107
      prefix: -yM
  - id: min_expected_intron_length
    type:
      - 'null'
      - int
    doc: Minimum expected length of intron
    default: 30
    inputBinding:
      position: 107
      prefix: -yL
  - id: min_orf_length_kp
    type:
      - 'null'
      - int
    doc: Minimum ORF length with -KP
    default: 30
    inputBinding:
      position: 107
      prefix: -Xr
  - id: min_score_report
    type:
      - 'null'
      - int
    doc: Minimum score for report
    default: 35
    inputBinding:
      position: 107
      prefix: -H
  - id: multi_thread_operation
    type:
      - 'null'
      - int
    doc: 'Multi-thread operation with # threads'
    inputBinding:
      position: 107
      prefix: -t
  - id: no_cross_species_comparison
    type:
      - 'null'
      - boolean
    doc: Don't use parameter set for cross-species comparison
    inputBinding:
      position: 107
      prefix: -yX0
  - id: nucleotide_match_score
    type:
      - 'null'
      - int
    doc: Nucleotide match score
    default: 2
    inputBinding:
      position: 107
      prefix: -ym
  - id: nucleotide_mismatch_score
    type:
      - 'null'
      - int
    doc: Nucleotide mismatch score
    default: -6
    inputBinding:
      position: 107
      prefix: -yn
  - id: num_bit_patterns
    type:
      - 'null'
      - int
    doc: Number of bit patterns
    default: 1
    inputBinding:
      position: 107
      prefix: -XC
  - id: num_outputs_per_query
    type:
      - 'null'
      - string
    doc: Number of outputs per query
    default: '1'
    inputBinding:
      position: 107
      prefix: -M
  - id: orientation
    type:
      - 'null'
      - int
    doc: Orientation. 0:annotation; 1:forward; 2:reverse; 3:both
    default: 3
    inputBinding:
      position: 107
      prefix: -S
  - id: output_formats
    type:
      - 'null'
      - string
    doc: Output formats (Gff3_gene, alignment, Gff3_match, Bed, exon-inf, 
      intron-inf, cDNA, translated, block-only, SAM, binary, query+GS for GvsA; 
      statistics, alignment, Sugar, Psl, XYL, srat+XYL, Cigar, Vulgar, SAM for 
      AvsA)
    default: '4'
    inputBinding:
      position: 107
      prefix: -O
  - id: output_full_fasta_name
    type:
      - 'null'
      - boolean
    doc: Output full Fasta entry name
    inputBinding:
      position: 107
      prefix: -pF
  - id: overwrite_existing_output
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output file
    inputBinding:
      position: 107
      prefix: -po
  - id: premature_termination_codon_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a premature termination codon
    default: 100
    inputBinding:
      position: 107
      prefix: -yo
  - id: remove_poly_a
    type:
      - 'null'
      - int
    doc: "Remove 3' poly A >= # (0: don't remove)"
    default: 0
    inputBinding:
      position: 107
      prefix: -pa
  - id: report_below_threshold
    type:
      - 'null'
      - boolean
    doc: Report results even if the score is below the threshold
    inputBinding:
      position: 107
      prefix: -pw
  - id: report_block_data_info
    type:
      - 'null'
      - File
    doc: Report information about block data file
    inputBinding:
      position: 107
      prefix: -r
  - id: reset_max_expected_gene_size
    type:
      - 'null'
      - string
    doc: Reset maximum expected gene size, suffix k or M is effective
    inputBinding:
      position: 107
      prefix: -XG
  - id: retain_existing_output
    type:
      - 'null'
      - boolean
    doc: Retain existing output file
    inputBinding:
      position: 107
      prefix: -pn
  - id: simd_type
    type:
      - 'null'
      - string
    doc: '0: scalar, 1..3: simd; 1: rigorous, 2: intermediate, 3: fast'
    inputBinding:
      position: 107
      prefix: -A
  - id: species_params_subdir
    type:
      - 'null'
      - Directory
    doc: Subdirectory where species-specific parameters reside
    inputBinding:
      position: 107
      prefix: -T
  - id: species_params_tag
    type:
      - 'null'
      - string
    doc: Species-specific parameter tag
    inputBinding:
      position: 107
      prefix: -TT
  - id: splice_site_signal_weight
    type:
      - 'null'
      - int
    doc: Weight for splice site signal
    default: 8
    inputBinding:
      position: 107
      prefix: -yy
  - id: splice_site_stringency
    type:
      - 'null'
      - int
    doc: Stringency of splice site. 0->3:strong->weak
    inputBinding:
      position: 107
      prefix: -ya
  - id: suppress_splice_junction_info
    type:
      - 'null'
      - boolean
    doc: Suppress splice junction information with -O[6|7]
    inputBinding:
      position: 107
      prefix: -pj
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Multi-thread operation with # threads'
    inputBinding:
      position: 107
      prefix: -t
  - id: use_species_specific_params
    type:
      - 'null'
      - string
    doc: Use species-specific parameter set
    default: 0.0/0.5
    inputBinding:
      position: 107
      prefix: -yS
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size (inferred from genome|db size)
    inputBinding:
      position: 107
      prefix: -Xk
outputs:
  - id: output_file_dir_prefix
    type:
      - 'null'
      - File
    doc: File/directory/prefix where results are written
    outputBinding:
      glob: $(inputs.output_file_dir_prefix)
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output files/directories
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
