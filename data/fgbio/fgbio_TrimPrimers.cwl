cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_TrimPrimers
doc: "Trims primers from reads post-alignment. Takes in a BAM file of aligned reads\
  \ and a tab-delimited file with five columns ('chrom', 'left_start', 'left_end',\
  \ 'right_start', and 'right_end') which provide the 1-based inclusive start and\
  \ end positions of the primers for each amplicon. The primer file must include headers,\
  \ e.g:\n\n  chrom  left_start  left_end  right_start right_end\n  chr1   1010873\
  \     1010894   1011118     1011137\n\nBoth paired end reads and fragment reads\
  \ that map to a given amplicon position are trimmed so that the alignment no-longer\
  \ includes the primer sequences. This includes both the 5' and 3' ends of each read.\
  \ All other aligned reads have the maximum primer length trimmed from the 5' end\
  \ only!\n\nReads that are trimmed will have the 'NM', 'UQ' and 'MD' tags cleared\
  \ as they are no longer guaranteed to be accurate. If a reference is provided the\
  \ reads will be re-sorted by coordinate after trimming and the 'NM', 'UQ' and 'MD'\
  \ tags recalculated.\n\nIf the input BAM is not 'queryname' sorted it will be sorted\
  \ internally so that mate information between paired-end reads can be corrected\
  \ before writing the output file.\n\nThe '--first-of-pair' option will cause only\
  \ the first of pair (R1) reads to be trimmed based solely on the primer location\
  \ of R1. This is useful when there is a target specific primer on the 5' end of\
  \ R1 but no primer sequenced on R2 (eg. single gene-specific primer target enrichment),\
  \ as well as fragment reads. In this case, the location of each target specific\
  \ primer should be specified in an amplicons left or right primer exclusively. The\
  \ coordinates of the non-specific-target primer should be '-1' for both start and\
  \ end, e.g:\n\n  chrom  left_start  left_end  right_start right_end\n  chr1   1010873\
  \     1010894   -1          -1\n  chr2   -1          -1        1011118     1011137\n\
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: auto_trim_attributes
    type:
      - 'null'
      - boolean
    doc: Automatically trim extended attributes that are the same length as bases.
    inputBinding:
      position: 101
      prefix: --auto-trim-attributes
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
  - id: first_of_pair
    type:
      - 'null'
      - boolean
    doc: Trim only first of pair reads (R1s) or fragment reads, otherwise both ends
      of a pair.
    inputBinding:
      position: 101
      prefix: --first-of-pair
  - id: hard_clip
    type:
      - 'null'
      - boolean
    doc: If true, hard clip reads, else soft clip.
    inputBinding:
      position: 101
      prefix: --hard-clip
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
  - id: output_bam
    type: string
    doc: Output BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: primers
    type: File
    doc: File with primer locations.
    inputBinding:
      position: 101
      prefix: --primers
  - id: ref_fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    type:
      - 'null'
      - File
    doc: Optional reference fasta for recalculating NM, MD and UQ tags.
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
  - id: slop
    type:
      - 'null'
      - int
    doc: Match to primer locations +/- this many bases.
    inputBinding:
      position: 101
      prefix: --slop
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'Sort order of output BAM file (defaults to input sort order). Options: Coordinate,
      Queryname, Random, RandomQuery, TemplateCoordinate, Unsorted, Unknown.'
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
    valueFrom: TrimPrimers
outputs:
  - id: output_bam_out
    type: File
    doc: Output BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
