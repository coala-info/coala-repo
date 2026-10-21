cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- ampliconclip
label: samtools_ampliconclip
doc: 'Clip primer regions (from a BED file) off reads


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input SAM/BAM/CRAM file.
  inputBinding:
    position: 104
- id: bed_file
  type: File
  doc: BED file of regions (e.g. amplicon primers) to be removed.
  inputBinding:
    position: 103
    prefix: -b
- id: output_filename
  type: string
  doc: Output file name (-o).
  default: clipped.bam
  inputBinding:
    position: 103
    prefix: -o
- id: stats_file
  type:
  - 'null'
  - string
  doc: 'Write stats to this file name (default: stderr).'
  inputBinding:
    position: 103
    prefix: -f
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Output uncompressed data.
  inputBinding:
    position: 103
    prefix: -u
- id: soft_clip
  type:
  - 'null'
  - boolean
  doc: Soft clip amplicon primers from reads (default).
  inputBinding:
    position: 103
    prefix: --soft-clip
- id: hard_clip
  type:
  - 'null'
  - boolean
  doc: Hard clip amplicon primers from reads.
  inputBinding:
    position: 103
    prefix: --hard-clip
- id: both_ends
  type:
  - 'null'
  - boolean
  doc: Clip on both 5' and 3' ends.
  inputBinding:
    position: 103
    prefix: --both-ends
- id: strand
  type:
  - 'null'
  - boolean
  doc: Use strand data from the BED file to match read direction.
  inputBinding:
    position: 103
    prefix: --strand
- id: clipped
  type:
  - 'null'
  - boolean
  doc: Only output clipped reads.
  inputBinding:
    position: 103
    prefix: --clipped
- id: fail
  type:
  - 'null'
  - boolean
  doc: Mark unclipped, mapped reads as QCFAIL.
  inputBinding:
    position: 103
    prefix: --fail
- id: filter_len
  type:
  - 'null'
  - int
  doc: Do not output reads INT size or shorter.
  inputBinding:
    position: 103
    prefix: --filter-len
- id: fail_len
  type:
  - 'null'
  - int
  doc: Mark as QCFAIL reads INT size or shorter.
  inputBinding:
    position: 103
    prefix: --fail-len
- id: unmap_len
  type:
  - 'null'
  - int
  doc: Unmap reads INT size or shorter, default 0.
  inputBinding:
    position: 103
    prefix: --unmap-len
- id: no_excluded
  type:
  - 'null'
  - boolean
  doc: Do not write excluded reads (unmapped or QCFAIL).
  inputBinding:
    position: 103
    prefix: --no-excluded
- id: rejects_file
  type:
  - 'null'
  - string
  doc: File to write filtered reads.
  inputBinding:
    position: 103
    prefix: --rejects-file
- id: primer_counts
  type:
  - 'null'
  - string
  doc: File to write read counts per BED entry (bedgraph format).
  inputBinding:
    position: 103
    prefix: --primer-counts
- id: original
  type:
  - 'null'
  - boolean
  doc: For clipped entries add an OA tag with original data.
  inputBinding:
    position: 103
    prefix: --original
- id: keep_tag
  type:
  - 'null'
  - boolean
  doc: For clipped entries keep the old NM and MD tags.
  inputBinding:
    position: 103
    prefix: --keep-tag
- id: tolerance
  type:
  - 'null'
  - int
  doc: Match region within this number of bases, default 5.
  inputBinding:
    position: 103
    prefix: --tolerance
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add an @PG line.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --input-fmt-option
  doc: Specify a single input file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --output-fmt-option
  doc: Specify a single output file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Output format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --output-fmt
outputs:
- id: output
  type: File
  doc: Clipped alignment file.
  outputBinding:
    glob: $(inputs.output_filename)
- id: stats_output
  type:
  - 'null'
  - File
  doc: Clipping statistics.
  outputBinding:
    glob: $(inputs.stats_file)
- id: rejects_output
  type:
  - 'null'
  - File
  doc: Filtered reads.
  outputBinding:
    glob: $(inputs.rejects_file)
- id: primer_counts_output
  type:
  - 'null'
  - File
  doc: Read counts per BED entry.
  outputBinding:
    glob: $(inputs.primer_counts)
