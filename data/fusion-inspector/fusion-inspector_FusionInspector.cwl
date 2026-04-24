cwlVersion: v1.2
class: CommandLineTool
baseCommand: FusionInspector
label: fusion-inspector_FusionInspector
doc: "Extracts a pair of genes from the genome, creates a mini-contig, aligns reads
  to the mini-contig, and extracts the fusion reads as a separate tier for vsiualization.\n\
  \nTool homepage: https://github.com/FusionInspector/FusionInspector"
inputs:
  - id: aligner_path
    type:
      - 'null'
      - string
    doc: 'path to the aligner tool (default: uses PATH setting)'
    inputBinding:
      position: 101
      prefix: --aligner_path
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: annotate fusions based on known cancer fusions and those found in 
      normal tissues
    inputBinding:
      position: 101
      prefix: --annotate
  - id: capture_genome_alignments
    type:
      - 'null'
      - boolean
    doc: reports ref genome alignments too (for debugging only)
    inputBinding:
      position: 101
      prefix: --capture_genome_alignments
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: cleanup the fusion inspector workspace, remove intermediate output 
      files
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'number of threads for multithreaded processes (default: 4)'
    inputBinding:
      position: 101
      prefix: --CPU
  - id: examine_coding_effect
    type:
      - 'null'
      - boolean
    doc: explore impact of fusions on coding sequences
    inputBinding:
      position: 101
      prefix: --examine_coding_effect
  - id: extract_fusion_reads_file
    type:
      - 'null'
      - File
    doc: file prefix to write fusion evidence reads in fastq format
    inputBinding:
      position: 101
      prefix: --extract_fusion_reads_file
  - id: extreme_sensitivity
    type:
      - 'null'
      - boolean
    doc: 'extreme sensitivity. If there are evidence reads, this should ideally find
      them - however, false positive rate is expected to be maximally high too!. Equivalent
      to settings:  --max_sensitivity --fusion_contigs_only  --max_mate_dist 10000000'
    inputBinding:
      position: 101
      prefix: --extreme_sensitivity
  - id: fi_contigs_fa
    type:
      - 'null'
      - File
    doc: provide the fusion inspector contigs fasta directly instead of making 
      it at runtime
    inputBinding:
      position: 101
      prefix: --FI_contigs_fa
  - id: fi_contigs_gtf
    type:
      - 'null'
      - File
    doc: provide the fusion inspector contig targets directly instead of making 
      it at runtime.
    inputBinding:
      position: 101
      prefix: --FI_contigs_gtf
  - id: fusion_contigs_only
    type:
      - 'null'
      - boolean
    doc: align reads only to the fusion contigs (note, FFPM calcs disabled in 
      this mode)
    inputBinding:
      position: 101
      prefix: --fusion_contigs_only
  - id: fusions
    type: string
    doc: fusions summary files (list, comma-delimited and no spaces)
    inputBinding:
      position: 101
      prefix: --fusions
  - id: genome_lib_dir
    type:
      - 'null'
      - Directory
    doc: genome lib directory - see http://FusionFilter.github.io for details.  
      Uses env var CTAT_GENOME_LIB as default
    inputBinding:
      position: 101
      prefix: --genome_lib_dir
  - id: incl_microh_expr_brkpt_plots
    type:
      - 'null'
      - boolean
    doc: include microhomology expression breakpoint plots
    inputBinding:
      position: 101
      prefix: --incl_microH_expr_brkpt_plots
  - id: include_trinity
    type:
      - 'null'
      - boolean
    doc: include fusion-guided Trinity assembly
    inputBinding:
      position: 101
      prefix: --include_Trinity
  - id: left_fq
    type: File
    doc: left (or single) fastq file
    inputBinding:
      position: 101
      prefix: --left_fq
  - id: max_mate_dist
    type:
      - 'null'
      - int
    doc: 'max distance between mates, also max intron length for STAR alignments (default:
      100000)'
    inputBinding:
      position: 101
      prefix: --max_mate_dist
  - id: max_promiscuity
    type:
      - 'null'
      - int
    doc: 'maximum number of partners allowed for a given fusion (default: 10)'
    inputBinding:
      position: 101
      prefix: --max_promiscuity
  - id: max_sensitivity
    type:
      - 'null'
      - boolean
    doc: max sensitivity settings (specificity unchecked) equivalent to 
      --min_sum_frags 1 --min_spanning_frags_only 1 --min_novel_junction_support
      1 --require_LDAS 0 --no_homology_filter --no_annot_filter --min_per_id 1 
      --no_remove_dups --skip_EM
    inputBinding:
      position: 101
      prefix: --max_sensitivity
  - id: min_junction_reads
    type:
      - 'null'
      - int
    doc: 'minimum number of junction-spanning reads required (default: 0)'
    inputBinding:
      position: 101
      prefix: --min_junction_reads
  - id: min_novel_junction_support
    type:
      - 'null'
      - int
    doc: 'minimum number of junction reads required if breakpoint lacks involvement
      of only reference junctions (default: 3)'
    inputBinding:
      position: 101
      prefix: --min_novel_junction_support
  - id: min_pct_dom_promiscuity
    type:
      - 'null'
      - float
    doc: 'for promiscuous fusions, those with less than this support of the dominant
      scoring pair are filtered prior to applying the max_promiscuity filter. (default:
      50)'
    inputBinding:
      position: 101
      prefix: --min_pct_dom_promiscuity
  - id: min_per_id
    type:
      - 'null'
      - int
    doc: 'minimum percent identity for a fusion-supporting read alignment (defualt:
      96)'
    inputBinding:
      position: 101
      prefix: --min_per_id
  - id: min_spanning_frags_only
    type:
      - 'null'
      - int
    doc: 'minimum number of spanning frags if no junction reads are found (default:
      5)'
    inputBinding:
      position: 101
      prefix: --min_spanning_frags_only
  - id: min_sum_frags
    type:
      - 'null'
      - int
    doc: 'minimum fusion support = ( # junction_reads + # spanning_frags )  (default:
      1)'
    inputBinding:
      position: 101
      prefix: --min_sum_frags
  - id: no_annot_filter
    type:
      - 'null'
      - boolean
    doc: no annotation-based filters applied (ie. removing GTEx normal fusions)
    inputBinding:
      position: 101
      prefix: --no_annot_filter
  - id: no_ffpm
    type:
      - 'null'
      - boolean
    doc: do not compute FFPM value - ie. using inspect instead of validate mode,
      in which case FFPM would not be meaningful given the full sample of reads 
      is not evaluated
    inputBinding:
      position: 101
      prefix: --no_FFPM
  - id: no_homology_filter
    type:
      - 'null'
      - boolean
    doc: no gene symbol-based blast pair homology filter or promiscuity checks 
      to remove potential false positives
    inputBinding:
      position: 101
      prefix: --no_homology_filter
  - id: no_remove_dups
    type:
      - 'null'
      - boolean
    doc: do not exclude duplicate reads
    inputBinding:
      position: 101
      prefix: --no_remove_dups
  - id: no_shrink_introns
    type:
      - 'null'
      - boolean
    doc: do not shrink introns
    inputBinding:
      position: 101
      prefix: --no_shrink_introns
  - id: no_splice_score_boost
    type:
      - 'null'
      - boolean
    doc: do not augment alignment score for spliced alignments
    inputBinding:
      position: 101
      prefix: --no_splice_score_boost
  - id: only_fusion_reads
    type:
      - 'null'
      - boolean
    doc: include only read alignments in output that support fusion
    inputBinding:
      position: 101
      prefix: --only_fusion_reads
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: 'output filename prefix (default: finspector)'
    inputBinding:
      position: 101
      prefix: --out_prefix
  - id: predict_cosmic_like
    type:
      - 'null'
      - boolean
    doc: predict if fusion looks COSMIC-like wrt expression and microhomology 
      charachteristics. Automatically disabled if --no_FFPM is set.
    inputBinding:
      position: 101
      prefix: --predict_cosmic_like
  - id: require_ldas
    type:
      - 'null'
      - int
    doc: 'require long double anchor support for split reads when no spanning frags
      are found (default: 1)'
    inputBinding:
      position: 101
      prefix: --require_LDAS
  - id: right_fq
    type:
      - 'null'
      - File
    doc: right fastq file (optional)
    inputBinding:
      position: 101
      prefix: --right_fq
  - id: samples_file
    type:
      - 'null'
      - File
    doc: 'samples file for smartSeq2 single cell rna-seq (format: sample(tab)/path/left.fq(tab)/path/right.fq'
    inputBinding:
      position: 101
      prefix: --samples_file
  - id: shrink_intron_max_length
    type:
      - 'null'
      - int
    doc: 'maximum length of introns when shrunk (default: 1000)'
    inputBinding:
      position: 101
      prefix: --shrink_intron_max_length
  - id: skip_em
    type:
      - 'null'
      - boolean
    doc: skip expectation maximization step that fractionally assigns spanning 
      frags across multiple breakpoints
    inputBinding:
      position: 101
      prefix: --skip_EM
  - id: star_xtra_params
    type:
      - 'null'
      - string
    doc: extra parameters to pass on to the STAR aligner
    inputBinding:
      position: 101
      prefix: --STAR_xtra_params
  - id: vis
    type:
      - 'null'
      - boolean
    doc: generate bam, bed, etc., and generate igv-reports html visualization
    inputBinding:
      position: 101
      prefix: --vis
  - id: write_intermediate_results
    type:
      - 'null'
      - boolean
    doc: generate bam, bed, etc., for intermediate aligner outputs
    inputBinding:
      position: 101
      prefix: --write_intermediate_results
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/fusion-inspector:2.10.0--py313pl5321hdfd78af_1
