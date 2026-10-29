cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_CallOverlappingConsensusBases
doc: "Consensus calls overlapping bases in read pairs.\n\nInputs and Outputs\n\nIn\
  \ order to correctly correct reads by template, the input BAM must be either 'queryname'\
  \ sorted or 'query' grouped.\nThe sort can be done in streaming fashion with:\n\n\
  \  samtools sort -n -u in.bam | fgbio CallOverlappingConsensusBases -i /dev/stdin\
  \ ...\n\nThe output sort order may be specified with '--sort-order'. If not given,\
  \ then the output will be in the same order as\ninput.\n\nThe reference FASTA must\
  \ be given so that any existing 'NM', 'UQ' and 'MD' tags can be repaired.\n\nCorrection\n\
  \nOnly mapped read pairs with overlapping bases will be eligible for correction.\n\
  \nEach read base from the read and its mate that map to same position in the reference\
  \ will be used to create a consensus\nbase as follows:\n\n  1. If the base agree,\
  \ then the chosen agreement strategy ('--agreement-strategy') will be used.\n  2.\
  \ If the base disagree, then the chosen disagreement strategy ('--disagreement-strategy')\
  \ will be used.\n\nThe agreement strategies are as follows:\n\n  * Consensus: Call\
  \ the consensus base and return a new base quality that is the sum of the two base\
  \ qualities.\n  * MaxQual: Call the consensus base and return a new base quality\
  \ that is the maximum of the two base qualities.\n  * PassThrough: Leave the bases\
  \ and base qualities unchanged.\n\nIn the context of disagreement strategies, masking\
  \ a base will make the base an \"N\" with base quality phred-value \"2\".\nThe disagreement\
  \ strategies are as follows:\n\n  * MaskBoth: Mask both bases.\n  * MaskLowerQual:\
  \ Mask the base with the lowest base quality, with the other base unchanged. If\
  \ the base qualities are\n    the same, mask both bases.\n  * Consensus: Consensus\
  \ call the base. If the base qualities are the same, mask both bases. Otherwise,\
  \ call the base\n    with the highest base quality and return a new base quality\
  \ that is the difference between the highest and lowest\n    base quality.\n\nTool\
  \ homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: agreement_strategy
    type:
      - 'null'
      - string
    doc: 'The strategy to consensus call when both bases agree. See the usage for
      more details [Default: Consensus]. Options: Consensus, MaxQual, PassThrough.'
    inputBinding:
      position: 101
      prefix: --agreement-strategy
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
      separate: false
      valueFrom: $("=" + self)
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
  - id: disagreement_strategy
    type:
      - 'null'
      - string
    doc: 'The strategy to consensus call when both bases disagree. See the usage for
      more details [Default: Consensus]. Options: MaskBoth, MaskLowerQual, Consensus.'
    inputBinding:
      position: 101
      prefix: --disagreement-strategy
  - id: input_bam
    type: File
    doc: Input SAM or BAM file of aligned reads.
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
  - id: metrics_file
    type: string
    doc: Output metrics file.
    inputBinding:
      position: 101
      prefix: --metrics
  - id: output_bam
    type: string
    doc: Output SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: ref_fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: true
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
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use while consensus calling. [Default: 1].'
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
    valueFrom: CallOverlappingConsensusBases
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
  - id: metrics_out
    type: File
    doc: Output metrics file.
    outputBinding:
      glob: $(inputs.metrics_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
