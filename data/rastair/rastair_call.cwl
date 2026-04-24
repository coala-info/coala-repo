cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rastair
  - call
label: rastair_call
doc: "Call methylated positions\n\nProcess TAPS-sequenced BAM files and call methylated
  positions.\n\nTool homepage: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/"
inputs:
  - id: bam_file
    type: File
    doc: Path to sorted and indexed BAM file
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: "Output all positions, even if they do not pass filters.\n\nIf combined with
      `--cpgs-only`, only CpG positions will be reported, including non-passing de-novo
      CpGs, and those without coverage."
    inputBinding:
      position: 102
      prefix: --all
  - id: bed_format
    type:
      - 'null'
      - string
    doc: "Format of the output BED file\n\nIf not specified, the format is guessed
      based on the file extension.\n\nPossible values:\n- bed-gz: BGZIP compressed
      file, usually `.bed.gz`\n- bed:    Regular BED file, usually `.bed`"
    inputBinding:
      position: 102
      prefix: --bed-format
  - id: bed_include_empty
    type:
      - 'null'
      - boolean
    doc: "Include CpG positions with zero coverage\n\nThis can be useful to get a
      complete list of CpG positions in the output BED file. Note that this requires
      the input data to contain a complete list of CpG positions, e.g. by using the
      `--cpgs-only` option when calling methylation."
    inputBinding:
      position: 102
      prefix: --bed-include-empty
  - id: cpg_novo_min_baseq
    type:
      - 'null'
      - int
    doc: Minimum base quality for de-novo CpGs
    inputBinding:
      position: 102
      prefix: --cpg-novo-min-baseq
  - id: cpg_novo_min_depth
    type:
      - 'null'
      - int
    doc: Minimum reads needed in support of de-novo CpG
    inputBinding:
      position: 102
      prefix: --cpg-novo-min-depth
  - id: cpg_novo_min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for de-novo CpGs
    inputBinding:
      position: 102
      prefix: --cpg-novo-min-mapq
  - id: cpg_novo_min_vaf
    type:
      - 'null'
      - float
    doc: Minimum variant allele frequency for de-novo CpGs
    inputBinding:
      position: 102
      prefix: --cpg-novo-min-vaf
  - id: cpgs_only
    type:
      - 'null'
      - boolean
    doc: "Report CpGs only and default to BED output\n\nOnly report positions that
      are CpGs in the reference or variants that would result in a de-novo CpG.\n\n\
      If combined with `--all`, non-passing de-novo CpG positions and CpGs in the
      reference but without coverage in the sample will also be reported."
    inputBinding:
      position: 102
      prefix: --cpgs-only
  - id: error_model
    type:
      - 'null'
      - string
    doc: "The error model to use\n\nAccepts platform names or a custom error rate
      (e.g., 0.005)\n\nPossible values:\n- miseq:       MiSeq <https://support.illumina.com/sequencing/sequencing_instruments/miseq.html>\n\
      - miniseq:     MiniSeq <https://support.illumina.com/sequencing/sequencing_instruments/miniseq.html>\n\
      - nextseq500:  NextSeq500 <https://support.illumina.com/sequencing/sequencing_instruments/nextseq-500.html>\n\
      - nextseq550:  NextSeq550 <https://support.illumina.com/sequencing/sequencing_instruments/nextseq-550.html>\n\
      - hiseq2500:   HiSeq2500 <https://support.illumina.com/sequencing/sequencing_instruments/hiseq_2500.html>\n\
      - novaseq6000: NovaSeq6000 <https://support.illumina.com/sequencing/sequencing_instruments/novaseq-6000.html>\n\
      - hiseqxten:   HiSeq X Ten <https://support.illumina.com/sequencing/sequencing_instruments/hiseq-x.html>"
    inputBinding:
      position: 102
      prefix: --error-model
  - id: exclude_flags
    type:
      - 'null'
      - int
    doc: Exclude reads that match any of these bit-flags
    inputBinding:
      position: 102
      prefix: --exclude-flags
  - id: fasta_file
    type: File
    doc: Path to sorted and indexed (via samtools faidx) FASTA file. Can be 
      bgzip compressed, but requires both a gzi index and a fai index
    inputBinding:
      position: 102
      prefix: --fasta-file
  - id: include_flags
    type:
      - 'null'
      - int
    doc: Include reads that match all of these bit-flags
    inputBinding:
      position: 102
      prefix: --include-flags
  - id: keep_overlapping_reads
    type:
      - 'null'
      - boolean
    doc: Whether to keep overlapping reads
    inputBinding:
      position: 102
      prefix: --keep-overlapping-reads
  - id: m_bq_ratio_min
    type:
      - 'null'
      - float
    doc: The minimum quality ratio `(ad_alt*bq_alt + 1) / (ad_ref*bq_ref + 1)`
    inputBinding:
      position: 102
      prefix: --m-bq-ratio-min
  - id: m_max_coverage
    type:
      - 'null'
      - int
    doc: The maximum coverage depth for methylation calling
    inputBinding:
      position: 102
      prefix: --m-max-coverage
  - id: m_min_depth
    type:
      - 'null'
      - int
    doc: The minimum number of reads to call a position as methylated
    inputBinding:
      position: 102
      prefix: --m-min-depth
  - id: m_read_position_max
    type:
      - 'null'
      - float
    doc: The maximum relative position in read for alt allele evidence
    inputBinding:
      position: 102
      prefix: --m-read-position-max
  - id: m_read_position_min
    type:
      - 'null'
      - float
    doc: The minimum relative position in read for alt allele evidence
    inputBinding:
      position: 102
      prefix: --m-read-position-min
  - id: m_vaf_min
    type:
      - 'null'
      - float
    doc: The minimum variant allele frequency
    inputBinding:
      position: 102
      prefix: --m-vaf-min
  - id: max_coverage
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --max-coverage
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider a base
    inputBinding:
      position: 102
      prefix: --min-baseq
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: ml
    type:
      - 'null'
      - float
    doc: "Use machine learning model with this threshold value to call variants and
      methylation events\n\nWhen specified, a ML model will classify positions with
      a prediction score. Anything above this threshold is considered PASS.\n\nFor
      consistency with `--no-ml`, this option can be also be specified as `--ml` without
      a value, which will use the default threshold."
    inputBinding:
      position: 102
      prefix: --ml
  - id: model
    type:
      - 'null'
      - File
    doc: "Path to the combined model file containing CpG, denovo, and others models\n\
      \nDefault is the bundled model in the Rastair binary."
    inputBinding:
      position: 102
      prefix: --model
  - id: n_ob
    type:
      - 'null'
      - string
    doc: "For OB reads, exclude `[r1_start, r1_end, r2_start, r2_end]` bases from
      counting.\n\nThe coordinates are relative to the read, so start is the distance
      from the 5' of the read, the end is the distance to the 3', irrespective of
      which way around the read aligns to the reference.\n\nAlso note that the distance
      is relative to read length, not alignment length, so soft-clipped bases count,
      too!"
    inputBinding:
      position: 102
      prefix: --nOB
  - id: n_ot
    type:
      - 'null'
      - string
    doc: "For OT reads, exclude `[r1_start, r1_end, r2_start, r2_end]` bases from
      counting.\n\nThe coordinates are relative to the read, so start is the distance
      from the 5' of the read, the end is the distance to the 3', irrespective of
      which way around the read aligns to the reference.\n\nAlso note that the distance
      is relative to read length, not alignment length, so soft-clipped bases count,
      too!"
    inputBinding:
      position: 102
      prefix: --nOT
  - id: no_ml
    type:
      - 'null'
      - boolean
    doc: "Only use hard thresholds to call variants and methylation events.\n\nThis
      disables using the machine learning models. This will make rastair much faster,
      but at the cost of accuracy."
    inputBinding:
      position: 102
      prefix: --no-ml
  - id: region
    type:
      - 'null'
      - string
    doc: Restrict to a specific chromosome or region of a chromosome. Format is 
      "chr", "chr:start" or "chr:start-end", where start is 1-based and end is 
      inclusive
    inputBinding:
      position: 102
      prefix: --region
  - id: segment_max_length
    type:
      - 'null'
      - int
    doc: "Maximum length of a segment in bases\n\nUsed for splitting work between
      threads. Tweak this to adjust memory usage."
    inputBinding:
      position: 102
      prefix: --segment-max-length
  - id: segment_overlap
    type:
      - 'null'
      - int
    doc: "Number of bases to overlap between segments\n\nHelpful to avoid missing
      variants at the edges of segments."
    inputBinding:
      position: 102
      prefix: --segment-overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for processing the BAM file. Will use all available
      threads when not specified.\n\nNote that VCF writing might use additional threads
      internally for compression. This can be overwritten with `--vcf-threads`."
    inputBinding:
      position: 102
      prefix: --threads
  - id: v_min_depth
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --v-min-depth
  - id: vcf_format_fields
    type:
      - 'null'
      - string
    doc: "Additional FORMAT fields to include in VCF output (comma-separated VCF field
      IDs)\n\nBy default, only a minimal set is included.\n\n[possible values: GT,
      GL, GC, DP, M5mC, ML]"
    inputBinding:
      position: 102
      prefix: --vcf-format-fields
  - id: vcf_info_fields
    type:
      - 'null'
      - string
    doc: "Additional INFO fields to include in VCF output (comma-separated VCF field
      IDs)\n\nBy default, only a minimal set is included.\n\n[possible values: AD,
      BQ, DP, MQ, MQ0, NS, AS_SB, SC5, AF, ABQ, AMQ, AS_SS_BQ, AS_SS_MQ, PIR, ENT100,
      NAB, NOI, M5mC_Strands, CPG, CPGnovo]"
    inputBinding:
      position: 102
      prefix: --vcf-info-fields
  - id: vcf_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for writing (and compressing) VCF files\n\nThis
      is subtracted from `--threads` but never below 1. Adjust this if you think that
      VCF writing is a bottleneck, e.g. when the output files contain a lot of positions."
    inputBinding:
      position: 102
      prefix: --vcf-threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable more logging\n\nYou can also use the `RASTAIR_LOG` environment variable
      to configure logging in a more precise way. See the documentation of the `tracing-subscriber`
      library to learn more."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: vcf
    type:
      - 'null'
      - File
    doc: "VCF/BCF output file path (use - to write to stdout)\n\nFormat is guessed
      based on the file extension: `.vcf` for VCF (uncompressed), `.vcf.gz` for VCF
      (compressed), `.bcf` for BCF (compressed) `.mpk.lz4` for internal format (Message
      Pack, LZ4-compressed)"
    outputBinding:
      glob: $(inputs.vcf)
  - id: bed
    type:
      - 'null'
      - File
    doc: Output BED file with the called methylated positions
    outputBinding:
      glob: $(inputs.bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
