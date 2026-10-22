cwlVersion: v1.2
class: CommandLineTool
baseCommand: STAR-Fusion
label: star-fusion_STAR-Fusion
doc: "STAR-Fusion is a tool for detecting gene fusions from RNA-Seq data.\n\nTool
  homepage: https://github.com/STAR-Fusion/STAR-Fusion"
inputs:
  - id: left_fq
    type:
      - 'null'
      - File
    doc: "left.fq file (or single.fq)"
    inputBinding:
      position: 101
      prefix: --left_fq
  - id: right_fq
    type:
      - 'null'
      - File
    doc: "right.fq file (actually optional, but highly recommended)"
    inputBinding:
      position: 101
      prefix: --right_fq
  - id: chimeric_junction
    type:
      - 'null'
      - File
    doc: "Chimeric.out.junction file from an earlier STAR run"
    inputBinding:
      position: 101
      prefix: --chimeric_junction
  - id: genome_lib_dir
    type:
      - 'null'
      - Directory
    doc: "directory containing the CTAT genome lib"
    inputBinding:
      position: 101
      prefix: --genome_lib_dir
  - id: cpu
    type:
      - 'null'
      - int
    doc: "number of threads for running STAR"
    inputBinding:
      position: 101
      prefix: --CPU
  - id: star_max_mate_dist
    type:
      - 'null'
      - int
    doc: "maximum distance between mates (also the maximum intron length)"
    inputBinding:
      position: 101
      prefix: --STAR_max_mate_dist
  - id: star_sjdb_overhang_min
    type:
      - 'null'
      - int
    doc: "minimum overhang for annotated junctions"
    inputBinding:
      position: 101
      prefix: --STAR_SJDBoverhangMin
  - id: star_sorted_by_coordinate
    type:
      - 'null'
      - boolean
    doc: "have STAR sort the resulting bam file by coordinate"
    inputBinding:
      position: 101
      prefix: --STAR_SortedByCoordinate
  - id: star_limit_bam_sort_ram
    type:
      - 'null'
      - string
    doc: "number of GB of RAM for sorting the bam file"
    inputBinding:
      position: 101
      prefix: --STAR_limitBAMsortRAM
  - id: run_star_only
    type:
      - 'null'
      - boolean
    doc: "stop after running the STAR aligner (only generates Chimeric.out.junction)"
    inputBinding:
      position: 101
      prefix: --run_STAR_only
  - id: star_twopass
    type:
      - 'null'
      - boolean
    doc: "do STAR two-pass instead of one pass"
    inputBinding:
      position: 101
      prefix: --STAR_twopass
  - id: star_pe_overlap_n_bases_min
    type:
      - 'null'
      - int
    doc: "minimum number of bases in the overlap of paired reads"
    inputBinding:
      position: 101
      prefix: --STAR_peOverlapNbasesMin
  - id: star_pe_overlap_mmp
    type:
      - 'null'
      - float
    doc: "maximum proportion of mismatches in the overlap"
    inputBinding:
      position: 101
      prefix: --STAR_peOverlapMMp
  - id: star_chim_multimap_score_range
    type:
      - 'null'
      - int
    doc: "score range for multi-mapping chimeras below the best chimeric score"
    inputBinding:
      position: 101
      prefix: --STAR_chimMultimapScoreRange
  - id: star_chim_multimap_n_max
    type:
      - 'null'
      - int
    doc: "maximum number of multi-alignments for the chimera"
    inputBinding:
      position: 101
      prefix: --STAR_chimMultimapNmax
  - id: star_chim_nonchim_score_drop_min
    type:
      - 'null'
      - int
    doc: "drop in the best non-chimeric alignment score that triggers chimeric detection"
    inputBinding:
      position: 101
      prefix: --STAR_chimNonchimScoreDropMin
  - id: star_out_sam_attr_rg_line
    type:
      - 'null'
      - string
    doc: "read group line passed to STAR as --outSAMattrRGline"
    inputBinding:
      position: 101
      prefix: --STAR_outSAMattrRGline
  - id: min_pct_mm_nonspecific
    type:
      - 'null'
      - int
    doc: "min percent of multimapping reads that should map to 2 genes (1-100)"
    inputBinding:
      position: 101
      prefix: --min_pct_MM_nonspecific
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: "do not filter predictions"
    inputBinding:
      position: 101
      prefix: --no_filter
  - id: min_junction_reads
    type:
      - 'null'
      - int
    doc: "minimum number of junction-spanning reads required"
    inputBinding:
      position: 101
      prefix: --min_junction_reads
  - id: min_sum_frags
    type:
      - 'null'
      - int
    doc: "minimum fusion support (junction reads + spanning fragments)"
    inputBinding:
      position: 101
      prefix: --min_sum_frags
  - id: require_ldas
    type:
      - 'null'
      - int
    doc: "require long double anchor support for split reads when no spanning frags are found (0 or 1)"
    inputBinding:
      position: 101
      prefix: --require_LDAS
  - id: max_promiscuity
    type:
      - 'null'
      - int
    doc: "maximum number of partners allowed for a given fusion"
    inputBinding:
      position: 101
      prefix: --max_promiscuity
  - id: min_pct_dom_promiscuity
    type:
      - 'null'
      - int
    doc: "minimum support relative to the dominant scoring pair for promiscuous fusions"
    inputBinding:
      position: 101
      prefix: --min_pct_dom_promiscuity
  - id: aggregate_novel_junction_dist
    type:
      - 'null'
      - int
    doc: "non-reference junctions within this distance are merged into single calls"
    inputBinding:
      position: 101
      prefix: --aggregate_novel_junction_dist
  - id: min_novel_junction_support
    type:
      - 'null'
      - int
    doc: "minimum junction reads required if the breakpoint is not a reference junction"
    inputBinding:
      position: 101
      prefix: --min_novel_junction_support
  - id: min_spanning_frags_only
    type:
      - 'null'
      - int
    doc: "minimum fragments required as evidence if there are no junction reads"
    inputBinding:
      position: 101
      prefix: --min_spanning_frags_only
  - id: min_alt_pct_junction
    type:
      - 'null'
      - float
    doc: "percent of the dominant isoform junction support"
    inputBinding:
      position: 101
      prefix: --min_alt_pct_junction
  - id: min_ffpm
    type:
      - 'null'
      - float
    doc: "minimum FFPM (fusion fragments per million rna-seq frags)"
    inputBinding:
      position: 101
      prefix: --min_FFPM
  - id: no_remove_dups
    type:
      - 'null'
      - boolean
    doc: "do not remove duplicate reads"
    inputBinding:
      position: 101
      prefix: --no_remove_dups
  - id: skip_em
    type:
      - 'null'
      - boolean
    doc: "skip expectation maximization based fractional assignment of spanning fragments"
    inputBinding:
      position: 101
      prefix: --skip_EM
  - id: skip_ffpm
    type:
      - 'null'
      - boolean
    doc: "skip FFPM computation"
    inputBinding:
      position: 101
      prefix: --skip_FFPM
  - id: no_annotation_filter
    type:
      - 'null'
      - boolean
    doc: "exclude filtering of fusion predictions based on annotations"
    inputBinding:
      position: 101
      prefix: --no_annotation_filter
  - id: no_rt_artifact_filter
    type:
      - 'null'
      - boolean
    doc: "exclude filtering of likely RT artifacts"
    inputBinding:
      position: 101
      prefix: --no_RT_artifact_filter
  - id: no_single_fusion_per_breakpoint
    type:
      - 'null'
      - boolean
    doc: "exclude filtering of superfluous fusions overlapping the same breakpoint"
    inputBinding:
      position: 101
      prefix: --no_single_fusion_per_breakpoint
  - id: examine_coding_effect
    type:
      - 'null'
      - boolean
    doc: "explore the impact of fusions on coding sequences"
    inputBinding:
      position: 101
      prefix: --examine_coding_effect
  - id: extract_fusion_reads
    type:
      - 'null'
      - boolean
    doc: "retrieve the fusion supporting reads from the fastq files"
    inputBinding:
      position: 101
      prefix: --extract_fusion_reads
  - id: fusion_inspector
    type:
      - 'null'
      - string
    doc: "include FusionInspector: inspect or validate"
    inputBinding:
      position: 101
      prefix: --FusionInspector
  - id: denovo_reconstruct
    type:
      - 'null'
      - boolean
    doc: "attempt to reconstruct fusion transcripts using Trinity (requires FusionInspector)"
    inputBinding:
      position: 101
      prefix: --denovo_reconstruct
  - id: misc_fi_opts
    type:
      - 'null'
      - string
    doc: "additional options passed on to FusionInspector"
    inputBinding:
      position: 101
      prefix: --misc_FI_opts
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: "directory for temporary files"
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: "verbosity (default 2, max 2)"
    inputBinding:
      position: 101
      prefix: --verbose_level
  - id: max_sensitivity
    type:
      - 'null'
      - boolean
    doc: "max sensitivity options (min_junction_reads 0, min_sum_frags 1, ...)"
    inputBinding:
      position: 101
      prefix: --max_sensitivity
  - id: full_monty
    type:
      - 'null'
      - boolean
    doc: "max sensitivity and disables filters"
    inputBinding:
      position: 101
      prefix: --full_Monty
  - id: output_dir
    type: string
    doc: "output directory"
    default: STAR-Fusion_outdir
    inputBinding:
      position: 101
      prefix: --output_dir
arguments:
  - position: 1000
    shellQuote: false
    valueFrom: "&& rm -f $(inputs.output_dir)/star-fusion.preliminary/star-fusion.fusion_candidates.preliminary.filtered"
outputs:
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: output directory with the fusion predictions
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/star-fusion:1.15.1--hdfd78af_1
