cwlVersion: v1.2
class: CommandLineTool
baseCommand: mosdepth
label: mosdepth
doc: Calculate depth of coverage from BAM or CRAM files
inputs:
  - id: prefix
    type: string
    doc: 'outputs: `{prefix}.mosdepth.global.dist.txt`, `{prefix}.mosdepth.summary.txt`,
      `{prefix}.per-base.bed.gz` (unless -n/--no-per-base is specified), `{prefix}.regions.bed.gz`
      (if --by is specified), `{prefix}.quantized.bed.gz` (if --quantize is specified),
      `{prefix}.thresholds.bed.gz` (if --thresholds is specified)'
    inputBinding:
      position: 1
  - id: bam_or_cram
    type: File
    doc: the alignment file for which to calculate depth.
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: number of BAM decompression threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: chrom
    type:
      - 'null'
      - string
    doc: chromosome to restrict depth calculation.
    inputBinding:
      position: 103
      prefix: --chrom
  - id: by
    type:
      - 'null'
      - string
    doc: optional BED file or (integer) window-sizes.
    inputBinding:
      position: 103
      prefix: --by
  - id: no_per_base
    type:
      - 'null'
      - boolean
    doc: dont output per-base depth. skipping this output will speed execution 
      substantially. prefer quantized or thresholded values if possible.
    inputBinding:
      position: 103
      prefix: --no-per-base
  - id: fasta
    type:
      - 'null'
      - File
    doc: fasta file for use with CRAM files
    inputBinding:
      position: 103
      prefix: --fasta
  - id: flag
    type:
      - 'null'
      - int
    doc: exclude reads with any of the bits in FLAG set
    inputBinding:
      position: 103
      prefix: --flag
  - id: include_flag
    type:
      - 'null'
      - int
    doc: only include reads with any of the bits in FLAG set. default is unset.
    inputBinding:
      position: 103
      prefix: --include-flag
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: dont look at internal cigar operations or correct mate overlaps 
      (recommended for most use-cases).
    inputBinding:
      position: 103
      prefix: --fast-mode
  - id: fragment_mode
    type:
      - 'null'
      - boolean
    doc: count the coverage of the full fragment including the full insert 
      (proper pairs only).
    inputBinding:
      position: 103
      prefix: --fragment-mode
  - id: quantize
    type:
      - 'null'
      - string
    doc: write quantized output see docs for description.
    inputBinding:
      position: 103
      prefix: --quantize
  - id: mapq
    type:
      - 'null'
      - int
    doc: mapping quality threshold. reads with a quality less than this value 
      are ignored
    inputBinding:
      position: 103
      prefix: --mapq
  - id: min_frag_len
    type:
      - 'null'
      - int
    doc: minimum insert size. reads with a smaller insert size than this are 
      ignored
    inputBinding:
      position: 103
      prefix: --min-frag-len
  - id: max_frag_len
    type:
      - 'null'
      - int
    doc: maximum insert size. reads with a larger insert size than this are 
      ignored.
    inputBinding:
      position: 103
      prefix: --max-frag-len
  - id: thresholds
    type:
      - 'null'
      - type: array
        items: int
    doc: for each interval in --by, write number of bases covered by at least 
      threshold bases. Specify multiple integer values separated by ','.
    inputBinding:
      position: 103
      prefix: --thresholds
      itemSeparator: ','
  - id: use_median
    type:
      - 'null'
      - boolean
    doc: output median of each region (in --by) instead of mean.
    inputBinding:
      position: 103
      prefix: --use-median
  - id: read_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: only calculate depth for these comma-separated read groups IDs.
    inputBinding:
      position: 103
      prefix: --read-groups
      itemSeparator: ','
outputs:
  - id: out_prefix
    type: File[]
    doc: 'outputs: `{prefix}.mosdepth.global.dist.txt`, `{prefix}.mosdepth.summary.txt`,
      `{prefix}.per-base.bed.gz` (unless -n/--no-per-base is specified), `{prefix}.regions.bed.gz`
      (if --by is specified), `{prefix}.quantized.bed.gz` (if --quantize is specified),
      `{prefix}.thresholds.bed.gz` (if --thresholds is specified)'
    outputBinding:
      glob: $(inputs.prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosdepth:0.3.12--h0ec343a_0
s:url: https://github.com/brentp/mosdepth
$namespaces:
  s: https://schema.org/
