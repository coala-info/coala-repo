cwlVersion: v1.2
class: CommandLineTool
baseCommand: ryuto
label: ryuto
doc: "Transcript assembler based on flow decomposition (RYUTO) that assembles transcripts from RNA-seq alignments, optionally guided by a gene annotation.\n\nTool homepage: https://github.com/studla/RYUTO"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Sorted input BAM file(s) with their .bai indexes
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 1
  - id: gtf_guide
    type:
      - 'null'
      - File
    doc: 'Path to a gtf/gff file containing reference genes. (default: none)'
    inputBinding:
      position: 101
      prefix: --gtf-guide
  - id: guide_trustlevel
    type:
      - 'null'
      - float
    doc: 'Level of trust in the given guides. 0 no trust. 100 maximal trust. Abstract non-linear variable! (default: 20)'
    inputBinding:
      position: 101
      prefix: --guide-trustlevel
  - id: pool
    type:
      - 'null'
      - int
    doc: 'Number of consecutive inputs to merge internally in groups.'
    inputBinding:
      position: 101
      prefix: --pool
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use in parallel. (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: out_dir
    type: string
    doc: 'The output directory for all data. (default: ./)'
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: library_type
    type:
      - 'null'
      - string
    doc: 'fr-unstranded, fr-firststrand, fr-secondstrand, ff-unstranded, ff-firststrand, or ff-secondstrand according to TopHat and Cufflinks definitions. (default: fr-unstranded)'
    inputBinding:
      position: 101
      prefix: --library-type
  - id: unstranded
    type:
      - 'null'
      - boolean
    doc: 'Add this option to ignore strand information and call everything on + strand. (default: none)'
    inputBinding:
      position: 101
      prefix: --unstranded
  - id: base_coverage_filter
    type:
      - 'null'
      - float
    doc: 'Minimum average coverage for features to be filtered. Sets low-edge-mark, mean-filter, and score-filter (default: 4.0)'
    inputBinding:
      position: 101
      prefix: --base-coverage-filter
  - id: no_parse_heuristic
    type:
      - 'null'
      - boolean
    doc: 'If several input files are used, use this to disable the heuristic to merge fragments. Increases needed RAM. (default: use heuristic)'
    inputBinding:
      position: 101
      prefix: --no-parse-heuristic
  - id: compute_singles
    type:
      - 'null'
      - boolean
    doc: 'If several input files are used, use this to compute transcripts for all individual transcripts. (default: only joined output)'
    inputBinding:
      position: 101
      prefix: --compute-singles
  - id: nc
    type:
      - 'null'
      - int
    doc: 'Number of chromosomes processed in parallel. (# of threads = nc * ng; default: 1)'
    inputBinding:
      position: 101
      prefix: --nc
  - id: ng
    type:
      - 'null'
      - int
    doc: 'Number of graph per chromosome processed in parallel. (# of threads = nc * ng; default: 1)'
    inputBinding:
      position: 101
      prefix: --ng
  - id: pos_merge
    type:
      - 'null'
      - int
    doc: 'Positions within this range of bases will be clustered together. (default: 1)'
    inputBinding:
      position: 101
      prefix: --pos-merge
  - id: min_intron_length
    type:
      - 'null'
      - int
    doc: 'Minimal length of predicted introns. (default: 5)'
    inputBinding:
      position: 101
      prefix: --min-intron-length
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: 'Maximal length of predicted introns. (default: 1,000,000)'
    inputBinding:
      position: 101
      prefix: --max-intron-length
  - id: no_denoising
    type:
      - 'null'
      - boolean
    doc: 'Add this option to disable denoising of flow graph capacities.'
    inputBinding:
      position: 101
      prefix: --no-denoising
  - id: keep_introns
    type:
      - 'null'
      - boolean
    doc: 'Add this option to keep all introns with read coverage intact.'
    inputBinding:
      position: 101
      prefix: --keep-introns
  - id: intron_threshold
    type:
      - 'null'
      - float
    doc: 'Percentage of coverage to existing splices needed to keep introns intact. (default: 30%)'
    inputBinding:
      position: 101
      prefix: --intron-threshold
  - id: broken_intron_threshold
    type:
      - 'null'
      - float
    doc: 'Percentage of coverage to existing splices needed to keep fragmented intron pieces intact. (default: 15%)'
    inputBinding:
      position: 101
      prefix: --broken-intron-threshold
  - id: exon_join_distance
    type:
      - 'null'
      - int
    doc: 'Join exons no more distant than this amount of bp into one. (default: 5)'
    inputBinding:
      position: 101
      prefix: --exon-join-distance
  - id: no_trimming
    type:
      - 'null'
      - boolean
    doc: 'Disable trimming of predicted transcripts based on coverage.'
    inputBinding:
      position: 101
      prefix: --no-trimming
  - id: trimming_rate
    type:
      - 'null'
      - float
    doc: 'Don''t join exons if one is smaller than this percentage of the bigger (default: 20%)'
    inputBinding:
      position: 101
      prefix: --trimming-rate
  - id: low_edge_mark
    type:
      - 'null'
      - float
    doc: 'Capacity of edges in the splitgraph considered unlikely. (default: 4.0)'
    inputBinding:
      position: 101
      prefix: --low-edge-mark
  - id: min_junction_coverage
    type:
      - 'null'
      - int
    doc: 'Minimal coverage to consider intron junctions in the graph. (default: 1)'
    inputBinding:
      position: 101
      prefix: --min-junction-coverage
  - id: min_junction_anchor
    type:
      - 'null'
      - int
    doc: 'Minimal length of bp evidence needed left and right of a junction to consider it. (default: 10)'
    inputBinding:
      position: 101
      prefix: --min-junction-anchor
  - id: group_vote_low
    type:
      - 'null'
      - float
    doc: 'Multi assembly percentage required for simple consensus voting (default: 30%)'
    inputBinding:
      position: 101
      prefix: --group-vote-low
  - id: group_vote_high
    type:
      - 'null'
      - float
    doc: 'Multi assembly percentage required for super-majority consensus voting (default: 60%)'
    inputBinding:
      position: 101
      prefix: --group-vote-high
  - id: percent_filter
    type:
      - 'null'
      - float
    doc: 'Minimum capacity to report retrieved transcripts compared to the largest transcript found. (default: 0%)'
    inputBinding:
      position: 101
      prefix: --percent-filter
  - id: mean_filter
    type:
      - 'null'
      - float
    doc: 'Minimum average capacity to report retrieved transcripts. (default: 4.0)'
    inputBinding:
      position: 101
      prefix: --mean-filter
  - id: score_filter
    type:
      - 'null'
      - float
    doc: 'Minimum score to report retrieved transcripts. (default: 3.0)'
    inputBinding:
      position: 101
      prefix: --score-filter
  - id: min_single_coverage
    type:
      - 'null'
      - float
    doc: 'Minimal average coverage off single exon transcripts to report. (default: 20)'
    inputBinding:
      position: 101
      prefix: --min-single-coverage
  - id: min_single_length
    type:
      - 'null'
      - int
    doc: 'Minimal length off single exon transcripts to report. (default: 300)'
    inputBinding:
      position: 101
      prefix: --min-single-length
  - id: min_transcript_length_base
    type:
      - 'null'
      - int
    doc: 'Minimal length of a transcripts to report in bp. (default: 200)'
    inputBinding:
      position: 101
      prefix: --min-transcript-length-base
  - id: min_transcript_length_extension
    type:
      - 'null'
      - int
    doc: 'Additional length in bp required per exon. (default: 50)'
    inputBinding:
      position: 101
      prefix: --min-transcript-length-extension
  - id: region_group_filter
    type:
      - 'null'
      - float
    doc: 'Regions where all transcripts are below this coverage are discarded. (default: 5.5)'
    inputBinding:
      position: 101
      prefix: --region-group-filter
  - id: min_readlength
    type:
      - 'null'
      - int
    doc: 'Reads below this length will not be used for atom evidence. (default: 30)'
    inputBinding:
      position: 101
      prefix: --min-readlength
  - id: min_paired_distance
    type:
      - 'null'
      - int
    doc: 'Minimal distance between two paired reads in order to be considered. (default: 0)'
    inputBinding:
      position: 101
      prefix: --min-paired-distance
  - id: max_paired_distance
    type:
      - 'null'
      - int
    doc: 'Maximal distance between two paired reads in order to be considered. (default: 100000)'
    inputBinding:
      position: 101
      prefix: --max-paired-distance
  - id: arc_granularity
    type:
      - 'null'
      - int
    doc: 'Maximum number of arcs per original arc on pseudo-polynomial convex cost flows. (default: 500)'
    inputBinding:
      position: 101
      prefix: --arc-granularity
  - id: min_raw_exon_length
    type:
      - 'null'
      - int
    doc: 'Minimal number of basepairs needed to constitute a raw exon. (default: 3)'
    inputBinding:
      position: 101
      prefix: --min-raw-exon-length
  - id: max_path_enumeration
    type:
      - 'null'
      - int
    doc: 'Maximal number of distinct paths enumerated on each side of an ambiguous node. (default: 10,000)'
    inputBinding:
      position: 101
      prefix: --max-path-enumeration
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: transcripts_gtf
    type:
      - 'null'
      - File
    doc: Assembled transcripts
    outputBinding:
      glob: $(inputs.out_dir)/transcripts.gtf
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ryuto:1.6.3--hb03c83d_2
stdout: ryuto.out
