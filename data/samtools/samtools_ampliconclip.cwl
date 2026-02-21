cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - ampliconclip
label: samtools_ampliconclip
doc: "Soft clips read alignments where they match BED file defined regions. Default
  clipping is only on the 5' end.\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: BED file of regions (eg amplicon primers) to be removed.
    inputBinding:
      position: 102
      prefix: -b
  - id: both_ends
    type:
      - 'null'
      - boolean
    doc: clip on both 5' and 3' ends.
    inputBinding:
      position: 102
      prefix: --both-ends
  - id: clipped
    type:
      - 'null'
      - boolean
    doc: only output clipped reads.
    inputBinding:
      position: 102
      prefix: --clipped
  - id: fail
    type:
      - 'null'
      - boolean
    doc: mark unclipped, mapped reads as QCFAIL.
    inputBinding:
      position: 102
      prefix: --fail
  - id: fail_len
    type:
      - 'null'
      - int
    doc: mark as QCFAIL reads INT size or shorter.
    inputBinding:
      position: 102
      prefix: --fail-len
  - id: filter_len
    type:
      - 'null'
      - int
    doc: do not output reads INT size or shorter.
    inputBinding:
      position: 102
      prefix: --filter-len
  - id: hard_clip
    type:
      - 'null'
      - boolean
    doc: hard clip amplicon primers from reads.
    inputBinding:
      position: 102
      prefix: --hard-clip
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: keep_tag
    type:
      - 'null'
      - boolean
    doc: for clipped entries keep the old NM and MD tags.
    inputBinding:
      position: 102
      prefix: --keep-tag
  - id: no_excluded
    type:
      - 'null'
      - boolean
    doc: do not write excluded reads (unmapped or QCFAIL).
    inputBinding:
      position: 102
      prefix: --no-excluded
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add an @PG line.
    inputBinding:
      position: 102
      prefix: --no-PG
  - id: original
    type:
      - 'null'
      - boolean
    doc: for clipped entries add an OA tag with original data.
    inputBinding:
      position: 102
      prefix: --original
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Specify output format (SAM, BAM, CRAM)
    inputBinding:
      position: 102
      prefix: --output-fmt
  - id: output_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single output file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --output-fmt-option
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    inputBinding:
      position: 102
      prefix: --reference
  - id: soft_clip
    type:
      - 'null'
      - boolean
    doc: soft clip amplicon primers from reads (default)
    inputBinding:
      position: 102
      prefix: --soft-clip
  - id: strand
    type:
      - 'null'
      - boolean
    doc: use strand data from BED file to match read direction.
    inputBinding:
      position: 102
      prefix: --strand
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use [0]
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: tolerance
    type:
      - 'null'
      - int
    doc: match region within this number of bases, default 5.
    default: 5
    inputBinding:
      position: 102
      prefix: --tolerance
  - id: uncompressed_output
    type:
      - 'null'
      - boolean
    doc: Output uncompressed data
    inputBinding:
      position: 102
      prefix: -u
  - id: unmap_len
    type:
      - 'null'
      - int
    doc: unmap reads INT size or shorter, default 0.
    default: 0
    inputBinding:
      position: 102
      prefix: --unmap-len
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_file
    type: File
    doc: 'output file name (default: stdout).'
    outputBinding:
      glob: $(inputs.output_file)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: 'write stats to file name (default: stderr)'
    outputBinding:
      glob: $(inputs.stats_file)
  - id: rejects_file
    type:
      - 'null'
      - File
    doc: file to write filtered reads.
    outputBinding:
      glob: $(inputs.rejects_file)
  - id: primer_counts
    type:
      - 'null'
      - File
    doc: file to write read counts per bed entry (bedgraph format).
    outputBinding:
      glob: $(inputs.primer_counts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
