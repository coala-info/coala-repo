cwlVersion: v1.2
class: CommandLineTool
baseCommand: rastair per-read
label: rastair_per-read
doc: "Call methylation per-read\nThis will produce a bed file that list the methylation
  status of all CpGs in every read that overlaps a CpG, plus some other metadata\n\
  \nTool homepage: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/"
inputs:
  - id: bam_file
    type: File
    doc: Path to sorted and indexed BAM file
    inputBinding:
      position: 1
  - id: all_reads
    type:
      - 'null'
      - boolean
    doc: Report reads with no CpGs in them
    inputBinding:
      position: 102
      prefix: --all-reads
  - id: bed_format
    type:
      - 'null'
      - string
    doc: "Format of the output BED reads file\nIf not specified, the format is guessed
      based on the file extension.\nPossible values:\n- bed-gz: BGZIP compressed file,
      usually `.bed.gz`\n- bed:    Regular BED file, usually `.bed`"
    inputBinding:
      position: 102
      prefix: --bed-format
  - id: calls
    type:
      - 'null'
      - File
    doc: BED file Rastair wrote with methylation calls per position
    inputBinding:
      position: 102
      prefix: --calls
  - id: count_clipped
    type:
      - 'null'
      - boolean
    doc: "Count clipped positions\nBy default, rastair ignores the leading (soft and
      hard) clipped positions in the \"positions in read\" columns. The indices written
      can be seen as \"position in read relative to the first base actually aligned\"\
      .\nIf `--count-clipped` is set, clipped positions will instead be counted. The
      indices written then match the sequence of the read."
    inputBinding:
      position: 102
      prefix: --count-clipped
  - id: exclude_ambiguous
    type:
      - 'null'
      - boolean
    doc: Exclude reads where the orientation cannot be unambiguously determined
    inputBinding:
      position: 102
      prefix: --exclude-ambiguous
  - id: exclude_flags
    type:
      - 'null'
      - int
    doc: Exclude reads that match any of these bit-flags
    default: 3852
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
    default: 3
    inputBinding:
      position: 102
      prefix: --include-flags
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: expected maximum read length. If set too short, some read positions 
      might not get counted. Safest to set this a bit higher than the actual 
      read length, to allow for indels in reads
    default: 200
    inputBinding:
      position: 102
      prefix: --max-read-length
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality per aligned read
    default: 1
    inputBinding:
      position: 102
      prefix: --min-mapq
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
    doc: "Maximum length of a segment in bases\nUsed for splitting work between threads.
      Tweak this to adjust memory usage."
    default: 100000
    inputBinding:
      position: 102
      prefix: --segment-max-length
  - id: segment_overlap
    type:
      - 'null'
      - int
    doc: "Number of bases to overlap between segments\nHelpful to avoid missing variants
      at the edges of segments."
    default: 500
    inputBinding:
      position: 102
      prefix: --segment-overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for processing the BAM file. Will use all available
      threads when not specified.\nNote that VCF writing might use additional threads
      internally for compression. This can be overwritten with `--vcf-threads`."
    default: 20
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable more logging\nYou can also use the `RASTAIR_LOG` environment variable
      to configure logging in a more precise way. See the documentation of the `tracing-subscriber`
      library to learn more."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: bed
    type:
      - 'null'
      - File
    doc: Output BED file with all reads
    outputBinding:
      glob: $(inputs.bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
