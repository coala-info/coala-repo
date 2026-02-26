# fusion-inspector CWL Generation Report

## fusion-inspector_FusionInspector

### Tool Description
Extracts a pair of genes from the genome, creates a mini-contig, aligns reads to the mini-contig, and extracts the fusion reads as a separate tier for vsiualization.

### Metadata
- **Docker Image**: quay.io/biocontainers/fusion-inspector:2.10.0--py313pl5321hdfd78af_1
- **Homepage**: https://github.com/FusionInspector/FusionInspector
- **Package**: https://anaconda.org/channels/bioconda/packages/fusion-inspector/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fusion-inspector/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FusionInspector/FusionInspector
- **Stars**: N/A
### Original Help Text
```text
usage: FusionInspector [-h] --fusions CHIM_SUMMARY_FILES
                       [--left_fq LEFT_FQ_FILENAME]
                       [--right_fq RIGHT_FQ_FILENAME]
                       [--genome_lib_dir GENOME_LIB_DIR]
                       [--samples_file SAMPLES_FILE] [-O STR_OUT_DIR]
                       [--out_prefix OUT_PREFIX]
                       [--min_junction_reads MIN_JUNCTION_READS]
                       [--min_sum_frags MIN_SUM_FRAGS]
                       [--min_novel_junction_support MIN_NOVEL_JUNCTION_SUPPORT]
                       [--min_spanning_frags_only MIN_SPANNING_FRAGS_ONLY]
                       [--require_LDAS REQUIRE_LDAS]
                       [--max_promiscuity MAX_PROMISCUITY]
                       [--min_pct_dom_promiscuity MIN_PCT_DOM_PROMISCUITY]
                       [--min_per_id MIN_PER_ID]
                       [--max_mate_dist MAX_MATE_DIST] [--only_fusion_reads]
                       [--capture_genome_alignments] [--include_Trinity]
                       [--vis] [--write_intermediate_results] [--cleanup]
                       [--CPU CPU] [--annotate] [--examine_coding_effect]
                       [--aligner_path ALIGNER_PATH] [--fusion_contigs_only]
                       [--extract_fusion_reads_file EXTRACT_FUSION_READS_FILE]
                       [--no_remove_dups] [--version] [--no_FFPM]
                       [--no_splice_score_boost] [--no_shrink_introns]
                       [--shrink_intron_max_length SHRINK_INTRON_MAX_LENGTH]
                       [--skip_EM] [--incl_microH_expr_brkpt_plots]
                       [--predict_cosmic_like]
                       [--STAR_xtra_params STAR_XTRA_PARAMS]
                       [--no_homology_filter] [--no_annot_filter]
                       [--max_sensitivity] [--extreme_sensitivity]
                       [--FI_contigs_gtf FI_CONTIGS_GTF]
                       [--FI_contigs_fa FI_CONTIGS_FA]

Extracts a pair of genes from the genome, creates a mini-contig, aligns reads to the mini-contig, and extracts the fusion reads as a separate tier for vsiualization.

required arguments:
  --fusions CHIM_SUMMARY_FILES
                        fusions summary files (list, comma-delimited and no spaces)
  --left_fq LEFT_FQ_FILENAME
                        left (or single) fastq file
  --right_fq RIGHT_FQ_FILENAME
                        right fastq file (optional)

optional arguments:
  --genome_lib_dir GENOME_LIB_DIR
                        genome lib directory - see http://FusionFilter.github.io for details.  Uses env var CTAT_GENOME_LIB as default
  --samples_file SAMPLES_FILE
                        samples file for smartSeq2 single cell rna-seq (format: sample(tab)/path/left.fq(tab)/path/right.fq
  -O, --output_dir STR_OUT_DIR
                        output directory
  --out_prefix OUT_PREFIX
                        output filename prefix (default: finspector)
  --min_junction_reads MIN_JUNCTION_READS
                        minimum number of junction-spanning reads required (default: 0)
  --min_sum_frags MIN_SUM_FRAGS
                        minimum fusion support = ( # junction_reads + # spanning_frags )  (default: 1)
  --min_novel_junction_support MIN_NOVEL_JUNCTION_SUPPORT
                        minimum number of junction reads required if breakpoint lacks involvement of only reference junctions (default: 3)
  --min_spanning_frags_only MIN_SPANNING_FRAGS_ONLY
                        minimum number of spanning frags if no junction reads are found (default: 5)
  --require_LDAS REQUIRE_LDAS
                        require long double anchor support for split reads when no spanning frags are found (default: 1)
  --max_promiscuity MAX_PROMISCUITY
                        maximum number of partners allowed for a given fusion (default: 10)
  --min_pct_dom_promiscuity MIN_PCT_DOM_PROMISCUITY
                        for promiscuous fusions, those with less than this support of the dominant scoring pair are filtered prior to applying the max_promiscuity filter. (default: 50)
  --min_per_id MIN_PER_ID
                        minimum percent identity for a fusion-supporting read alignment (defualt: 96)
  --max_mate_dist MAX_MATE_DIST
                        max distance between mates, also max intron length for STAR alignments (default: 100000)
  --only_fusion_reads   include only read alignments in output that support fusion
  --capture_genome_alignments
                        reports ref genome alignments too (for debugging only)
  --include_Trinity     include fusion-guided Trinity assembly
  --vis                 generate bam, bed, etc., and generate igv-reports html visualization
  --write_intermediate_results
                        generate bam, bed, etc., for intermediate aligner outputs
  --cleanup             cleanup the fusion inspector workspace, remove intermediate output files
  --CPU CPU             number of threads for multithreaded processes (default: 4)
  --annotate            annotate fusions based on known cancer fusions and those found in normal tissues
  --examine_coding_effect
                        explore impact of fusions on coding sequences
  --aligner_path ALIGNER_PATH
                        path to the aligner tool (default: uses PATH setting)
  --fusion_contigs_only
                        align reads only to the fusion contigs (note, FFPM calcs disabled in this mode)
  --extract_fusion_reads_file EXTRACT_FUSION_READS_FILE
                        file prefix to write fusion evidence reads in fastq format
  --no_remove_dups      do not exclude duplicate reads
  --version             provide version info: 2.10.0
  --no_FFPM             do not compute FFPM value - ie. using inspect instead of validate mode, in which case FFPM would not be meaningful given the full sample of reads is not evaluated
  --no_splice_score_boost
                        do not augment alignment score for spliced alignments
  --no_shrink_introns   do not shrink introns
  --shrink_intron_max_length SHRINK_INTRON_MAX_LENGTH
                        maximum length of introns when shrunk (default: 1000)
  --skip_EM             skip expectation maximization step that fractionally assigns spanning frags across multiple breakpoints
  --incl_microH_expr_brkpt_plots
                         include microhomology expression breakpoint plots
  --predict_cosmic_like
                        predict if fusion looks COSMIC-like wrt expression and microhomology charachteristics. Automatically disabled if --no_FFPM is set.
  --STAR_xtra_params STAR_XTRA_PARAMS
                        extra parameters to pass on to the STAR aligner
  --no_homology_filter  no gene symbol-based blast pair homology filter or promiscuity checks to remove potential false positives
  --no_annot_filter     no annotation-based filters applied (ie. removing GTEx normal fusions)
  --max_sensitivity      max sensitivity settings (specificity unchecked) equivalent to --min_sum_frags 1 --min_spanning_frags_only 1 --min_novel_junction_support 1 --require_LDAS 0 --no_homology_filter --no_annot_filter --min_per_id 1 --no_remove_dups --skip_EM
  --extreme_sensitivity
                        extreme sensitivity. If there are evidence reads, this should ideally find them - however, false positive rate is expected to be maximally high too!. Equivalent to settings:  --max_sensitivity --fusion_contigs_only  --max_mate_dist 10000000
  --FI_contigs_gtf FI_CONTIGS_GTF
                        provide the fusion inspector contig targets directly instead of making it at runtime.
  --FI_contigs_fa FI_CONTIGS_FA
                        provide the fusion inspector contigs fasta directly instead of making it at runtime
```

