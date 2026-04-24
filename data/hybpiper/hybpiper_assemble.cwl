cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybpiper assemble
label: hybpiper_assemble
doc: "HybPiper is a pipeline for assembling target-capture data.\n\nTool homepage:
  https://github.com/mossmatters/HybPiper"
inputs:
  - id: bbmap_memory
    type:
      - 'null'
      - int
    doc: 'MB memory (RAM) to use for bbmap.sh if a chimera check is performed during
      step extract_contigs. Default: is 1000.'
    inputBinding:
      position: 101
      prefix: --bbmap_memory
  - id: bbmap_subfilter
    type:
      - 'null'
      - int
    doc: 'Ban alignments with more than this many substitutions. Default is: 7.'
    inputBinding:
      position: 101
      prefix: --bbmap_subfilter
  - id: bbmap_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for BBmap when searching for chimeric stitched
      contig. Default is: 1.'
    inputBinding:
      position: 101
      prefix: --bbmap_threads
  - id: bwa
    type:
      - 'null'
      - boolean
    doc: 'Use BWA to map reads to targets. Requires BWA and a target file that is
      nucleotides! Default is: False'
    inputBinding:
      position: 101
      prefix: --bwa
  - id: chimeric_stitched_contig_check
    type:
      - 'null'
      - boolean
    doc: 'Attempt to determine whether a stitched contig is a potential chimera of
      contigs from multiple paralogs. Default is: False.'
    inputBinding:
      position: 101
      prefix: --chimeric_stitched_contig_check
  - id: chimeric_stitched_contig_discordant_reads_cutoff
    type:
      - 'null'
      - int
    doc: Minimum number of discordant reads pairs required to flag a stitched 
      contig as a potential chimera of contigs from multiple paralogs. Default 
      is 5.
    inputBinding:
      position: 101
      prefix: --chimeric_stitched_contig_discordant_reads_cutoff
  - id: chimeric_stitched_contig_edit_distance
    type:
      - 'null'
      - int
    doc: 'Minimum number of differences between one read of a read pair vs the stitched
      contig reference for a read pair to be flagged as discordant. Default is: 5.'
    inputBinding:
      position: 101
      prefix: --chimeric_stitched_contig_edit_distance
  - id: compress_sample_folder
    type:
      - 'null'
      - boolean
    doc: 'Tarball and compress the sample folder after assembly has completed (<sample_name>.tar.gz).
      Default is: False.'
    inputBinding:
      position: 101
      prefix: --compress_sample_folder
  - id: cov_cutoff
    type:
      - 'null'
      - int
    doc: 'Coverage cutoff for SPAdes. Default is: 8'
    inputBinding:
      position: 101
      prefix: --cov_cutoff
  - id: cpu
    type:
      - 'null'
      - int
    doc: Limit the number of CPUs. Default is to use all cores available minus 
      one.
    inputBinding:
      position: 101
      prefix: --cpu
  - id: depth_multiplier
    type:
      - 'null'
      - int
    doc: 'Assign a long paralog as the "main" sequence if it has a coverage depth
      <depth_multiplier> times all other long paralogs. Set to zero to not use depth.
      Default is: 10'
    inputBinding:
      position: 101
      prefix: --depth_multiplier
  - id: diamond
    type:
      - 'null'
      - boolean
    doc: 'Use DIAMOND instead of BLASTx for read mapping. Default is: False'
    inputBinding:
      position: 101
      prefix: --diamond
  - id: diamond_sensitivity
    type:
      - 'null'
      - string
    doc: Use the provided sensitivity for DIAMOND read-mapping searches.
    inputBinding:
      position: 101
      prefix: --diamond_sensitivity
  - id: distribute_low_mem
    type:
      - 'null'
      - boolean
    doc: 'Distributing and writing reads to individual gene directories will be 40-50
      percent slower, but can use less memory/RAM with large input files (see wiki).
      Default is: False'
    inputBinding:
      position: 101
      prefix: --distribute_low_mem
  - id: end_with
    type:
      - 'null'
      - string
    doc: 'End the pipeline at the given step. Default is: extract_contigs'
    inputBinding:
      position: 101
      prefix: --end_with
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'e-value threshold for mapping blastx hits. Default is: 0.0001'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: exclude
    type:
      - 'null'
      - string
    doc: Do not use any sequence with the specified taxon name string in 
      Exonerate/BLASTn searches. Sequences from this taxon will still be used 
      for read sorting.
    inputBinding:
      position: 101
      prefix: --exclude
  - id: exonerate_refine_full
    type:
      - 'null'
      - boolean
    doc: 'Run Exonerate searches using the parameter "--refine full". Default is:
      False.'
    inputBinding:
      position: 101
      prefix: --exonerate_refine_full
  - id: exonerate_skip_hits_with_frameshifts
    type:
      - 'null'
      - boolean
    doc: 'Skip Exonerate hits where the SPAdes sequence contains a frameshift. See:
      https://github.com/mossmatters/HybPiper/wiki/Troubleshooting-common-issues,-and-recommendations#42-hits-where-the-spades-contig-contains-frameshifts.
      Default is: False.'
    inputBinding:
      position: 101
      prefix: --exonerate_skip_hits_with_frameshifts
  - id: exonerate_skip_hits_with_internal_stop_codons
    type:
      - 'null'
      - boolean
    doc: 'Skip Exonerate hits where the SPAdes sequence contains an internal in-frame
      stop codon. See: https://github.com/mossmatters/HybPiper/wiki/Troubleshooting,-common-issues,-and-recommendations#31-sequences-containing-stop-codons.
      A single terminal stop codon is allowed, but see option "--exonerate_skip_hits_with_terminal_stop_codons"
      below. Default is: False.'
    inputBinding:
      position: 101
      prefix: --exonerate_skip_hits_with_internal_stop_codons
  - id: exonerate_skip_hits_with_terminal_stop_codons
    type:
      - 'null'
      - boolean
    doc: 'Skip Exonerate hits where the SPAdes sequence contains a single terminal
      stop codon. Only applies when option "--exonerate_skip_hits_with_internal_stop_codons"
      is also provided. Only use this flag if your target file exclusively contains
      protein-coding genes with no stop codons included, and you would like to prevent
      any in-frame stop codons in the output sequences. Default is: False.'
    inputBinding:
      position: 101
      prefix: --exonerate_skip_hits_with_terminal_stop_codons
  - id: extract_contigs_blast_evalue
    type:
      - 'null'
      - float
    doc: 'Expectation value (E) threshold for saving hits. Default is: 10'
    inputBinding:
      position: 101
      prefix: --extract_contigs_blast_evalue
  - id: extract_contigs_blast_gapextend
    type:
      - 'null'
      - int
    doc: Cost to extend a gap.
    inputBinding:
      position: 101
      prefix: --extract_contigs_blast_gapextend
  - id: extract_contigs_blast_gapopen
    type:
      - 'null'
      - int
    doc: Cost to open a gap.
    inputBinding:
      position: 101
      prefix: --extract_contigs_blast_gapopen
  - id: extract_contigs_blast_max_target_seqs
    type:
      - 'null'
      - int
    doc: 'Maximum number of aligned sequences to keep (value of 5 or more is recommended).
      Default is: 500'
    inputBinding:
      position: 101
      prefix: --extract_contigs_blast_max_target_seqs
  - id: extract_contigs_blast_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a nucleotide mismatch.
    inputBinding:
      position: 101
      prefix: --extract_contigs_blast_penalty
  - id: extract_contigs_blast_perc_identity
    type:
      - 'null'
      - int
    doc: Percent identity. Can be used as a pre-filter at the BLASTn stage, 
      followed by --thresh (see below).
    inputBinding:
      position: 101
      prefix: --extract_contigs_blast_perc_identity
  - id: extract_contigs_blast_reward
    type:
      - 'null'
      - int
    doc: Reward for a nucleotide match.
    inputBinding:
      position: 101
      prefix: --extract_contigs_blast_reward
  - id: extract_contigs_blast_task
    type:
      - 'null'
      - string
    doc: 'Task to use for BLASTn searches during the extract_contigs step of the assembly
      pipeline. See https://www.ncbi.nlm.nih.gov/books/NBK569839/ for a description
      of tasks. Default is: blastn'
    inputBinding:
      position: 101
      prefix: --extract_contigs_blast_task
  - id: extract_contigs_blast_word_size
    type:
      - 'null'
      - int
    doc: Word size for wordfinder algorithm (length of best perfect match).
    inputBinding:
      position: 101
      prefix: --extract_contigs_blast_word_size
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: 'Overwrite any output from a previous run for pipeline steps >= --start_from
      and <= --end_with. Default is: False'
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: hybpiper_output
    type:
      - 'null'
      - Directory
    doc: Folder for HybPiper output. Default is None.
    inputBinding:
      position: 101
      prefix: --hybpiper_output
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: 'Keep all intermediate files and logs, which can be useful for debugging.
      Default action is to delete them, which greatly reduces the total file number.
      Default is: False.'
    inputBinding:
      position: 101
      prefix: --keep_intermediate_files
  - id: kvals
    type:
      - 'null'
      - type: array
        items: int
    doc: Values of k for SPAdes assemblies. SPAdes needs to be compiled to 
      handle larger k-values! Default is auto-detection by SPAdes.
    inputBinding:
      position: 101
      prefix: --kvals
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: 'Max target seqs to save in BLASTx search. Default is: 10'
    inputBinding:
      position: 101
      prefix: --max_target_seqs
  - id: merged
    type:
      - 'null'
      - boolean
    doc: 'For assembly with both merged and unmerged (interleaved) reads. Default
      is: False.'
    inputBinding:
      position: 101
      prefix: --merged
  - id: no_intronerate
    type:
      - 'null'
      - boolean
    doc: 'Do not run intronerate to recover fasta files for supercontigs with introns
      (if present), and introns-only. Default is: False.'
    inputBinding:
      position: 101
      prefix: --no_intronerate
  - id: no_pad_stitched_contig_gaps_with_n
    type:
      - 'null'
      - boolean
    doc: 'When constructing stitched contigs, do not pad any gaps between hits (with
      respect to the "best" protein reference) with a number of Ns corresponding to
      the reference gap multiplied by 3 (Exonerate) or reference gap (BLASTn). Default
      is: True.'
    inputBinding:
      position: 101
      prefix: --no_pad_stitched_contig_gaps_with_n
  - id: no_padding_supercontigs
    type:
      - 'null'
      - boolean
    doc: 'If Intronerate is run, and a supercontig is created by concatenating multiple
      SPAdes contigs, do not add 10 "N" characters between contig joins. By default,
      Ns will be added. Default is: False.'
    inputBinding:
      position: 101
      prefix: --no_padding_supercontigs
  - id: no_spades_eta
    type:
      - 'null'
      - boolean
    doc: 'When SPAdes is run concurrently using GNU parallel, the "--eta" flag can
      result in many "sh: /dev/tty: Device not configured" errors written to stderr.
      Using this option removes the "--eta" flag to GNU parallel. Default is False.'
    inputBinding:
      position: 101
      prefix: --no_spades_eta
  - id: no_stitched_contig
    type:
      - 'null'
      - boolean
    doc: 'Do not create any stitched contigs. The longest single Exonerate/BLASTn
      hit will be used. Default is: False.'
    inputBinding:
      position: 101
      prefix: --no_stitched_contig
  - id: not_protein_coding
    type:
      - 'null'
      - boolean
    doc: 'If provided, extract sequences from SPAdes contigs using BLASTn rather than
      Exonerate (step: extract_contigs)'
    inputBinding:
      position: 101
      prefix: --not_protein_coding
  - id: paralog_min_length_percentage
    type:
      - 'null'
      - float
    doc: 'Minimum length percentage of a contig Exonerate hit vs reference protein
      length for a paralog warning and sequence to be generated. Default is: 0.75'
    inputBinding:
      position: 101
      prefix: --paralog_min_length_percentage
  - id: prefix
    type:
      - 'null'
      - string
    doc: Directory name for pipeline output, default is to use the FASTQ file 
      name.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: readfiles
    type:
      type: array
      items: File
    doc: One or more read files to start the pipeline. If exactly two are 
      specified, HybPiper will assume it is paired Illumina reads.
    inputBinding:
      position: 101
      prefix: --readfiles
  - id: run_profiler
    type:
      - 'null'
      - boolean
    doc: 'If supplied, run the subcommand using cProfile. Saves a *.csv file of results.
      Default is: False.'
    inputBinding:
      position: 101
      prefix: --run_profiler
  - id: single_cell_assembly
    type:
      - 'null'
      - boolean
    doc: 'Run SPAdes assemblies in MDA (single-cell) mode. Default is: False'
    inputBinding:
      position: 101
      prefix: --single_cell_assembly
  - id: skip_targetfile_checks
    type:
      - 'null'
      - boolean
    doc: 'Skip the target file checks. Can be used if you are confident that your
      target file has no issues (e.g. if you have previously run "hybpiper check_targetfile".
      Default is: False'
    inputBinding:
      position: 101
      prefix: --skip_targetfile_checks
  - id: start_from
    type:
      - 'null'
      - string
    doc: 'Start the pipeline from the given step. Note that this relies on the presence
      of output files for previous steps, produced by a previous run attempt. Default
      is: map_reads'
    inputBinding:
      position: 101
      prefix: --start_from
  - id: target
    type:
      - 'null'
      - string
    doc: Use the target file sequence with this taxon name in Exonerate/BLASTn 
      searches for each gene. Other targets for that gene will be used only for 
      read sorting. Can be a tab-delimited file (one <gene>\t<taxon_name> per 
      line) or a single taxon name.
    inputBinding:
      position: 101
      prefix: --target
  - id: targetfile_aa
    type: File
    doc: 'FASTA file containing amino-acid target sequences for each gene. The fasta
      headers must follow the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 101
      prefix: --targetfile_aa
  - id: targetfile_dna
    type: File
    doc: 'FASTA file containing DNA target sequences for each gene. The fasta headers
      must follow the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 101
      prefix: --targetfile_dna
  - id: thresh
    type:
      - 'null'
      - int
    doc: Percent identity threshold for retaining Exonerate/BLASTn hits. Default
      is 55, but increase this if you are worried about contaminant sequences. 
      Exonerate hit identity is calculated using amino-acids, BLASTn hit 
      identity is calculated using nucleotides.
    inputBinding:
      position: 101
      prefix: --thresh
  - id: timeout_assemble_reads
    type:
      - 'null'
      - int
    doc: Kill long-running gene assemblies if they take longer than X percent of
      average.
    inputBinding:
      position: 101
      prefix: --timeout_assemble_reads
  - id: timeout_extract_contigs
    type:
      - 'null'
      - int
    doc: 'Kill long-running processes if they take longer than X seconds. Default
      is: 120'
    inputBinding:
      position: 101
      prefix: --timeout_extract_contigs
  - id: trim_hit_sliding_window_size
    type:
      - 'null'
      - int
    doc: 'Size of the sliding window (amino acids for Exonerate, nucleotides for BLASTn)
      when trimming hit termini. Default is: 5 (Exonerate) or 15 (BLASTn).'
    inputBinding:
      position: 101
      prefix: --trim_hit_sliding_window_size
  - id: trim_hit_sliding_window_thresh
    type:
      - 'null'
      - int
    doc: 'Percentage similarity threshold for the sliding window (amino acids for
      Exonerate, nucleotides for BLASTn) when trimming hit termini. Default is: 75
      (Exonerate) or 65 (BLASTn).'
    inputBinding:
      position: 101
      prefix: --trim_hit_sliding_window_thresh
  - id: unpaired
    type:
      - 'null'
      - File
    doc: Include a single FASTQ file with unpaired reads along with two paired 
      read files
    inputBinding:
      position: 101
      prefix: --unpaired
  - id: verbose_logging
    type:
      - 'null'
      - boolean
    doc: 'If supplied, enable verbose logging. NOTE: this can increase the size of
      the log files by an order of magnitude. Default is: False.'
    inputBinding:
      position: 101
      prefix: --verbose_logging
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_assemble.out
