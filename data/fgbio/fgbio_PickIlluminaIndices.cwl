cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_PickIlluminaIndices
doc: "Picks a set of molecular indices that should work well together.\n\nThe indexes\
  \ to evaluate are generated randomly, unless the '--candidates' option is given.\
  \ The latter specifies a path\nto a file with one index per line from which indices\
  \ are picked.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: adapters
    type:
      - 'null'
      - string[]
    doc: The indexed adapter sequence into which the indices will be integrated. .
    inputBinding:
      position: 101
      prefix: --adapters
  - id: allow_palindromes
    type:
      - 'null'
      - boolean
    doc: 'Allow indices that are palindromic (''bases == rev(bases)''). [Default:
      false].'
    inputBinding:
      position: 101
      prefix: --allow-palindromes
      separate: false
      valueFrom: $("=" + self)
  - id: allow_reverse_complements
    type:
      - 'null'
      - boolean
    doc: 'Allow indices that are reverse complements of one another [Default: false].'
    inputBinding:
      position: 101
      prefix: --allow-reverse-complements
      separate: false
      valueFrom: $("=" + self)
  - id: allow_reverses
    type:
      - 'null'
      - boolean
    doc: 'Allow indices that are lexical reverses of one another [Default: false].'
    inputBinding:
      position: 101
      prefix: --allow-reverses
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
  - id: avoid_sequence
    type:
      - 'null'
      - string[]
    doc: Sequences that should be avoided. Any kmer of 'length' that appears in these
      sequences and their reverse complements will be thrown out. .
    inputBinding:
      position: 101
      prefix: --avoid-sequence
  - id: candidates
    type:
      - 'null'
      - File
    doc: The candidate indices from which to choose with one index per line (nothing
      else), otherwise generate all possible indices
    inputBinding:
      position: 101
      prefix: --candidates
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
  - id: edit_distance
    type:
      - 'null'
      - int
    doc: 'The minimum edit distance between two indices in the set. [Default: 3].'
    inputBinding:
      position: 101
      prefix: --edit-distance
  - id: indices
    type: int
    doc: The number of indices desired.
    inputBinding:
      position: 101
      prefix: --indices
  - id: length
    type:
      - 'null'
      - int
    doc: 'The length of each barcode sequence. [Default: 8].'
    inputBinding:
      position: 101
      prefix: --length
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: max_gc
    type:
      - 'null'
      - double
    doc: 'The maximum GC fraction for a barcode to be accepted. [Default: 0.7].'
    inputBinding:
      position: 101
      prefix: --max-gc
  - id: max_homopolymer
    type:
      - 'null'
      - int
    doc: 'Reject indices with a homopolymer of greater than this length. [Default:
      2].'
    inputBinding:
      position: 101
      prefix: --max-homopolymer
  - id: min_delta_g
    type:
      - 'null'
      - double
    doc: 'The lowest acceptable secondary structure ''deltaG''. [Default: -10.0].'
    inputBinding:
      position: 101
      prefix: --min-delta-g=
      separate: false
  - id: min_gc
    type:
      - 'null'
      - double
    doc: 'The minimum GC fraction for a barcode to be accepted. [Default: 0.0].'
    inputBinding:
      position: 101
      prefix: --min-gc
  - id: output_file
    type: string
    doc: File to write indices to.
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
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. [Default: 4].'
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
  - id: vienna_rna_dir
    type:
      - 'null'
      - Directory
    doc: The installation directory for 'ViennaRNA'.
    inputBinding:
      position: 101
      prefix: --vienna-rna-dir
arguments:
  - position: 50
    valueFrom: PickIlluminaIndices
outputs:
  - id: output_file_out
    type: File
    doc: File with the picked indices.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
