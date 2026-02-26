cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - SortSequenceDictionary
label: fgbio_SortSequenceDictionary
doc: "Sorts a sequence dictionary file in the order of another sequence dictionary.\n\
  \nThe inputs are to two '*.dict' files. One to be sorted, and the other to provide
  the order for the sorting.\n\nIf there is a contig in the input dictionary that
  is not in the sorting dictionary, that contig will be appended to the\nend of the
  sequence dictionary in the same relative order to other appended contigs as in the
  input dictionary. Missing\ncontigs can be omitted by setting '--skip-missing-contigs'
  to true.\n\nIf there is a contig in the sorting dictionary that is not in the input
  dictionary, that contig will be ignored.\n\nThe output will be a sequence dictionary,
  containing the version header line and one line per contig. The fields of the\n\
  entries in this dictionary will be the same as in input, but in the order of '--sort-dictionary'.\n\
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    default: false
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    default: 5
    inputBinding:
      position: 101
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 101
      prefix: --cram-ref-fasta
  - id: input
    type: File
    doc: Input sequence dictionary file to be sorted.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    default: Info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    default: SILENT
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: skip_missing_contigs
    type:
      - 'null'
      - boolean
    doc: Skip input contigs that have no matching contig in the sort dictionary 
      rather than appending to the end of the output dictionary.
    default: false
    inputBinding:
      position: 101
      prefix: --skip-missing-contigs
  - id: sort_dictionary
    type: File
    doc: Input sequence dictionary file containing contigs in the desired sort 
      order.
    inputBinding:
      position: 101
      prefix: --sort-dictionary
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output
    type: File
    doc: Output sequence dictionary file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
