cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_PickLongIndices
doc: "Picks a set of molecular indices that have at least a given number of mismatches\
  \ between them. Whereas\n'PickIlluminaIndices' attempts to pick a near-optimal set\
  \ of indices, 'PickLongIndices' implements a significantly more\nefficient method\
  \ based on generation of random indices that can generate a large set of satisfactory\
  \ indices in a small\namount of time and memory even for index lengths '>> 10bp'.\n\
  \nMany options exist for controlling aspects of the indices picked, including length,\
  \ edit distance (mismatches only), gc\nrange, homopolymer content, secondary structure\
  \ etc.\n\nSecondary structure is predicted using ViennaRNA's 'RNAfold' in DNA mode.\
  \ To enable structure checking both the\n'--vienna-rna-dir' and '--adapters' must\
  \ be specified. Adapters must be strings of A, C, G, and T with a single block\n\
  of Ns (e.g. 'ACGTNNNN' or 'ACNNNNGT'). At runtime the Ns are replaced with indices,\
  \ and 'deltaG' of the\nindex-containing sequence is calculated.\n\nThe number of\
  \ indices requested may not be possible to produce given other constraints. When\
  \ this is the case the tool\nwill output as many indices as possible, though less\
  \ than the requested number. In such cases it may be useful to try\ndifferent values\
  \ for '--attempt'. This parameter controls how many attempts are made to find the\
  \ next valid index\nbefore quitting and outputting the accumulated indices. Higher\
  \ values will yield incrementally more indices but require\nsignificantly longer\
  \ runtimes.\n\nA file of existing indices may be provided. Existing indices must\
  \ be of the same length as requested indices and\ncomposed of A, C, G and Ts, but\
  \ are subject to no other constraints. Index picking will then built a set comprised\
  \ of\nthe existing indices, and new indices which satisfy all constraints. Existing\
  \ indices are included in the generated\noutput file.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: adapters
    type:
      - 'null'
      - string[]
    doc: Adapter sequence(s) into which indices will be inserted.
    inputBinding:
      position: 101
      prefix: --adapters
  - id: allow_palindromes
    type:
      - 'null'
      - boolean
    doc: 'Allow indices that are palindromic (''index == revcomp(index)''). [Default:
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
  - id: attempts
    type:
      - 'null'
      - int
    doc: 'Attempts to pick the next index before quitting. [Default: 100000].'
    inputBinding:
      position: 101
      prefix: --attempts
  - id: avoid_sequence
    type:
      - 'null'
      - string[]
    doc: Any index sequence that appears in an avoid sequence or its reverse complement
      will be discarded. .
    inputBinding:
      position: 101
      prefix: --avoid-sequence
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
  - id: existing
    type:
      - 'null'
      - File
    doc: File of existing index sequences to integrate, one per line.
    inputBinding:
      position: 101
      prefix: --existing
  - id: length
    type:
      - 'null'
      - int
    doc: 'The length of each index sequence. [Default: 8].'
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
    doc: 'The maximum GC fraction for an index to be accepted. [Default: 0.8].'
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
    doc: 'The minimum GC fraction for an index to be accepted. [Default: 0.2].'
    inputBinding:
      position: 101
      prefix: --min-gc
  - id: number_of_indices
    type: int
    doc: The number of indices desired.
    inputBinding:
      position: 101
      prefix: --number-of-indices
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
  - id: seed
    type:
      - 'null'
      - long
    doc: 'Random seed value. [Default: 1].'
    inputBinding:
      position: 101
      prefix: --seed
  - id: temperature
    type:
      - 'null'
      - double
    doc: 'The temperature at which to predict secondary structure. [Default: 25.0].'
    inputBinding:
      position: 101
      prefix: --temperature
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
    valueFrom: PickLongIndices
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
