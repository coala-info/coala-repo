cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_ClipBam
doc: "Clips reads from the same template. Ensures that at least N bases are clipped\
  \ from any end of the read (i.e. R1 5' end, R1 3' end, R2 5' end, and R2 3' end).\
  \ Optionally clips reads from the same template to eliminate overlap between the\
  \ reads. This ensures that downstream processes, particularly variant calling, cannot\
  \ double-count evidence from the same template when both reads span a variant site\
  \ in the same template.\n\nClipping overlapping reads is only performed on 'FR'\
  \ read pairs, and is implemented by clipping approximately half the overlapping\
  \ bases from each read. By default hard clipping is performed; soft-clipping may\
  \ be substituted using the '--soft-clip' parameter.\n\nSecondary alignments and\
  \ supplemental alignments are not clipped, but are passed through into the output.\n\
  \nIn order to correctly clip reads by template and update mate information, the\
  \ input BAM must be either 'queryname' sorted or 'query' grouped. If your input\
  \ BAM is not in an appropriate order the sort can be done in streaming fashion with,\
  \ for example:\n\n  samtools sort -n -u in.bam | fgbio ClipBam -i /dev/stdin ...\n\
  \nThe output sort order may be specified with '--sort-order'. If not given, then\
  \ the output will be in the same order as input.\n\nAny existing 'NM', 'UQ' and\
  \ 'MD' tags are repaired, and mate-pair information updated.\n\nThree clipping modes\
  \ are supported:\n\n  1. 'Soft' - soft-clip the bases and qualities.\n  2. 'SoftWithMask'\
  \ - soft-clip and mask the bases and qualities (make bases Ns and qualities the\
  \ minimum).\n  3. 'Hard' - hard-clip the bases and qualities.\n\nThe '--upgrade-clipping'\
  \ parameter will convert all existing clipping in the input to the given more stringent\
  \ mode: from 'Soft' to either 'SoftWithMask' or 'Hard', and 'SoftWithMask' to 'Hard'.\
  \ In all other cases, clipping remains the same prior to applying any other clipping\
  \ criteria.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: auto_clip_attributes
    type:
      - 'null'
      - boolean
    doc: Automatically clip extended attributes that are the same length as bases.
    inputBinding:
      position: 101
      prefix: --auto-clip-attributes
  - id: clip_bases_past_mate
    type:
      - 'null'
      - boolean
    doc: Clip reads in FR pairs that sequence past the far end of their mate.
    inputBinding:
      position: 101
      prefix: --clip-bases-past-mate
  - id: clip_overlapping_reads
    type:
      - 'null'
      - boolean
    doc: Clip overlapping reads.
    inputBinding:
      position: 101
      prefix: --clip-overlapping-reads
  - id: clipping_mode
    type:
      - 'null'
      - string
    doc: 'The type of clipping to perform. Options: Soft, SoftWithMask, Hard.'
    inputBinding:
      position: 101
      prefix: --clipping-mode
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: input_bam
    type: File
    doc: Input SAM or BAM file of aligned reads in coordinate order.
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
  - id: metrics
    type:
      - 'null'
      - string
    doc: Optional output of clipping metrics.
    inputBinding:
      position: 101
      prefix: --metrics
  - id: output_bam
    type: string
    doc: Output SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: read_one_five_prime
    type:
      - 'null'
      - int
    doc: Require at least this number of bases to be clipped on the 5' end of R1
    inputBinding:
      position: 101
      prefix: --read-one-five-prime
  - id: read_one_three_prime
    type:
      - 'null'
      - int
    doc: Require at least this number of bases to be clipped on the 3' end of R1
    inputBinding:
      position: 101
      prefix: --read-one-three-prime
  - id: read_two_five_prime
    type:
      - 'null'
      - int
    doc: Require at least this number of bases to be clipped on the 5' end of R2
    inputBinding:
      position: 101
      prefix: --read-two-five-prime
  - id: read_two_three_prime
    type:
      - 'null'
      - int
    doc: Require at least this number of bases to be clipped on the 3' end of R2
    inputBinding:
      position: 101
      prefix: --read-two-three-prime
  - id: ref_fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    type: File
    doc: Reference sequence fasta file.
    inputBinding:
      position: 101
      prefix: --ref
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
    doc: 'The sort order of the output. If not given, output will be in the same order
      as input if the input. Options: Coordinate, Queryname, Random, RandomQuery,
      TemplateCoordinate, Unsorted, Unknown.'
    inputBinding:
      position: 101
      prefix: --sort-order
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: upgrade_clipping
    type:
      - 'null'
      - boolean
    doc: Upgrade all existing clipping in the input to the given clipping mode prior
      to applying any other clipping criteria.
    inputBinding:
      position: 101
      prefix: --upgrade-clipping
arguments:
  - position: 50
    valueFrom: ClipBam
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
  - id: metrics_out
    type:
      - 'null'
      - File
    doc: Optional output of clipping metrics.
    outputBinding:
      glob: $(inputs.metrics)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
