cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_ZipperBams
doc: "Zips together an unmapped and mapped BAM to transfer metadata into the output\
  \ BAM.\n\nBoth the unmapped and mapped BAMs must be a) queryname sorted or grouped\
  \ (i.e. all records with the same name are grouped together in the file), and b)\
  \ have the same ordering of querynames. If either of these are violated the output\
  \ is undefined!\n\nAll tags present on the unmapped reads are transferred to the\
  \ mapped reads. The options '--tags-to-reverse' and '--tags-to-revcomp' will cause\
  \ tags on the unmapped reads to be reversed or reverse complemented before being\
  \ copied to reads mapped to the negative strand. These options can take a mixture\
  \ of two-letter tag names and the names of tag sets, which will be expanded into\
  \ sets of tag names. Currently the only named tag set is \"Consensus\" which contains\
  \ all the per-base consensus tags produced by fgbio consensus callers.\n\nBy default\
  \ the mapped BAM is read from standard input (stdin) and the output BAM is written\
  \ to standard output (stdout). This can be changed using the '--input/-i' and '--output/-o'\
  \ options.\n\nBy default the output BAM file is emitted in the same order as the\
  \ input BAMs. This can be overridden using the '--sort' option, though in practice\
  \ it may be faster to do the following:\n\n  fgbio --compression 0 ZipperBams -i\
  \ mapped.bam -u unmapped.bam -r ref.fa | samtools sort -@ $(nproc)\n\nTool homepage:\
  \ https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: buffer
    type:
      - 'null'
      - int
    doc: Buffer this many read-pairs while reading the input BAMs.
    inputBinding:
      position: 101
      prefix: --buffer
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
    doc: Mapped SAM or BAM.
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
        required: false
    type: File
    doc: Path to the reference used in alignment. Must have accompanying .dict file.
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
  - id: sort
    type:
      - 'null'
      - string
    doc: 'Sort the output BAM into the given order. Options: Coordinate, Queryname,
      Random, RandomQuery, TemplateCoordinate, Unsorted, Unknown.'
    inputBinding:
      position: 101
      prefix: --sort
  - id: tags_to_remove
    type:
      - 'null'
      - type: array
        items: string
    doc: Tags to remove from the mapped BAM records.
    inputBinding:
      position: 101
      prefix: --tags-to-remove
  - id: tags_to_revcomp
    type:
      - 'null'
      - type: array
        items: string
    doc: Set of optional tags to reverse complement on reads mapped to the negative
      strand.
    inputBinding:
      position: 101
      prefix: --tags-to-revcomp
  - id: tags_to_reverse
    type:
      - 'null'
      - type: array
        items: string
    doc: Set of optional tags to reverse on reads mapped to the negative strand.
    inputBinding:
      position: 101
      prefix: --tags-to-reverse
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: unmapped
    type: File
    doc: Unmapped SAM or BAM.
    inputBinding:
      position: 101
      prefix: --unmapped
arguments:
  - position: 50
    valueFrom: ZipperBams
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
