cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_FindTechnicalReads
doc: "Find reads that are from technical or synthetic sequences in a BAM file. Takes\
  \ in a BAM file, extracts the read pairs\nand fragment reads that are unmapped,\
  \ and tests them to see if they are likely generated from a technical sequence\n\
  (e.g. adapter dimer).\n\nThe identification of reads is done by testing the first\
  \ N bases (controlled by the match-length parameter) of each\nread against all sub-sequences\
  \ of length N from the technical sequences. Sub-sequences are generated from both\
  \ the\nsequences and the reverse complement of the sequences, ignoring any sub-sequences\
  \ that include 'N's.\n\nBy default the output BAM file will contain all reads that\
  \ matched to a sub-sequence of the technical sequences and, if\nthe read is paired,\
  \ the read's mate pair. An option is available to apply a tag to matched reads (--tag/-t),\
  \ and if\nspecified each matching read will be tagged with the 0-based index of\
  \ the sequence to which it matched. In combination\nwith tagging it is possible\
  \ to output all reads (-a/--all-reads) which will re-create the input BAM with the\
  \ addition\nof tags on matching reads.\n\nThe default set of sequences include a\
  \ range of different Illumina adapter sequences with the sample index/barcode\n\
  region masked to Ns.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: all_reads
    type:
      - 'null'
      - boolean
    doc: 'Output all reads. [Default: false].'
    inputBinding:
      position: 101
      prefix: --all-reads
      separate: false
      valueFrom: $("=" + self)
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
  - id: input_bam
    type: File
    doc: Input SAM or BAM file
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
  - id: match_length
    type:
      - 'null'
      - int
    doc: 'The number of bases at the start of the read to match against. [Default:
      15].'
    inputBinding:
      position: 101
      prefix: --match-length
  - id: max_errors
    type:
      - 'null'
      - int
    doc: 'The maximum number of errors in the matched region. [Default: 1].'
    inputBinding:
      position: 101
      prefix: --max-errors
  - id: output_bam
    type: string
    doc: Output SAM or BAM file
    inputBinding:
      position: 101
      prefix: --output
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: sequences
    type:
      - 'null'
      - string[]
    doc: The set of technical sequences to look for. .
    inputBinding:
      position: 101
      prefix: --sequences
  - id: tag
    type:
      - 'null'
      - string
    doc: Tag to set to indicate a read is a technical sequence.
    inputBinding:
      position: 101
      prefix: --tag
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
    valueFrom: FindTechnicalReads
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
