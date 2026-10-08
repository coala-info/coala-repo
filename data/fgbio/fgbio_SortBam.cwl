cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_SortBam
doc: "Sorts a SAM or BAM file. Several sort orders are available:\n\n  1. Coordinate:\
  \ sorts reads by their reference sequence and left-most aligned coordinate\n  2.\
  \ Queryname: sort the reads by their query (i.e. read) name\n  3. Random: sorts\
  \ the reads into a random order. The output is deterministic for any given input.\
  \ and several\n  4. RandomQuery: sorts the reads into a random order but keeps reads\
  \ with the same queryname together. The ordering is\n     deterministic for any\
  \ given input.\n  5. TemplateCoordinate: The sort order used by 'GroupReadByUmi'.\
  \ Sorts reads by the earlier unclipped 5' coordinate of\n     the read pair, the\
  \ higher unclipped 5' coordinate of the read pair, library, the molecular identifier\
  \ (MI tag), read\n     name, and if R1 has the lower coordinates of the pair.\n\n\
  Uses a temporary directory to buffer sets of sorted reads to disk. The number of\
  \ reads kept in memory affects memory use and can be changed with the '--max-records-in-ram'\
  \ option. The temporary directory to use can be set with the fgbio global option\
  \ '--tmp-dir'.\n\nAn example invocation might look like:\n\n  java -Xmx4g -jar fgbio.jar\
  \ --tmp-dir=/my/big/scratch/volume \\\n    SortBam --input=queryname.bam --sort-order=Coordinate\
  \ --output coordinate.bam\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
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
    doc: Input SAM or BAM.
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
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: Max records in RAM.
    inputBinding:
      position: 101
      prefix: --max-records-in-ram
  - id: output_bam
    type: string
    doc: Output SAM or BAM.
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
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'Order into which to sort the records. Options: Coordinate, Queryname, Random,
      RandomQuery, TemplateCoordinate, Unsorted, Unknown.'
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
arguments:
  - position: 50
    valueFrom: SortBam
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
