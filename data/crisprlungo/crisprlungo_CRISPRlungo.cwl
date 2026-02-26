cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRlungo
label: crisprlungo_CRISPRlungo
doc: "Analyzing unidirectional sequencing of genome editing\n\nTool homepage: https://github.com/pinellolab/CRISPRlungo"
inputs:
  - id: settings_file
    type:
      - 'null'
      - string
    doc: Tab-separated settings file
    inputBinding:
      position: 1
  - id: additional_cut_site_file
    type:
      - 'null'
      - File
    doc: File containing additional cut site annotations. This file should have 
      five tab-separated columns. 1) chromosome of the cut site 2) position of 
      the cut site 3) guide alignment orientation with respect to the genome 
      (either "FW" or "RC") 4) guide sequence not including the PAM (this will 
      be used to search for homology and may be left blank) 5) cut annotation 
      (e.g. "Programmed" - this will appear in reports)
    inputBinding:
      position: 102
      prefix: --additional_cut_site_file
  - id: arm_max_clipped_bases
    type:
      - 'null'
      - int
    doc: Maximum number of clipped bases at the beginning of the alignment. 
      Bowtie2 alignment marks reads on the beginning or end of the read as 
      "clipped" if they do not align to the genome. This could arise from 
      CRISPR-induced insertions, or bad alignments. We would expect to see 
      clipped bases only on one side. This parameter sets the threshold for 
      clipped bases on both sides of the read. E.g. if arm_max_clipped_bases is 
      0, read alignments with more than 0bp on the right AND left side of the 
      alignment would be discarded. An alignment with 5bp clipped on the left 
      and 0bp clipped on the right would be accepted. An alignment with 5bp 
      clipped on the left and 3bp clipped on the right would be discarded.
    default: 0
    inputBinding:
      position: 102
      prefix: --arm_max_clipped_bases
  - id: arm_min_matched_start_bases
    type:
      - 'null'
      - int
    doc: Number of bases that are required to be matching (no indels or 
      mismatches) at the beginning of the read on each "side" of the alignment. 
      E.g. if arm_min_matched_start_bases is set to 5, the first and last 5bp of
      the read alignment would have to match exactly to the aligned location.
    default: 10
    inputBinding:
      position: 102
      prefix: --arm_min_matched_start_bases
  - id: bowtie2_command
    type:
      - 'null'
      - string
    doc: Command to run bowtie2
    default: bowtie2
    inputBinding:
      position: 102
      prefix: --bowtie2_command
  - id: bowtie2_genome
    type:
      - 'null'
      - File
    doc: Bowtie2-indexed genome file.
    inputBinding:
      position: 102
      prefix: --bowtie2_genome
  - id: casoffinder_command
    type:
      - 'null'
      - string
    doc: Command to run casoffinder
    default: cas-offinder
    inputBinding:
      position: 102
      prefix: --casoffinder_command
  - id: casoffinder_num_mismatches
    type:
      - 'null'
      - int
    doc: If greater than zero, the number of Cas-OFFinder mismatches for 
      in-silico off-target search. If this value is zero, Cas-OFFinder is not 
      run
    default: 0
    inputBinding:
      position: 102
      prefix: --casoffinder_num_mismatches
  - id: cleavage_offset
    type:
      - 'null'
      - int
    doc: Position where cleavage occurs, for in-silico off- target search 
      (relative to end of spacer seq -- for Cas9 this is -3)
    default: -3
    inputBinding:
      position: 102
      prefix: --cleavage_offset
  - id: crispresso_command
    type:
      - 'null'
      - string
    doc: Command to run crispresso
    default: CRISPResso
    inputBinding:
      position: 102
      prefix: --crispresso_command
  - id: crispresso_max_indel_size
    type:
      - 'null'
      - int
    doc: Maximum length of indel (as determined by genome alignment) for a read 
      to be analyzed by CRISPResso. Reads with indels longer than this length 
      will not be analyzed by CRISPResso, but the indel length will be reported 
      elsewhere.
    default: 50
    inputBinding:
      position: 102
      prefix: --crispresso_max_indel_size
  - id: crispresso_min_aln_score
    type:
      - 'null'
      - int
    doc: Min alignment score to reference sequence for quantification by 
      CRISPResso
    default: 20
    inputBinding:
      position: 102
      prefix: --crispresso_min_aln_score
  - id: crispresso_min_count
    type:
      - 'null'
      - int
    doc: Min number of reads required to be seen at a site for it to be analyzed
      by CRISPResso
    default: 50
    inputBinding:
      position: 102
      prefix: --crispresso_min_count
  - id: crispresso_quant_window_size
    type:
      - 'null'
      - int
    doc: Number of bp on each side of a cut to consider for edits
    default: 1
    inputBinding:
      position: 102
      prefix: --crispresso_quant_window_size
  - id: cut_classification_annotations
    type:
      - 'null'
      - type: array
        items: string
    doc: 'User-customizable annotations for cut products in the form: chr1:234:left:Custom_label
      (multiple annotations are separated by spaces)'
    default: []
    inputBinding:
      position: 102
      prefix: --cut_classification_annotations
  - id: cut_region_annotation_file
    type:
      - 'null'
      - File
    doc: 'Bed file containing regions to annotate cut sites that are not otherwise
      annotated (e.g. fragile sites, etc.). This is a tab-separated file with at least
      4 columns: chr, start, end, and region_name. Cut sites will be labeled with
      the following priority: 1) annotation given by --cut_classification_annotations,
      2) annotations in --additional_cut_site_file 3) presence of homology to any
      guide 4) this region annotation'
    inputBinding:
      position: 102
      prefix: --cut_region_annotation_file
  - id: cutadapt_command
    type:
      - 'null'
      - string
    doc: Command to run cutadapt
    default: cutadapt
    inputBinding:
      position: 102
      prefix: --cutadapt_command
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug output
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: dedup_by_final_cut_assignment_and_UMI
    type:
      - 'null'
      - boolean
    doc: If set, deduplicates based on final cut assignment - so that reads with
      the same UMI with different start/stop alignment positions will be 
      deduplicated if they are assigned to the same final cut position
    default: false
    inputBinding:
      position: 102
      prefix: --dedup_by_final_cut_assignment_and_UMI
  - id: dedup_input_on_umi
    type:
      - 'null'
      - boolean
    doc: If set, input reads will be deduplicated based on UMI before alignment.
      Note that if this flag is set dedupication by alignment position will be 
      redundant (only one read will exist with a UMI after this step). This will
      also affect the values in the column "reads_with_same_umi_pos" in the 
      final_assignments.txt file, which will only show 1 for all reads.
    default: false
    inputBinding:
      position: 102
      prefix: --dedup_input_on_UMI
  - id: fastq_r1
    type:
      - 'null'
      - File
    doc: Input fastq r1 file. Reads in this file are primed from the provided 
      primer sequence
    inputBinding:
      position: 102
      prefix: --fastq_r1
  - id: fastq_r2
    type:
      - 'null'
      - File
    doc: Input fastq r2 file
    inputBinding:
      position: 102
      prefix: --fastq_r2
  - id: fastq_umi
    type:
      - 'null'
      - File
    doc: Input fastq umi file
    inputBinding:
      position: 102
      prefix: --fastq_umi
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome sequence file for alignment. This should point to a file ending 
      in ".fa", and the accompanying index file (".fai") should exist.
    inputBinding:
      position: 102
      prefix: --genome
  - id: guide_sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: Spacer sequences of guides (multiple guide sequences are separated by 
      spaces). Spacer sequences must be provided without the PAM sequence, but 
      oriented so the PAM would immediately follow the provided spacer sequence
    default: []
    inputBinding:
      position: 102
      prefix: --guide_sequences
  - id: ignore_n
    type:
      - 'null'
      - boolean
    doc: If set, "N" bases will be ignored. By default (False) N bases will 
      count as mismatches in the number of bases required to match at each 
      arm/side of the read
    default: false
    inputBinding:
      position: 102
      prefix: --ignore_n
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: If true, intermediate files are not deleted
    default: false
    inputBinding:
      position: 102
      prefix: --keep_intermediate
  - id: known_cut_merge_distance
    type:
      - 'null'
      - int
    doc: Novel cut sites discovered within this distance (bp) with a 
      known/provided/homologous site (that is not the origin) will be merged to 
      that site. Homologous sites are defined as those that have homology to 
      guide_sequences. Novel cut sites farther than known_cut_merge_distance 
      will be merged into novel cut sites based on the parameter 
      novel_cut_merge_distance.
    default: 50
    inputBinding:
      position: 102
      prefix: --known_cut_merge_distance
  - id: min_primer_aln_score
    type:
      - 'null'
      - int
    doc: Minimum primer/origin alignment score for trimming.
    default: 40
    inputBinding:
      position: 102
      prefix: --min_primer_aln_score
  - id: min_primer_length
    type:
      - 'null'
      - int
    doc: Minimum length of sequence required to match between the primer/origin 
      and read sequence
    default: 30
    inputBinding:
      position: 102
      prefix: --min_primer_length
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum length of read after all filtering
    default: 30
    inputBinding:
      position: 102
      prefix: --min_read_length
  - id: min_umi_seen_to_keep_read
    type:
      - 'null'
      - int
    doc: Minimum times a UMI/read combination must be seen in order to keep that
      for downstream analysis. If many PCR cycles are performed in library 
      preparation, UMI/read combinations that are highly amplified may be more 
      trusted than UMI/read combinations that appear in low abundance. However, 
      this probably only applies for sequencing libraries with members with 
      uniform PCR amplification properties.
    default: 0
    inputBinding:
      position: 102
      prefix: --min_umi_seen_to_keep_read
  - id: n_processes
    type:
      - 'null'
      - string
    doc: Number of processes to run on (may be set to "max")
    default: '1'
    inputBinding:
      position: 102
      prefix: --n_processes
  - id: name
    type:
      - 'null'
      - string
    doc: Output directory file root
    inputBinding:
      position: 102
      prefix: --name
  - id: novel_cut_merge_distance
    type:
      - 'null'
      - int
    doc: Novel cut sites discovered within this distance (bp) from each other 
      (and not within known_cut_merge_distance to a known/provided cut site or a
      site with homology to guide_sequences) will be merged into a single cut 
      site. Variation in the cut sites or in the fragments produced may produce 
      clusters of cut sites in a certain region. This parameter will merge novel
      cut sites within this distance into a single cut site.
    default: 50
    inputBinding:
      position: 102
      prefix: --novel_cut_merge_distance
  - id: origin_cut_merge_distance
    type:
      - 'null'
      - int
    doc: Reads aligned within this distance (bp) to the origin site will be 
      merged to that origin.
    default: 10000
    inputBinding:
      position: 102
      prefix: --origin_cut_merge_distance
  - id: pam
    type:
      - 'null'
      - string
    doc: PAM for in-silico off-target search
    inputBinding:
      position: 102
      prefix: --PAM
  - id: primer_in_r2
    type:
      - 'null'
      - boolean
    doc: If true, the primer is in R2. By default, the primer is required to be 
      in R1.
    default: false
    inputBinding:
      position: 102
      prefix: --primer_in_r2
  - id: primer_seq
    type:
      - 'null'
      - string
    doc: Sequence of primer
    inputBinding:
      position: 102
      prefix: --primer_seq
  - id: r1_r2_support_max_distance
    type:
      - 'null'
      - int
    doc: Max distance between r1 and r2 for the read pair to be classified as 
      "supported" by r2
    default: 10000
    inputBinding:
      position: 102
      prefix: --r1_r2_support_max_distance
  - id: root
    type:
      - 'null'
      - string
    doc: Output directory file root
    inputBinding:
      position: 102
      prefix: --root
  - id: run_crispresso_on_novel_sites
    type:
      - 'null'
      - boolean
    doc: If set, CRISPResso analysis will be performed on novel cut sites. If 
      false, CRISPResso analysis will only be performed on user-provided on- and
      off-targets
    default: false
    inputBinding:
      position: 102
      prefix: --run_crispresso_on_novel_sites
  - id: samtools_command
    type:
      - 'null'
      - string
    doc: Command to run samtools
    default: samtools
    inputBinding:
      position: 102
      prefix: --samtools_command
  - id: short_indel_length_cutoff
    type:
      - 'null'
      - int
    doc: For reads aligned to a cut site, indels this size or shorter are 
      classified as "short indels" while indels larger than this size are 
      classified as "long indels"
    default: 50
    inputBinding:
      position: 102
      prefix: --short_indel_length_cutoff
  - id: suppress_dedup_on_aln_pos_and_UMI_filter
    type:
      - 'null'
      - boolean
    doc: If set, reads that are called as deduplicates based on alignment 
      position and UMI will be included in final analysis and counts. By 
      default, these reads are excluded.
    default: false
    inputBinding:
      position: 102
      prefix: --suppress_dedup_on_aln_pos_and_UMI_filter
  - id: suppress_homology_detection
    type:
      - 'null'
      - boolean
    doc: If set, detection of guide sequence homology at cut sites is skipped. 
      By default, novel cut sites are checked for homology, which can be 
      computationally demanding if there are many cut sites.
    default: false
    inputBinding:
      position: 102
      prefix: --suppress_homology_detection
  - id: suppress_plots
    type:
      - 'null'
      - boolean
    doc: If true, no plotting will be performed
    default: false
    inputBinding:
      position: 102
      prefix: --suppress_plots
  - id: suppress_poor_alignment_filter
    type:
      - 'null'
      - boolean
    doc: If set, reads with poor alignment (fewer than 
      --arm_min_matched_start_bases matches at the alignment ends or more than 
      --arm_max_clipped_bases on both sides of the read) are included in final 
      analysis and counts. By default they are excluded.
    default: false
    inputBinding:
      position: 102
      prefix: --suppress_poor_alignment_filter
  - id: suppress_r2_support_filter
    type:
      - 'null'
      - boolean
    doc: If set, reads without r2 support will be included in final analysis and
      counts. By default these reads are excluded.
    default: false
    inputBinding:
      position: 102
      prefix: --suppress_r2_support_filter
  - id: transposase_adapter_seq
    type:
      - 'null'
      - string
    doc: Transposase adapter sequence to be trimmed from reads
    default: CTGTCTCTTATACACATCTGACGCTGCCGACGA
    inputBinding:
      position: 102
      prefix: --transposase_adapter_seq
  - id: umi_regex
    type:
      - 'null'
      - string
    doc: String specifying regex that UMI must match (e.g NNWNNWNNN)
    inputBinding:
      position: 102
      prefix: --umi_regex
  - id: write_discarded_read_info
    type:
      - 'null'
      - boolean
    doc: If true, a file with information for discarded reads is produced
    default: false
    inputBinding:
      position: 102
      prefix: --write_discarded_read_info
  - id: write_umi_counts
    type:
      - 'null'
      - boolean
    doc: If set, a file will be produced containing each UMI and the number of 
      reads that were associated with that UMI
    default: false
    inputBinding:
      position: 102
      prefix: --write_UMI_counts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprlungo:0.1.14--py310h086e186_0
stdout: crisprlungo_CRISPRlungo.out
