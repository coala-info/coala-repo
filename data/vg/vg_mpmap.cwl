cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vg
  - mpmap
label: vg_mpmap
doc: "Multipath align reads to a graph.\n\nTool homepage: https://github.com/vgteam/vg"
inputs:
  - id: agglomerate_alns
    type:
      - 'null'
      - boolean
    doc: combine separate multipath alignments into one (possibly disconnected) 
      alignment
    inputBinding:
      position: 101
      prefix: --agglomerate-alns
  - id: comments_as_tags
    type:
      - 'null'
      - boolean
    doc: intepret comments in name lines as SAM-style tags and annotate 
      alignments with them
    inputBinding:
      position: 101
      prefix: --comments-as-tags
  - id: dist_name
    type:
      - 'null'
      - File
    doc: use this snarl distance index for clustering (recommended, see `vg 
      index`)
    inputBinding:
      position: 101
      prefix: --dist-name
  - id: error_rate
    type:
      - 'null'
      - string
    doc: 'error rate preset: {low, high} (approx. PHRED >20 and <20) [low]'
    default: low
    inputBinding:
      position: 101
      prefix: --error-rate
  - id: fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: input FASTQ (possibly gzipped), can be given twice for paired ends (for
      stdin use -)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: frag_mean
    type:
      - 'null'
      - float
    doc: mean for pre-determined fragment length distribution (also requires -D)
    inputBinding:
      position: 101
      prefix: --frag-mean
  - id: frag_sample
    type:
      - 'null'
      - int
    doc: look for INT unambiguous mappings to estimate the fragment length 
      distribution [1000]
    default: 1000
    inputBinding:
      position: 101
      prefix: --frag-sample
  - id: frag_stddev
    type:
      - 'null'
      - float
    doc: standard deviation for pre-determined fragment length distribution 
      (also requires -I)
    inputBinding:
      position: 101
      prefix: --frag-stddev
  - id: full_l_bonus
    type:
      - 'null'
      - int
    doc: add INT score to alignments that align each end of the read [mismatch+1
      short, 0 long]
    inputBinding:
      position: 101
      prefix: --full-l-bonus
  - id: gam_input
    type:
      - 'null'
      - File
    doc: input GAM (for stdin, use -)
    inputBinding:
      position: 101
      prefix: --gam-input
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: use INT gap extension penalty [1]
    default: 1
    inputBinding:
      position: 101
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: use INT gap open penalty [6 low error, 1 high error]
    inputBinding:
      position: 101
      prefix: --gap-open
  - id: gcsa_name
    type: File
    doc: use this GCSA2 (FILE) & LCP (FILE.lcp) index pair for MEMs (required; 
      see `vg index`)
    inputBinding:
      position: 101
      prefix: --gcsa-name
  - id: graph_name
    type: File
    doc: 'graph (required; XG recommended but other formats are acceptable: see `vg
      convert`)'
    inputBinding:
      position: 101
      prefix: --graph-name
  - id: hit_max
    type:
      - 'null'
      - int
    doc: use at most this many hits for any match seeds (0 for no limit) [1024 
      DNA / 100 RNA]
    inputBinding:
      position: 101
      prefix: --hit-max
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: input contains interleaved paired ends
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: intron_distr
    type:
      - 'null'
      - File
    doc: intron length distribution (from scripts/intron_length_distribution.py)
    inputBinding:
      position: 101
      prefix: --intron-distr
  - id: map_attempts
    type:
      - 'null'
      - int
    doc: perform up to INT mappings per read (0 for no limit) [24 paired / 64 
      unpaired]
    inputBinding:
      position: 101
      prefix: --map-attempts
  - id: match
    type:
      - 'null'
      - int
    doc: use INT match score [1]
    default: 1
    inputBinding:
      position: 101
      prefix: --match
  - id: max_multimaps
    type:
      - 'null'
      - int
    doc: report up to INT mappings per read [10 RNA / 1 DNA]
    inputBinding:
      position: 101
      prefix: --max-multimaps
  - id: mismatch
    type:
      - 'null'
      - int
    doc: use INT mismatch penalty [4 low error, 1 high error]
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: mq_max
    type:
      - 'null'
      - int
    doc: cap mapping quality estimates at this much [60]
    default: 60
    inputBinding:
      position: 101
      prefix: --mq-max
  - id: no_qual_adjust
    type:
      - 'null'
      - boolean
    doc: do not perform base quality adjusted alignments even when base 
      qualities are available
    inputBinding:
      position: 101
      prefix: --no-qual-adjust
  - id: not_spliced
    type:
      - 'null'
      - boolean
    doc: do not form spliced alignments, even with -n RNA
    inputBinding:
      position: 101
      prefix: --not-spliced
  - id: nt_type
    type:
      - 'null'
      - string
    doc: "sequence type preset: 'DNA' for genomic data, 'RNA' for transcriptomic data
      [RNA]"
    default: RNA
    inputBinding:
      position: 101
      prefix: --nt-type
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: "format to output alignments in: 'GAMP' for multipath alignments, 'GAM'/'GAF'
      for single-path alignments, 'SAM'/'BAM'/'CRAM' for linear reference alignments
      (may also require -S) [GAMP]"
    default: GAMP
    inputBinding:
      position: 101
      prefix: --output-fmt
  - id: read_group
    type:
      - 'null'
      - string
    doc: add this read group to output
    inputBinding:
      position: 101
      prefix: --read-group
  - id: read_length
    type:
      - 'null'
      - string
    doc: 'read length preset: {very-short, short, long} (approx. <50bp, 50-500bp,
      and >500bp) [short]'
    default: short
    inputBinding:
      position: 101
      prefix: --read-length
  - id: ref_name
    type:
      - 'null'
      - string
    doc: reference assembly in graph to use for HTSlib formats (see -F) [all 
      references]
    inputBinding:
      position: 101
      prefix: --ref-name
  - id: ref_paths
    type:
      - 'null'
      - File
    doc: paths in graph are 1) one per line in a text file or 2) in an HTSlib 
      .dict, to treat as reference sequences for HTSlib formats (see -F) [all 
      reference paths, all generic paths]
    inputBinding:
      position: 101
      prefix: --ref-paths
  - id: remove_bonuses
    type:
      - 'null'
      - boolean
    doc: remove full length alignment bonus in reported score
    inputBinding:
      position: 101
      prefix: --remove-bonuses
  - id: sample
    type:
      - 'null'
      - string
    doc: add this sample name to output
    inputBinding:
      position: 101
      prefix: --sample
  - id: score_matrix
    type:
      - 'null'
      - File
    doc: use this 4x4 integer substitution scoring matrix (in the order ACGT)
    inputBinding:
      position: 101
      prefix: --score-matrix
  - id: snarls
    type:
      - 'null'
      - File
    doc: align to alternate paths in these snarls (unnecessary if providing -d, 
      see `vg snarls`)
    inputBinding:
      position: 101
      prefix: --snarls
  - id: suppress_progress
    type:
      - 'null'
      - boolean
    doc: do not report progress to stderr
    inputBinding:
      position: 101
      prefix: --suppress-progress
  - id: threads
    type:
      - 'null'
      - int
    doc: number of compute threads to use [all available]
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
stdout: vg_mpmap.out
