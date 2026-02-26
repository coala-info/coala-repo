cwlVersion: v1.2
class: CommandLineTool
baseCommand: duplomap
label: duplomap
doc: "Realign reads overlapping segmental duplications.\n\nTool homepage: https://gitlab.com/tprodanov/duplomap"
inputs:
  - id: ambiguous
    type:
      - 'null'
      - type: array
        items: float
    doc: A read is aligned to a PSV ambiguously if local alignment probabilities
      between the read and the PSV alleles are within FLOAT[1]-fold range 
      (max(probabilities) < min(probabilities) * FLOAT[1]). If the PSV has more 
      than FLOAT[2] percent ambiguously aligned reads, it is not used.
    default:
      - 4
      - 30
    inputBinding:
      position: 101
      prefix: --ambiguous
  - id: conflicts_p_value
    type:
      - 'null'
      - float
    doc: Each read is put through Binomial test with the number of conflicting 
      PSVs out of all homozygous PSVs. All reads that fail the test are assigned
      low MAPQ. The threshold p-value is divided by the number of reads in each 
      component according to the Bonferroni correction.
    default: 0.05
    inputBinding:
      position: 101
      prefix: --conflicts-p-value
  - id: continue_run
    type:
      - 'null'
      - boolean
    doc: Continue duplomap run in the same output directory. In that case 
      duplomap will skip already analyzed duplications clusters (be careful to 
      use the same command line arguments).
    inputBinding:
      position: 101
      prefix: --continue
  - id: copy_num_perc
    type:
      - 'null'
      - float
    doc: Do not realign reads that overlap high copy number regions by more than
      FLOAT %. High copy number regions are defined in duplomap-prepare with 
      --skip-copy-num.
    default: 50
    inputBinding:
      position: 101
      prefix: --copy-num-perc
  - id: database
    type:
      type: array
      items: File
    doc: Database file or directory (multiple entries allowed).
    inputBinding:
      position: 101
      prefix: --database
  - id: default_hmm
    type:
      - 'null'
      - boolean
    doc: Use default HMM parameters (instead of estimating using reads).
    inputBinding:
      position: 101
      prefix: --default-hmm
  - id: filtering_kmer
    type:
      - 'null'
      - int
    doc: k-mer size used for filtering possible location for a read.
    default: 11
    inputBinding:
      position: 101
      prefix: --filtering-kmer
  - id: filtering_p_value
    type:
      - 'null'
      - float
    doc: We compare LCS paths of a read and its possible locations. If location 
      A is better than location B with p-value lower than FLOAT, location B may 
      be discarded.
    default: '1e-4'
    inputBinding:
      position: 101
      prefix: --filtering-p-value
  - id: first
    type:
      - 'null'
      - type: array
        items: int
    doc: Use first INT[1] databases and first INT[2] reads for each database. 
      Use all databases/reads when INT = 0.
    inputBinding:
      position: 101
      prefix: --first
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force work with non-empty output directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: generated
    type:
      - 'null'
      - boolean
    doc: Reads are generated and the true position is known.
    inputBinding:
      position: 101
      prefix: --generated
  - id: gt_min_mapq
    type:
      - 'null'
      - int
    doc: Do not use reads with MAPQ lower than INT to determine genotype 
      probabilities.
    default: 30
    inputBinding:
      position: 101
      prefix: --gt-min-mapq
  - id: gt_prior
    type:
      - 'null'
      - float
    doc: Reference genotype prior.
    default: 0.95
    inputBinding:
      position: 101
      prefix: --gt-prior
  - id: input_bam
    type: File
    doc: Input reads in the sorted and indexed bam format.
    inputBinding:
      position: 101
      prefix: --input
  - id: iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations of EM-algorithm.
    default: 100
    inputBinding:
      position: 101
      prefix: --iterations
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Do not clean, keep all output files.
    inputBinding:
      position: 101
      prefix: --keep
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level in log files (stderr shows logs with info level and 
      higher).
    default: debug
    inputBinding:
      position: 101
      prefix: --log
  - id: max_locations
    type:
      - 'null'
      - int
    doc: Maximal number of locations after filtering. If read can align to more 
      than INT locations, it will get the original alignment and MAPQ 0.
    default: 50
    inputBinding:
      position: 101
      prefix: --max-locations
  - id: min_conflicts
    type:
      - 'null'
      - int
    doc: Minimal number of conflicts between a read and PSVs to discard the 
      read.
    default: 5
    inputBinding:
      position: 101
      prefix: --min-conflicts
  - id: minimap_kmer
    type:
      - 'null'
      - int
    doc: Minimap2 k-mer size.
    default: 11
    inputBinding:
      position: 101
      prefix: --minimap-kmer
  - id: output_debug
    type:
      - 'null'
      - boolean
    doc: Output additional CSV files.
    inputBinding:
      position: 101
      prefix: --output-debug
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Minimap2 alignment preset. Possible values: pacbio [pb] and nanopore [ont]'
    default: pacbio
    inputBinding:
      position: 101
      prefix: --preset
  - id: psv_complexity
    type:
      - 'null'
      - type: array
        items: float
    doc: Keep PSVs that have complexity higher than FLOAT[1] for substitutions 
      (0.6 by default), and FLOAT[2] for indels (0.8 by default).
    inputBinding:
      position: 101
      prefix: --psv-complexity
  - id: psv_size_diff
    type:
      - 'null'
      - int
    doc: Maximal difference in sizes of the PSV sequences (including anchors). 
      PSVs with bigger difference are not used, but influence pre-PSV LCS 
      comparison.
    default: 10
    inputBinding:
      position: 101
      prefix: --psv-size-diff
  - id: read_psv_impact
    type:
      - 'null'
      - float
    doc: Maximal read-PSV impact. A single read cannot decrease genotype 
      probability of a PSV by more than 10^FLOAT, and a single PSV cannot affect
      location probabilities by more than 10^FLOAT.
    default: 3
    inputBinding:
      position: 101
      prefix: --read-psv-impact
  - id: reference
    type: File
    doc: Reference genome in the indexed fasta format.
    inputBinding:
      position: 101
      prefix: --reference
  - id: relative_padding
    type:
      - 'null'
      - float
    doc: Padding added to the sides of possible read locations. For example, for
      a read with with length 3,000 and relative-padding 0.01, possible 
      locations would be padded by 30 bp on both sides.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --relative-padding
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: Path to Samtools executable.
    default: samtools
    inputBinding:
      position: 101
      prefix: --samtools
  - id: secondary
    type:
      - 'null'
      - string
    doc: Output at most INT secondary alignments for each realigned read. Use 
      "all" to output all secondary alignments.
    default: '0'
    inputBinding:
      position: 101
      prefix: --secondary
  - id: skip_mapq
    type:
      - 'null'
      - string
    doc: Skip reads with mapping quality at least INT in the original alignment.
      These reads will be used to estimate genotypes, but will not be realigned.
    default: none
    inputBinding:
      position: 101
      prefix: --skip-mapq
  - id: skip_unique
    type:
      - 'null'
      - boolean
    doc: Do not output reads from unique (not duplicated) regions.
    inputBinding:
      position: 101
      prefix: --skip-unique
  - id: skip_vcf
    type:
      - 'null'
      - boolean
    doc: Do not output vcf file with genotyped PSVs.
    inputBinding:
      position: 101
      prefix: --skip-vcf
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: unknown_regions
    type:
      - 'null'
      - string
    doc: 'How to process reads that overlap unknown regions in the reference: realign
      - Realign a read and assign appropriate MAPQ, keep-old - Keep an old alignment
      and MAPQ, mapq0 - Keep an old alignment and set MAPQ to 0.'
    default: realign
    inputBinding:
      position: 101
      prefix: --unknown-regions
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duplomap:0.9.5--h577a1d6_4
