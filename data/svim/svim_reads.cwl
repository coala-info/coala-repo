cwlVersion: v1.2
class: CommandLineTool
baseCommand: svim_reads
label: svim_reads
doc: "SVIM is a structural variant caller for long reads.\n\nTool homepage: https://github.com/eldariont/svim"
inputs:
  - id: working_dir
    type: Directory
    doc: Working and output directory. Existing files in the directory are 
      overwritten. If the directory does not exist, it is created.
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: 'Read file (FASTA, FASTQ, gzipped FASTA, gzipped FASTQ or file list). The
      read file has to have one of the following supported file endings: FASTA: .fa,
      .fasta, .FA, .fa.gz, .fa.gzip, .fasta.gz, .fasta.gzip FASTQ: .fq, .fastq, .FQ,
      .fq.gz, .fq.gzip, .fastq.gz, .fastq.gzip FILE LIST: .fa.fn, fq.fn'
    inputBinding:
      position: 2
  - id: genome
    type: File
    doc: Reference genome file (FASTA)
    inputBinding:
      position: 3
  - id: aligner
    type:
      - 'null'
      - string
    doc: 'Tool for read alignment: ngmlr or minimap2 (default: ngmlr)'
    default: ngmlr
    inputBinding:
      position: 104
      prefix: --aligner
  - id: all_bnds
    type:
      - 'null'
      - boolean
    doc: "Output all rearrangements additionally in BND notation (default: False).
      By default, SV signatures from the read alignments are used to detect complete
      SVs, such as deletions, insertions and inversions. When this option is enabled,
      all SVs are also output in breakend (BND) notation as defined in the VCF specs.
      For instance, a deletion gets two records in the VCF output: 1. the normal <DEL>
      record and 2. a <BND> record representing the novel adjacency between the deletion's
      start and end coordinate in the sample genome."
    default: false
    inputBinding:
      position: 104
      prefix: --all_bnds
  - id: cluster_max_distance
    type:
      - 'null'
      - float
    doc: 'Maximum span-position distance between SVs in a cluster (default: 0.5).
      This is the most important parameter because it determines the strictness of
      clustering. Choosing a large value leads to fewer but larger clusters with larger
      distances between its members. Choosing a small value leads to more but smaller
      clusters with smaller distances between its members. This parameter determines
      the height of the cut-off in the hierarchical clustering dendrogram.'
    default: 0.5
    inputBinding:
      position: 104
      prefix: --cluster_max_distance
  - id: cores
    type:
      - 'null'
      - int
    doc: 'CPU cores to use for the alignment (default: 1)'
    default: 1
    inputBinding:
      position: 104
      prefix: --cores
  - id: del_ins_dup_max_distance
    type:
      - 'null'
      - float
    doc: 'Maximum span-position distance between the origin of an insertion and a
      deletion to be flagged as a potential cut&paste insertion (default: 1.0)'
    default: 1.0
    inputBinding:
      position: 104
      prefix: --del_ins_dup_max_distance
  - id: edit_distance_normalizer
    type:
      - 'null'
      - float
    doc: 'Distance normalizer used specifically for insertions (default: 1.0). SVIM
      clusters insertion signatures using an hierarchical clustering approach and
      a special distance metric for insertions. This distance is the sum of two components,
      position distance and edit distance between the insertion sequences. The edit
      distance is normalized (i.e. divided) by the product of the span of the longer
      insertion and this normalizer. The position distance is the difference in position
      between signatures normalized by the position distance normalizer (another parameter).
      A smaller edit distance normalizer leads to a larger edit distance and as a
      consequence increases the importance of the edit distance in the clustering
      process so that only insertions with very similar sequences are clustered together.
      A larger edit distance normalizer diminishes the importance of the insertion
      sequences in the clustering process.'
    default: 1.0
    inputBinding:
      position: 104
      prefix: --edit_distance_normalizer
  - id: heterozygous_threshold
    type:
      - 'null'
      - float
    doc: 'Minimum variant allele frequency to be called as heterozygous (default:
      0.2). Allele frequency is computed as the fraction of reads supporting the variant
      over the total number of reads covering the variant. Variants with an allele
      frequence greater than or equal to this threshold but lower than the homozygous
      threshold are called as heterozygous alternative. Variants with an allele frequence
      lower than this threshold are called as homozygous reference.'
    default: 0.2
    inputBinding:
      position: 104
      prefix: --heterozygous_threshold
  - id: homozygous_threshold
    type:
      - 'null'
      - float
    doc: 'Minimum variant allele frequency to be called as homozygous (default: 0.8).
      Allele frequency is computed as the fraction of reads supporting the variant
      over the total number of reads covering the variant. Variants with an allele
      frequence greater than or equal to this threshold are called as homozygous alternative.'
    default: 0.8
    inputBinding:
      position: 104
      prefix: --homozygous_threshold
  - id: insertion_sequences
    type:
      - 'null'
      - boolean
    doc: 'Output insertion sequences in INFO tag of VCF (default: False). If enabled,
      the INFO/SEQS tag contains a list of insertion sequences from the supporting
      reads.'
    default: false
    inputBinding:
      position: 104
      prefix: --insertion_sequences
  - id: interspersed_duplications_as_insertions
    type:
      - 'null'
      - boolean
    doc: 'Represent interspersed duplications as insertions in output VCF (default:
      False). By default, interspersed duplications are represented by the SVTYPE=DUP:INT
      and the genomic source is given by the POS and END tags. When enabling this
      option, duplications are instead represented by the SVTYPE=INS and POS and END
      both give the insertion point of the duplication.'
    default: false
    inputBinding:
      position: 104
      prefix: --interspersed_duplications_as_insertions
  - id: max_consensus_length
    type:
      - 'null'
      - int
    doc: 'Maximum size of insertion sequences for consensus computation. (default:
      10000) For insertions longer than this threshold, no consensus is computed to
      save memory.'
    default: 10000
    inputBinding:
      position: 104
      prefix: --max_consensus_length
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: 'Maximum SV size to detect (default: 100000). This parameter is used to distinguish
      long deletions (and inversions) from translocations which cannot be distinguished
      from the alignment alone. Split read segments mapping far apart on the reference
      could either indicate a very long deletion (inversion) or a translocation breakpoint.
      SVIM calls a translocation breakpoint if the mapping distance is larger than
      this parameter and a deletion (or inversion) if it is smaller or equal.'
    default: 100000
    inputBinding:
      position: 104
      prefix: --max_sv_size
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality of reads to consider (default: 20). Reads with a
      lower mapping quality are ignored.'
    default: 20
    inputBinding:
      position: 104
      prefix: --min_mapq
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: 'Minimum SV size to detect (default: 40). SVIM can potentially detect events
      of any size but is limited by the signal-to-noise ratio in the input alignments.
      That means that more accurate reads and alignments enable the detection of smaller
      events. For current PacBio or Nanopore data, we would recommend a minimum size
      of 40bp or larger.'
    default: 40
    inputBinding:
      position: 104
      prefix: --min_sv_size
  - id: minimum_depth
    type:
      - 'null'
      - int
    doc: 'Minimum total read depth for genotyping (default: 4). Variants covered by
      a total number of reads lower than this value are not assigned a genotype (./.
      in the output VCF file).'
    default: 4
    inputBinding:
      position: 104
      prefix: --minimum_depth
  - id: minimum_score
    type:
      - 'null'
      - int
    doc: 'Minimum score for genotyping (default: 3). Only SV candidates with a higher
      or equal score are genotyped. Depending on the score distribution among the
      SV candidates, decreasing this value increases the runtime. We recommend to
      choose a value close to the score threshold used for filtering the SV candidates.'
    default: 3
    inputBinding:
      position: 104
      prefix: --minimum_score
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: 'Use Nanopore settings for read alignment (default: False)'
    default: false
    inputBinding:
      position: 104
      prefix: --nanopore
  - id: partition_max_distance
    type:
      - 'null'
      - int
    doc: 'Maximum distance in bp between SVs in a partition (default: 1000). Before
      clustering, the SV signatures are divided into coarse partitions. This parameter
      determines the maximum distance between two subsequent signatures in the same
      partition. If the distance between two subsequent signatures is larger than
      this parameter, they are distributed into separate partitions.'
    default: 1000
    inputBinding:
      position: 104
      prefix: --partition_max_distance
  - id: position_distance_normalizer
    type:
      - 'null'
      - float
    doc: 'Distance normalizer used for span-position distance (default: 900). SVIM
      clusters the SV signatures using an hierarchical clustering approach and a novel
      distance metric called "span-position distance". Span- position distance is
      the sum of two components, span distance and position distance. The span distance
      is the difference in lengths between signatures normalized by the greater length
      and always lies in the interval [0,1]. The position distance is the difference
      in position between signatures normalized by the distance normalizer (this parameter).
      For a position difference of 1.8kb and a distance normalizer of 900, the position
      distance will be 2. A smaller distance normalizer leads to a higher position
      distance and as a consequence increases the importance of the position distance
      in the span-position distance relative to the span distance.'
    default: 900.0
    inputBinding:
      position: 104
      prefix: --position_distance_normalizer
  - id: read_names
    type:
      - 'null'
      - boolean
    doc: 'Output names of supporting reads in INFO tag of VCF (default: False). If
      enabled, the INFO/READS tag contains the list of names of the supporting reads.'
    default: false
    inputBinding:
      position: 104
      prefix: --read_names
  - id: sample
    type:
      - 'null'
      - string
    doc: 'Sample ID to include in output vcf file (default: Sample)'
    default: Sample
    inputBinding:
      position: 104
      prefix: --sample
  - id: segment_gap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated gap between adjacent alignment segments (default: 10).
      This parameter applies to gaps on the reference and the read. Example: Deletions
      are detected from two subsequent segments of a split read that are mapped far
      apart from each other on the reference. The segment gap tolerance determines
      the maximum tolerated length of the read gap between both segments. If there
      is an unaligned read segment larger than this value between the two segments,
      no deletion is called.'
    default: 10
    inputBinding:
      position: 104
      prefix: --segment_gap_tolerance
  - id: segment_overlap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated overlap between adjacent alignment segments (default:
      5). This parameter applies to overlaps on the reference and the read. Example:
      Deletions are detected from two subsequent segments of a split read that are
      mapped far apart from each other on the reference. The segment overlap tolerance
      determines the maximum tolerated length of an overlap between both segments
      on the read. If the overlap between the two segments on the read is larger than
      this value, no deletion is called.'
    default: 5
    inputBinding:
      position: 104
      prefix: --segment_overlap_tolerance
  - id: skip_consensus
    type:
      - 'null'
      - boolean
    doc: 'Disable consensus computation for insertions (default: False). This reduces
      the time and memory consumption of SVIM and might be useful if consensus sequences
      are not needed. With this option, insertion calls are represented by symbolic
      alleles (<INS>) instead of sequence alles in the output VCF. Consensus computation
      requires a modern CPU with the SSE 4.1 instruction set. For older CPUs missing
      this instruction set, consensus computation is automatically disabled.'
    default: false
    inputBinding:
      position: 104
      prefix: --skip_consensus
  - id: skip_genotyping
    type:
      - 'null'
      - boolean
    doc: 'Disable genotyping (default: False)'
    default: false
    inputBinding:
      position: 104
      prefix: --skip_genotyping
  - id: symbolic_alleles
    type:
      - 'null'
      - boolean
    doc: 'Use symbolic alleles, such as <DEL> or <INV> in output VCF (default: False).
      By default, all SV alleles are represented by nucleotide sequences.'
    default: false
    inputBinding:
      position: 104
      prefix: --symbolic_alleles
  - id: tandem_duplications_as_insertions
    type:
      - 'null'
      - boolean
    doc: 'Represent tandem duplications as insertions in output VCF (default: False).
      By default, tandem duplications are represented by the SVTYPE=DUP:TANDEM and
      the genomic source is given by the POS and END tags. When enabling this option,
      duplications are instead represented by the SVTYPE=INS and POS and END both
      give the insertion point of the duplication.'
    default: false
    inputBinding:
      position: 104
      prefix: --tandem_duplications_as_insertions
  - id: trans_sv_max_distance
    type:
      - 'null'
      - int
    doc: 'Maximum distance in bp between a translocation breakpoint and an SV signature
      to be combined (default: 500)'
    default: 500
    inputBinding:
      position: 104
      prefix: --trans_sv_max_distance
  - id: types
    type:
      - 'null'
      - string
    doc: 'SV types to include in output VCF (default: DEL,INS,INV,DUP:TANDEM,DUP:INT,BND).
      Give a comma-separated list of SV types. The possible SV types are: DEL (deletions),
      INS (novel insertions), INV (inversions), DUP:TANDEM (tandem duplications),
      DUP:INT (interspersed duplications), BND (breakends).'
    default: DEL,INS,INV,DUP:TANDEM,DUP:INT,BND
    inputBinding:
      position: 104
      prefix: --types
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Enable more verbose logging (default: False)'
    default: false
    inputBinding:
      position: 104
      prefix: --verbose
  - id: zmws
    type:
      - 'null'
      - boolean
    doc: 'look for information on ZMWs in PacBio read names (default: False). If enabled,
      the INFO/ZMWS tag contains the number of ZMWs that produced supporting reads.'
    default: false
    inputBinding:
      position: 104
      prefix: --zmws
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svim:2.0.0--pyhdfd78af_0
stdout: svim_reads.out
