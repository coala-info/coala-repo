cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spaln
label: spaln
doc: "Align cDNA or protein sequences to a genomic sequence (spliced alignment), with optional map-and-align against a spaln genome or amino acid database.\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: genomic_segment
    type:
      - 'null'
      - File
    doc: "Genomic sequence in FASTA format to align to (not used with the genome_db or aadb modes)"
    inputBinding:
      position: 200
      valueFrom: '$(inputs.segment_start ? self.path + " " + inputs.segment_start + " " + inputs.segment_end : self.path)'
  - id: segment_start
    type:
      - 'null'
      - int
    doc: "Start position of the genomic segment (with segment_end; 1-based)"
  - id: segment_end
    type:
      - 'null'
      - int
    doc: "End position of the genomic segment"
  - id: query
    type: File
    doc: "cDNA (nucleotide) or protein sequences in FASTA format"
    inputBinding:
      position: 201
  - id: db_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files of the spaln database(s) named by genome_db, genome_db_in_memory, aadb or aadb_in_memory (made by spaln_makdb), staged into the working directory
  - id: simd_mode
    type:
      - 'null'
      - int
    doc: "-A[0-3]: 0: scalar, 1..3: simd; 1: rigorous, 2: intermediate, 3: fast"
    inputBinding:
      position: 10
      prefix: -A
      separate: false
  - id: min_score_report
    type:
      - 'null'
      - int
    doc: "Minimum score for report (35)"
    inputBinding:
      position: 10
      prefix: -H
      separate: false
  - id: local_alignment
    type:
      - 'null'
      - boolean
    doc: "Semi-global or local alignment (-L)"
    inputBinding:
      position: 10
      prefix: -L
      separate: false
  - id: local_alignment_variant
    type:
      - 'null'
      - string
    doc: "-LS or -L#: variant of semi-global or local alignment (value glued to -L, e.g. S)"
    inputBinding:
      position: 10
      prefix: -L
      separate: false
  - id: num_outputs
    type:
      - 'null'
      - string
    doc: "Number of outputs per query (1) (4 if # is omitted); #2 (4) specifies the max number of candidate loci. Effective only for map-and-align modes. Format #[,#2]"
    inputBinding:
      position: 10
      prefix: -M
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format(s), e.g. 0: Gff3_gene; 1: alignment; 2: Gff3_match; 3: Bed; 4: exon-inf; 5: intron-inf; 6: cDNA; 7: translated; 8: block-only; 10: SAM; 12: binary; 15: query+GS (4). Comma-separated list allowed"
    inputBinding:
      position: 10
      prefix: -O
      separate: false
  - id: search_mode
    type:
      - 'null'
      - int
    doc: "0:DP; 1-3:HSP-Search; 4-7; Block-Search (3)"
    inputBinding:
      position: 10
      prefix: -Q
      separate: false
  - id: orientation
    type:
      - 'null'
      - int
    doc: "Orientation. 0:annotation; 1:forward; 2:reverse; 3:both (3)"
    inputBinding:
      position: 10
      prefix: -S
      separate: false
  - id: species_params
    type:
      - 'null'
      - string
    doc: "Subdirectory where species-specific parameters reside"
    inputBinding:
      position: 10
      prefix: -T
      separate: false
  - id: aadb
    type:
      - 'null'
      - string
    doc: "Specify AAdb (name of an amino acid database made with spaln -W -KA)"
    inputBinding:
      position: 10
      prefix: -a
      separate: false
  - id: aadb_in_memory
    type:
      - 'null'
      - string
    doc: "Same as -a but db sequences are stored in memory"
    inputBinding:
      position: 10
      prefix: -A
      separate: false
  - id: genome_db
    type:
      - 'null'
      - string
    doc: "Specify genome (name of a database made with spaln -W -KD or -KP)"
    inputBinding:
      position: 10
      prefix: -d
      separate: false
  - id: genome_db_in_memory
    type:
      - 'null'
      - string
    doc: "Same as -d but db sequences are stored in memory"
    inputBinding:
      position: 10
      prefix: -D
      separate: false
  - id: gzipped_output
    type:
      - 'null'
      - boolean
    doc: "gzipped output in combination with -O12"
    inputBinding:
      position: 10
      prefix: -g
      separate: false
  - id: chars_per_line
    type:
      - 'null'
      - int
    doc: "Number of characters per line in alignment (60)"
    inputBinding:
      position: 10
      prefix: -l
      separate: false
  - id: output
    type:
      - 'null'
      - string
    doc: "File/directory/prefix where results are written (stdout)"
    inputBinding:
      position: 10
      prefix: -o
      separate: false
  - id: remove_polya
    type:
      - 'null'
      - int
    doc: "Remove 3' poly A >= # (0: don't remove)"
    inputBinding:
      position: 10
      prefix: -pa
      separate: false
  - id: output_full_fasta_name
    type:
      - 'null'
      - boolean
    doc: "Output full Fasta entry name"
    inputBinding:
      position: 10
      prefix: -pF
      separate: false
  - id: suppress_splice_junction_info
    type:
      - 'null'
      - boolean
    doc: "Suppress splice junction information with -O[6|7]"
    inputBinding:
      position: 10
      prefix: -pj
      separate: false
  - id: retain_existing_output
    type:
      - 'null'
      - boolean
    doc: "Retain existing output file"
    inputBinding:
      position: 10
      prefix: -pn
      separate: false
  - id: overwrite_existing_output
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing output file"
    inputBinding:
      position: 10
      prefix: -po
      separate: false
  - id: report_below_threshold
    type:
      - 'null'
      - boolean
    doc: "Report results even if the score is below the threshold"
    inputBinding:
      position: 10
      prefix: -pw
      separate: false
  - id: exclude_termination_codon
    type:
      - 'null'
      - boolean
    doc: "Exclude termination codon from CDS"
    inputBinding:
      position: 10
      prefix: -pT
      separate: false
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: "Gap-extension penalty (3)"
    inputBinding:
      position: 10
      prefix: -u
      separate: false
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: "Gap-open penalty (8)"
    inputBinding:
      position: 10
      prefix: -v
      separate: false
  - id: dp_band_width
    type:
      - 'null'
      - int
    doc: "Band width for DP matrix scan (100)"
    inputBinding:
      position: 10
      prefix: -w
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: "Multi-thread operation with # threads"
    inputBinding:
      position: 10
      prefix: -t
      separate: false
  - id: splice_site_stringency
    type:
      - 'null'
      - int
    doc: "Stringency of splice site. 0->3:strong->weak"
    inputBinding:
      position: 10
      prefix: -ya
      separate: false
  - id: double_affine_gap_penalty
    type:
      - 'null'
      - boolean
    doc: "Double affine gap penalty"
    inputBinding:
      position: 10
      prefix: -yl3
      separate: false
  - id: nucleotide_match_score
    type:
      - 'null'
      - int
    doc: "Nucleotide match score (2)"
    inputBinding:
      position: 10
      prefix: -ym
      separate: false
  - id: nucleotide_mismatch_score
    type:
      - 'null'
      - int
    doc: "Nucleotide mismatch score (-6)"
    inputBinding:
      position: 10
      prefix: -yn
      separate: false
  - id: premature_termination_codon_penalty
    type:
      - 'null'
      - int
    doc: "Penalty for a premature termination codon (100)"
    inputBinding:
      position: 10
      prefix: -yo
      separate: false
  - id: frame_shift_penalty
    type:
      - 'null'
      - int
    doc: "Penalty for a frame shift error (100)"
    inputBinding:
      position: 10
      prefix: -yx
      separate: false
  - id: splice_site_signal_weight
    type:
      - 'null'
      - int
    doc: "Weight for splice site signal (8)"
    inputBinding:
      position: 10
      prefix: -yy
      separate: false
  - id: coding_potential_weight
    type:
      - 'null'
      - int
    doc: "Weight for coding potential (2)"
    inputBinding:
      position: 10
      prefix: -yz
      separate: false
  - id: branch_point_signal_weight
    type:
      - 'null'
      - int
    doc: "Weight for branch point signal (0)"
    inputBinding:
      position: 10
      prefix: -yB
      separate: false
  - id: intron_length_distribution
    type:
      - 'null'
      - string
    doc: "Intron length distribution"
    inputBinding:
      position: 10
      prefix: -yI
      separate: false
  - id: min_expected_intron_length
    type:
      - 'null'
      - int
    doc: "Minimum expected length of intron (30)"
    inputBinding:
      position: 10
      prefix: -yL
      separate: false
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: "Maximum length of intron (unset)"
    inputBinding:
      position: 10
      prefix: -yM
      separate: false
  - id: species_specific_params
    type:
      - 'null'
      - string
    doc: "Use species-specific parameter set (0.0/0.5); value optional"
    inputBinding:
      position: 10
      prefix: -yS
      separate: false
  - id: no_cross_species_params
    type:
      - 'null'
      - boolean
    doc: "Don't use parameter set for cross-species comparison"
    inputBinding:
      position: 10
      prefix: -yX0
      separate: false
  - id: intron_potential_weight
    type:
      - 'null'
      - int
    doc: "Weight for intron potential (0)"
    inputBinding:
      position: 10
      prefix: -yZ
      separate: false
  - id: max_expected_gene_size
    type:
      - 'null'
      - string
    doc: "Reset maximum expected gene size, suffix k or M is effective"
    inputBinding:
      position: 10
      prefix: -XG
      separate: false
  - id: block_info_file
    type:
      - 'null'
      - File
    doc: Read block information file *.bkn, *.bkp or *.bka
    inputBinding:
      position: 10
      prefix: -R
      separate: false
  - id: report_block_data_file
    type:
      - 'null'
      - File
    doc: Report information about block data file
    inputBinding:
      position: 10
      prefix: -r
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Alignment output (stdout)
  - id: output_files
    type:
      type: array
      items: File
    doc: Result files written with -o (file, directory content or prefix)
    outputBinding:
      glob: "$(inputs.output ? inputs.output + '*' : '__no_output_option__')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.db_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
stdout: spaln.out
