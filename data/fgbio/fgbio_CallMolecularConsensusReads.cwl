cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_CallMolecularConsensusReads
doc: "Calls consensus sequences from reads with the same unique molecular tag.\n\n\
  Reads with the same unique molecular tag are examined base-by-base to assess the\
  \ likelihood of each base in the source molecule. The likelihood model is as follows:\n\
  \n  1. First, the base qualities are adjusted. The base qualities are assumed to\
  \ represent the probability of a\n     sequencing error (i.e. the sequencer observed\
  \ the wrong base present on the cluster/flowcell/well). The base quality\n     scores\
  \ are converted to probabilities incorporating a probability representing the chance\
  \ of an error from the time\n     the unique molecular tags were integrated to just\
  \ prior to sequencing. The resulting probability is the error rate of\n     all\
  \ processes from right after integrating the molecular tag through to the end of\
  \ sequencing.\n  2. Next, a consensus sequence is called for all reads with the\
  \ same unique molecular tag base-by-base. For a given\n     base position in the\
  \ reads, the likelihoods that an A, C, G, or T is the base for the underlying source\
  \ molecule\n     respectively are computed by multiplying the likelihood of each\
  \ read observing the base position being considered.\n     The probability of error\
  \ (from 1.) is used when the observed base does not match the hypothesized base\
  \ for the\n     underlying source molecule, while one minus that probability is\
  \ used otherwise. The computed likelihoods are\n     normalized by dividing them\
  \ by the sum of all four likelihoods to produce a posterior probability, namely\
  \ the\n     probability that the source molecule was an A, C, G, or T from just\
  \ after integrating molecular tag through to\n     sequencing, given the observations.\
  \ The base with the maximum posterior probability as the consensus call, and the\n\
  \     posterior probability is used as its raw base quality.\n  3. Finally, the\
  \ consensus raw base quality is modified by incorporating the probability of an\
  \ error prior to\n     integrating the unique molecular tags. Therefore, the probability\
  \ used for the final consensus base quality is the\n     posterior probability of\
  \ the source molecule having the consensus base given the observed reads with the\
  \ same\n     molecular tag, all the way from sample extraction and through sample\
  \ and library preparation, through preparing the\n     library for sequencing (e.g.\
  \ amplification, target selection), and finally, through sequencing.\n\nThis tool\
  \ assumes that reads with the same tag are grouped together (consecutive in the\
  \ file). Also, this tool calls each end of a pair independently, and does not jointly\
  \ call bases that overlap within a pair. Insertion or deletion errors in the reads\
  \ are not considered in the consensus model.\n\nThe consensus reads produced are\
  \ unaligned, due to the difficulty and error-prone nature of inferring the conesensus\
  \ alignment. Consensus reads should therefore be aligned after, which should not\
  \ be too expensive as likely there are far fewer consensus reads than input raw\
  \ raws. Please see how best to use this tool within the best-practice pipeline:\
  \ https://github.com/fulcrumgenomics/fgbio/blob/main/docs/best-practice-consensus-pipeline.md\n\
  \nParticular attention should be paid to setting the '--min-reads' parameter as\
  \ this can have a dramatic effect on both results and runtime. For libraries with\
  \ low duplication rates (e.g. 100-300X exomes libraries) in which it is desirable\
  \ to retain singleton reads while making consensus reads from sets of duplicates,\
  \ '--min-reads=1' is appropriate. For libraries with high duplication rates where\
  \ it is desirable to only produce consensus reads supported by 2+ reads to allow\
  \ error correction, '--min-reads=2' or higher is appropriate. After generation,\
  \ consensus reads can be further filtered using the FilterConsensusReads tool. As\
  \ such it is always safe to run with '--min-reads=1' and filter later, but filtering\
  \ at this step can improve performance significantly.\n\nConsensus reads have a\
  \ number of additional optional tags set in the resulting BAM file. The tags break\
  \ down into those that are single-valued per read:\n\n  consensus depth      [cD]\
  \ (int)  : the maximum depth of raw reads at any point in the consensus read\n \
  \ consensus min depth  [cM] (int)  : the minimum depth of raw reads at any point\
  \ in the consensus read\n  consensus error rate [cE] (float): the fraction of bases\
  \ in raw reads disagreeing with the final consensus calls\n\nAnd those that have\
  \ a value per base:\n\n  consensus depth  [cd] (short[]): the count of bases contributing\
  \ to the consensus read at each position\n  consensus errors [ce] (short[]): the\
  \ number of bases from raw reads disagreeing with the final consensus base\n\nThe\
  \ per base depths and errors are both capped at 32,767. In all cases no-calls ('N's)\
  \ and bases below the '--min-input-base-quality' are not counted in tag value calculations.\n\
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: cell_tag
    type:
      - 'null'
      - string
    doc: Tag containing the cellular barcodes.
    inputBinding:
      position: 101
      prefix: --cell-tag
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: consensus_call_overlapping_bases
    type:
      - 'null'
      - boolean
    doc: Consensus call overlapping bases in mapped paired end reads
    inputBinding:
      position: 101
      prefix: --consensus-call-overlapping-bases
      separate: false
      valueFrom: $("=" + self)
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debug logging.
    inputBinding:
      position: 101
      prefix: --debug
  - id: error_rate_post_umi
    type:
      - 'null'
      - int
    doc: The Phred-scaled error rate for an error post the UMIs have been integrated.
    inputBinding:
      position: 101
      prefix: --error-rate-post-umi
  - id: error_rate_pre_umi
    type:
      - 'null'
      - int
    doc: The Phred-scaled error rate for an error prior to the UMIs being integrated.
    inputBinding:
      position: 101
      prefix: --error-rate-pre-umi
  - id: input_bam
    type: File
    doc: The input SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: max_reads
    type:
      - 'null'
      - int
    doc: The maximum number of reads to use when building a consensus. If more than
      this many reads are present in a tag family, the family is randomly downsampled
      to exactly max-reads reads.
    inputBinding:
      position: 101
      prefix: --max-reads
  - id: min_input_base_quality
    type:
      - 'null'
      - int
    doc: Ignore bases in raw reads that have Q below this value.
    inputBinding:
      position: 101
      prefix: --min-input-base-quality
  - id: min_reads
    type: int
    doc: The minimum number of reads to produce a consensus base.
    inputBinding:
      position: 101
      prefix: --min-reads
  - id: output_bam
    type: string
    doc: Output SAM or BAM file to write consensus reads.
    inputBinding:
      position: 101
      prefix: --output
  - id: output_per_base_tags
    type:
      - 'null'
      - boolean
    doc: If true produce tags on consensus reads that contain per-base information.
    inputBinding:
      position: 101
      prefix: --output-per-base-tags
      separate: false
      valueFrom: $("=" + self)
  - id: read_group_id
    type:
      - 'null'
      - string
    doc: The new read group ID for all the consensus reads.
    inputBinding:
      position: 101
      prefix: --read-group-id
  - id: read_name_prefix
    type:
      - 'null'
      - string
    doc: The Prefix all consensus read names
    inputBinding:
      position: 101
      prefix: --read-name-prefix
  - id: rejects_bam
    type:
      - 'null'
      - string
    doc: Optional output SAM or BAM file to write reads not used.
    inputBinding:
      position: 101
      prefix: --rejects
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'The sort order of the output, the same as the input if not given. Options:
      Coordinate, Queryname, Random, RandomQuery, TemplateCoordinate, Unsorted, Unknown.'
    inputBinding:
      position: 101
      prefix: --sort-order
  - id: stats
    type:
      - 'null'
      - string
    doc: Optional output text file of key consensus calling statistics.
    inputBinding:
      position: 101
      prefix: --stats
  - id: tag
    type:
      - 'null'
      - string
    doc: The SAM attribute with the unique molecule tag.
    inputBinding:
      position: 101
      prefix: --tag
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use while consensus calling.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
arguments:
  - position: 50
    valueFrom: CallMolecularConsensusReads
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM file to write consensus reads.
    outputBinding:
      glob: $(inputs.output_bam)
  - id: rejects_bam_out
    type:
      - 'null'
      - File
    doc: Optional output SAM or BAM file to write reads not used.
    outputBinding:
      glob: $(inputs.rejects_bam)
  - id: stats_out
    type:
      - 'null'
      - File
    doc: Optional output text file of key consensus calling statistics.
    outputBinding:
      glob: $(inputs.stats)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
