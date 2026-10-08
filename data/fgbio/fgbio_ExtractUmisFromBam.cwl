cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_ExtractUmisFromBam
doc: "Extracts unique molecular indexes from reads in a BAM file into tags.\n\nCurrently\
  \ only unmapped reads are supported.\n\nOnly template bases will be retained as\
  \ read bases (stored in the 'SEQ' field) as specified by the read structure.\n\n\
  A read structure should be provided for each read of a template. For example, paired\
  \ end reads should have two read structures specified. The tags to store the molecular\
  \ indices will be associated with the molecular index segment(s) in the read structure\
  \ based on the order specified. If only one molecular index tag is given, then the\
  \ molecular indices will be concatenated and stored in that tag. Otherwise the number\
  \ of molecular indices in the read structure should match the number of tags given.\
  \ In the resulting BAM file each end of a pair will contain the same molecular index\
  \ tags and values. Additionally, when multiple molecular indices are present the\
  \ '--single-tag' option may be used to write all indices, concatenated, to a single\
  \ tag in addition to the tags specified in '--molecular-index-tags'.\n\nOptionally,\
  \ the read names can be annotated with the molecular indices directly. In this case,\
  \ the read name will be formatted '<NAME>+<UMIs1><UMIs2>' where '<UMIs1>' is the\
  \ concatenation of read one's molecular indices. Similarly for '<UMIs2>'.\n\nMapping\
  \ information will not be adjusted, as such, this tool should not be used on reads\
  \ that have been mapped since it will lead to an BAM with inconsistent records.\n\
  \nThe read structure describes the structure of a given read as one or more read\
  \ segments. A read segment describes a contiguous stretch of bases of the same type\
  \ (ex. template bases) of some length and some offset from the start of the read.\
  \ Read structures are made up of '<number><operator>' pairs much like the CIGAR\
  \ string in BAM files. Five kinds of operators are recognized:\n\n  1. 'T' identifies\
  \ a template read\n  2. 'B' identifies a sample barcode read\n  3. 'M' identifies\
  \ a unique molecular index read\n  4. 'C' identifies a cell barcode read\n  5. 'S'\
  \ identifies a set of bases that should be skipped or ignored\n\nThe last '<number><operator>'\
  \ pair may be specified using a '+' sign instead of number to denote \"all remaining\
  \ bases\". This is useful if, e.g., fastqs have been trimmed and contain reads of\
  \ varying length.\n\nAn example would be '10B3M7S100T' which describes 120 bases,\
  \ with the first ten bases being a sample barcode, bases 11-13 being a molecular\
  \ index, bases 14-20 ignored, and bases 21-120 being template bases. See Read Structures\
  \ (https://github.com/fulcrumgenomics/fgbio/wiki/Read-Structures) for more information.\n\
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: annotate_read_names
    type:
      - 'null'
      - boolean
    doc: Annotate the read names with the molecular indices. See usage for more details.
    inputBinding:
      position: 101
      prefix: --annotate-read-names
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: clipping_attribute
    type:
      - 'null'
      - string
    doc: The SAM tag with the position in read to clip adapters (e.g. 'XT' as produced
      by Picard's 'MarkIlluminaAdapters').
    inputBinding:
      position: 101
      prefix: --clipping-attribute
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
    doc: Input BAM file.
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
  - id: molecular_index_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: SAM tag(s) in which to store the molecular indices.
    inputBinding:
      position: 101
      prefix: --molecular-index-tags
  - id: output_bam
    type: string
    doc: Output BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: read_structure
    type:
      type: array
      items: string
    doc: The read structure, one per read in a template.
    inputBinding:
      position: 101
      prefix: --read-structure
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: single_tag
    type:
      - 'null'
      - string
    doc: Single tag into which to concatenate all molecular indices.
    inputBinding:
      position: 101
      prefix: --single-tag
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
    valueFrom: ExtractUmisFromBam
outputs:
  - id: output_bam_out
    type: File
    doc: Output BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
