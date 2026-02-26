cwlVersion: v1.2
class: CommandLineTool
baseCommand: cat
label: seqfu_cat
doc: "Concatenate multiple FASTA or FASTQ files.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA or FASTQ files
    inputBinding:
      position: 1
  - id: add_ee
    type:
      - 'null'
      - boolean
    doc: Add 'ee=EXPECTED_ERROR' to the comments
    inputBinding:
      position: 102
      prefix: --add-ee
  - id: add_gc
    type:
      - 'null'
      - boolean
    doc: Add 'gc=%GC' to the comments
    inputBinding:
      position: 102
      prefix: --add-gc
  - id: add_initial_ee
    type:
      - 'null'
      - boolean
    doc: Add 'original_ee=EXPECTED_ERROR' to the comments
    inputBinding:
      position: 102
      prefix: --add-initial-ee
  - id: add_initial_gc
    type:
      - 'null'
      - boolean
    doc: Add 'original_gc=%GC' to the comments
    inputBinding:
      position: 102
      prefix: --add-initial-gc
  - id: add_initial_len
    type:
      - 'null'
      - boolean
    doc: Add 'original_len=LENGTH' to the comments
    inputBinding:
      position: 102
      prefix: --add-initial-len
  - id: add_len
    type:
      - 'null'
      - boolean
    doc: Add 'len=LENGTH' to the comments
    inputBinding:
      position: 102
      prefix: --add-len
  - id: add_name
    type:
      - 'null'
      - boolean
    doc: Add 'original_name=INITIAL_NAME' to the comments
    inputBinding:
      position: 102
      prefix: --add-name
  - id: anvio
    type:
      - 'null'
      - boolean
    doc: Output in Anvio format (-p c_ -s -z --zeropad 12 --report 
      rename_report.txt)
    inputBinding:
      position: 102
      prefix: --anvio
  - id: append
    type:
      - 'null'
      - string
    doc: Append this string to the sequence name
    default: ''
    inputBinding:
      position: 102
      prefix: --append
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Prepend file basename to the sequence name (before prefix)
    inputBinding:
      position: 102
      prefix: --basename
  - id: basename_sep
    type:
      - 'null'
      - string
    doc: Separate basename from the rest with this
    default: _
    inputBinding:
      position: 102
      prefix: --basename-sep
  - id: comment_sep
    type:
      - 'null'
      - string
    doc: Comment separator
    default: ' '
    inputBinding:
      position: 102
      prefix: --comment-sep
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Force FASTA output
    inputBinding:
      position: 102
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Force FASTQ output
    inputBinding:
      position: 102
      prefix: --fastq
  - id: fastq_qual
    type:
      - 'null'
      - int
    doc: FASTQ default quality
    default: 33
    inputBinding:
      position: 102
      prefix: --fastq-qual
  - id: jump_to
    type:
      - 'null'
      - string
    doc: Start from the record after the one named STR (overrides --skip-first)
    inputBinding:
      position: 102
      prefix: --jump-to
  - id: list
    type:
      - 'null'
      - boolean
    doc: Output a list of sequence names
    inputBinding:
      position: 102
      prefix: --list
  - id: long
    type:
      - 'null'
      - boolean
    doc: Output a list, with sequence name and comments
    inputBinding:
      position: 102
      prefix: --long
  - id: max_bp
    type:
      - 'null'
      - int
    doc: Stop printing after INT bases
    default: 0
    inputBinding:
      position: 102
      prefix: --max-bp
  - id: max_ee
    type:
      - 'null'
      - float
    doc: Discard sequences with higher than FLOAT expected error
    default: -1.0
    inputBinding:
      position: 102
      prefix: --max-ee
  - id: max_len
    type:
      - 'null'
      - int
    doc: Discard sequences longer than INT, 0 to ignore
    default: 0
    inputBinding:
      position: 102
      prefix: --max-len
  - id: max_ns
    type:
      - 'null'
      - int
    doc: Discard sequences with more than INT Ns
    default: -1
    inputBinding:
      position: 102
      prefix: --max-ns
  - id: min_len
    type:
      - 'null'
      - int
    doc: Discard sequences shorter than INT
    default: 1
    inputBinding:
      position: 102
      prefix: --min-len
  - id: part
    type:
      - 'null'
      - int
    doc: After splitting the basename, take this part
    default: 1
    inputBinding:
      position: 102
      prefix: --part
  - id: prefix
    type:
      - 'null'
      - string
    doc: Rename sequences with prefix + incremental number
    inputBinding:
      position: 102
      prefix: --prefix
  - id: print_last
    type:
      - 'null'
      - boolean
    doc: Print the name of the last sequence to STDERR (Last:NAME)
    inputBinding:
      position: 102
      prefix: --print-last
  - id: sep
    type:
      - 'null'
      - string
    doc: Sequence name fields separator
    default: _
    inputBinding:
      position: 102
      prefix: --sep
  - id: skip
    type:
      - 'null'
      - int
    doc: Print one sequence every STEP
    default: 0
    inputBinding:
      position: 102
      prefix: --skip
  - id: skip_first
    type:
      - 'null'
      - int
    doc: Skip the first INT records
    default: -1
    inputBinding:
      position: 102
      prefix: --skip-first
  - id: split
    type:
      - 'null'
      - string
    doc: Split basename at this char
    default: .
    inputBinding:
      position: 102
      prefix: --split
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: Remove original sequence comments
    inputBinding:
      position: 102
      prefix: --strip-comments
  - id: strip_name
    type:
      - 'null'
      - boolean
    doc: Remove the original sequence name
    inputBinding:
      position: 102
      prefix: --strip-name
  - id: trim_front
    type:
      - 'null'
      - int
    doc: Trim INT base from the start of the sequence
    default: 0
    inputBinding:
      position: 102
      prefix: --trim-front
  - id: trim_tail
    type:
      - 'null'
      - int
    doc: Trim INT base from the end of the sequence
    default: 0
    inputBinding:
      position: 102
      prefix: --trim-tail
  - id: truncate
    type:
      - 'null'
      - int
    doc: Keep only the first INT bases, 0 to ignore. Negative values to print 
      the last INT bases
    default: 0
    inputBinding:
      position: 102
      prefix: --truncate
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: zero_pad
    type:
      - 'null'
      - int
    doc: Zero pad the counter to INT digits
    default: 0
    inputBinding:
      position: 102
      prefix: --zero-pad
outputs:
  - id: report
    type:
      - 'null'
      - File
    doc: Save a report to FILE (original name, new name)
    outputBinding:
      glob: $(inputs.report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
