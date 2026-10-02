cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - ampliconclip
label: samtools_ampliconclip
doc: Soft clips read alignments where they match BED file defined regions. 
  Default clipping is only on the 5' end.
inputs:
  - id: input_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file of regions (eg amplicon primers) to be removed.
    inputBinding:
      position: 102
      prefix: -b
  - id: output_file
    type:
      - 'null'
      - string
    doc: 'output file name (default: stdout).'
    inputBinding:
      position: 102
      prefix: -o
  - id: stats_file
    type:
      - 'null'
      - string
    doc: 'write stats to file name (default: stderr)'
    inputBinding:
      position: 102
      prefix: -f
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Output uncompressed data
    inputBinding:
      position: 102
      prefix: -u
  - id: soft_clip
    type:
      - 'null'
      - boolean
    doc: soft clip amplicon primers from reads (default)
    inputBinding:
      position: 102
      prefix: --soft-clip
  - id: hard_clip
    type:
      - 'null'
      - boolean
    doc: hard clip amplicon primers from reads.
    inputBinding:
      position: 102
      prefix: --hard-clip
  - id: both_ends
    type:
      - 'null'
      - boolean
    doc: clip on both 5' and 3' ends.
    inputBinding:
      position: 102
      prefix: --both-ends
  - id: strand
    type:
      - 'null'
      - boolean
    doc: use strand data from BED file to match read direction.
    inputBinding:
      position: 102
      prefix: --strand
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
  - id: filter_len
    type:
      - 'null'
      - int
    doc: do not output reads INT size or shorter.
    inputBinding:
      position: 102
      prefix: --filter-len
  - id: fail_len
    type:
      - 'null'
      - int
    doc: mark as QCFAIL reads INT size or shorter.
    inputBinding:
      position: 102
      prefix: --fail-len
  - id: unmap_len
    type:
      - 'null'
      - int
    doc: unmap reads INT size or shorter, default 0.
    inputBinding:
      position: 102
      prefix: --unmap-len
  - id: no_excluded
    type:
      - 'null'
      - boolean
    doc: do not write excluded reads (unmapped or QCFAIL).
    inputBinding:
      position: 102
      prefix: --no-excluded
  - id: rejects_file
    type:
      - 'null'
      - string
    doc: file to write filtered reads.
    inputBinding:
      position: 102
      prefix: --rejects-file
  - id: primer_counts
    type:
      - 'null'
      - string
    doc: file to write read counts per bed entry (bedgraph format).
    inputBinding:
      position: 102
      prefix: --primer-counts
  - id: original
    type:
      - 'null'
      - boolean
    doc: for clipped entries add an OA tag with original data.
    inputBinding:
      position: 102
      prefix: --original
  - id: keep_tag
    type:
      - 'null'
      - boolean
    doc: for clipped entries keep the old NM and MD tags.
    inputBinding:
      position: 102
      prefix: --keep-tag
  - id: tolerance
    type:
      - 'null'
      - int
    doc: match region within this number of bases, default 5.
    inputBinding:
      position: 102
      prefix: --tolerance
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add an @PG line.
    inputBinding:
      position: 102
      prefix: --no-PG
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
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
      - string
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
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use [0]
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: 'output file name (default: stdout).'
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_stats_file
    type:
      - 'null'
      - File
    doc: 'write stats to file name (default: stderr)'
    outputBinding:
      glob: $(inputs.stats_file)
  - id: output_rejects_file
    type:
      - 'null'
      - File
    doc: file to write filtered reads.
    outputBinding:
      glob: $(inputs.rejects_file)
  - id: output_primer_counts
    type:
      - 'null'
      - File
    doc: file to write read counts per bed entry (bedgraph format).
    outputBinding:
      glob: $(inputs.primer_counts)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
