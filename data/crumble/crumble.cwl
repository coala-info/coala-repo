cwlVersion: v1.2
class: CommandLineTool
baseCommand: crumble
label: crumble
doc: "Lossy quality score compression for SAM/BAM/CRAM files by quantising quality
  values based on consensus agreement.\n\nTool homepage: https://github.com/jkbonfield/crumble"
inputs:
  - id: input_file
    type: File
    doc: Input SAM/BAM/CRAM file
    inputBinding:
      position: 1
  - id: bd_qual_cutoff
    type:
      - 'null'
      - int
    doc: 'Quantise BD:Z: tags to two values; cutoff'
    inputBinding:
      position: 102
      prefix: -f
  - id: bd_qual_lower
    type:
      - 'null'
      - int
    doc: 'BD:Z: lower replacement value'
    inputBinding:
      position: 102
      prefix: -e
  - id: bd_qual_upper
    type:
      - 'null'
      - int
    doc: 'BD:Z: upper replacement value'
    inputBinding:
      position: 102
      prefix: -g
  - id: bi_qual_cutoff
    type:
      - 'null'
      - int
    doc: 'Quantise BI:Z: tags to two values; cutoff'
    inputBinding:
      position: 102
      prefix: -F
  - id: bi_qual_lower
    type:
      - 'null'
      - int
    doc: 'BI:Z: lower replacement value'
    inputBinding:
      position: 102
      prefix: -E
  - id: bi_qual_upper
    type:
      - 'null'
      - int
    doc: 'BI:Z: upper replacement value'
    inputBinding:
      position: 102
      prefix: -G
  - id: compression_level
    type:
      - 'null'
      - boolean
    doc: Combination of options for compression level (can be -1, -3, -5, -7, -8,
      -9)
    inputBinding:
      position: 102
      prefix: '-9'
  - id: depth_ratio_keep
    type:
      - 'null'
      - float
    doc: Keep qual if local depth >= X times deeper than expected
    inputBinding:
      position: 102
      prefix: -P
  - id: indel_adj
    type:
      - 'null'
      - string
    doc: Adjust indel size by (STR_size+add)*mul
    inputBinding:
      position: 102
      prefix: -i
  - id: indel_dist_fraction
    type:
      - 'null'
      - float
    doc: Keep if >= X indel sizes do not fit bi-modal dist
    inputBinding:
      position: 102
      prefix: -Z
  - id: indel_trigger_fraction
    type:
      - 'null'
      - float
    doc: Fraction of reads with indel to trigger STR analysis
    inputBinding:
      position: 102
      prefix: -Y
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format and format-options
    inputBinding:
      position: 102
      prefix: -I
  - id: keep_bed
    type:
      - 'null'
      - File
    doc: Keep quality in regions contained in the supplied bed
    inputBinding:
      position: 102
      prefix: -R
  - id: low_mqual_fraction
    type:
      - 'null'
      - float
    doc: Keep if >= X reads have low mapping quality
    inputBinding:
      position: 102
      prefix: -M
  - id: lower_mismatch_quals
    type:
      - 'null'
      - int
    doc: Whether mismatching bases can have qualities lowered (bool 0/1)
    inputBinding:
      position: 102
      prefix: -L
  - id: machine_type
    type:
      - 'null'
      - string
    doc: Standard options application to machine type (illumina, pbccs)
    inputBinding:
      position: 102
      prefix: -y
  - id: min_discrepancy_score
    type:
      - 'null'
      - float
    doc: Minimum discrepancy score (ignoring mapping quality)
    inputBinding:
      position: 102
      prefix: -x
  - id: min_discrepancy_score_mqual
    type:
      - 'null'
      - float
    doc: Minimum discrepancy score (with mapping quality)
    inputBinding:
      position: 102
      prefix: -X
  - id: min_indel_confidence
    type:
      - 'null'
      - int
    doc: Minimum indel call confidence (ignoring mapping quality)
    inputBinding:
      position: 102
      prefix: -d
  - id: min_indel_confidence_mqual
    type:
      - 'null'
      - int
    doc: Minimum indel call confidence (with mapping quality)
    inputBinding:
      position: 102
      prefix: -D
  - id: min_mqual
    type:
      - 'null'
      - int
    doc: Keep qualities for seqs with mapping quality <= mqual
    inputBinding:
      position: 102
      prefix: -m
  - id: min_snp_confidence
    type:
      - 'null'
      - int
    doc: Minimum snp call confidence (ignoring mapping quality)
    inputBinding:
      position: 102
      prefix: -q
  - id: min_snp_confidence_mqual
    type:
      - 'null'
      - int
    doc: Minimum snp call confidence (with mapping quality)
    inputBinding:
      position: 102
      prefix: -Q
  - id: no_pg_header
    type:
      - 'null'
      - boolean
    doc: Do not add an @PG SAM header line
    inputBinding:
      position: 102
      prefix: -z
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format and format-options
    inputBinding:
      position: 102
      prefix: -O
  - id: p_block_algorithm
    type:
      - 'null'
      - int
    doc: P-block algorithm; quality values +/- 'int'
    inputBinding:
      position: 102
      prefix: -p
  - id: preserve_qual_always
    type:
      - 'null'
      - int
    doc: Preserve quality value regardless of diffs
    inputBinding:
      position: 102
      prefix: -K
  - id: preserve_qual_diffs
    type:
      - 'null'
      - int
    doc: Preserve quality value if any diffs present
    inputBinding:
      position: 102
      prefix: -k
  - id: qual_cutoff
    type:
      - 'null'
      - int
    doc: In highly confident regions, quality values above/below this are quantised
    inputBinding:
      position: 102
      prefix: -c
  - id: qual_lower
    type:
      - 'null'
      - int
    doc: Lower quantisation value
    inputBinding:
      position: 102
      prefix: -l
  - id: qual_max
    type:
      - 'null'
      - int
    doc: The maximum quality cap used in all bases
    inputBinding:
      position: 102
      prefix: -U
  - id: qual_upper
    type:
      - 'null'
      - int
    doc: Upper quantisation value
    inputBinding:
      position: 102
      prefix: -u
  - id: quantise_soft_clips
    type:
      - 'null'
      - boolean
    doc: Quantise qualities (with -[clu] options) in soft-clips too
    inputBinding:
      position: 102
      prefix: -S
  - id: region
    type:
      - 'null'
      - string
    doc: Limit input to region chr:pos(-pos)
    inputBinding:
      position: 102
      prefix: -r
  - id: replace_quals_with_low_high
    type:
      - 'null'
      - boolean
    doc: If set, replace quals in good regions with low/high
    inputBinding:
      position: 102
      prefix: -B
  - id: snp_adj
    type:
      - 'null'
      - string
    doc: Adjust SNP size by (STR_size+add)*mul
    inputBinding:
      position: 102
      prefix: -s
  - id: soft_clip_fraction
    type:
      - 'null'
      - float
    doc: Keep if >= X reads have soft-clipping
    inputBinding:
      position: 102
      prefix: -C
  - id: span_indel_fraction
    type:
      - 'null'
      - float
    doc: Keep if < X reads span indel
    inputBinding:
      position: 102
      prefix: -V
  - id: store_entire_column
    type:
      - 'null'
      - boolean
    doc: Store entire column when preserved qualities are present
    inputBinding:
      position: 102
      prefix: -N
  - id: tags_discard
    type:
      - 'null'
      - string
    doc: Comma separated list of aux tags to discard
    inputBinding:
      position: 102
      prefix: -T
  - id: tags_keep
    type:
      - 'null'
      - string
    doc: Comma separated list of aux tags to keep
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output SAM/BAM/CRAM file
    outputBinding:
      glob: '*.out'
  - id: output_bed
    type:
      - 'null'
      - File
    doc: Output suspicious regions to out.bed
    outputBinding:
      glob: $(inputs.output_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crumble:0.9.1--h577a1d6_4
