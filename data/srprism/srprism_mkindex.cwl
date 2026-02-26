cwlVersion: v1.2
class: CommandLineTool
baseCommand: srprism
label: srprism_mkindex
doc: "Fast Short Read Aligner\n\nTool homepage: https://github.com/ncbi/SRPRISM"
inputs:
  - id: cmd
    type: string
    doc: 'Action to perform. Possible values are: help, search, mkindex'
    inputBinding:
      position: 1
  - id: al_extend
    type:
      - 'null'
      - int
    doc: Number of reference bases by which an alternate locus is extended to 
      the left (right) in the case of non-fuzzy left (right) end.
    default: 2000
    inputBinding:
      position: 102
      prefix: --al-extend
  - id: alt_loc
    type:
      - 'null'
      - File
    doc: Name of the alternative loci specification file.
    inputBinding:
      position: 102
      prefix: --alt-loc
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Source database (may be a comma-separated list of file names). This 
      options takes precedence over --input-list.
    inputBinding:
      position: 102
      prefix: --input
  - id: input_compression
    type:
      - 'null'
      - string
    doc: Compression type used for input. The possible values are "auto" 
      (default), "none", "gzip", and "bzip2". If the value given is "auto" then 
      the type of compression is guessed from the file extension.
    default: auto
    inputBinding:
      position: 102
      prefix: --input-compression
  - id: input_format
    type:
      - 'null'
      - string
    doc: The input format name. The possible values are "fasta", "fastq", 
      "cfasta", "cfastq".
    default: fasta
    inputBinding:
      position: 102
      prefix: --input-format
  - id: input_list
    type:
      - 'null'
      - File
    doc: Name of the file containing a list of input file names, one name per 
      line.
    inputBinding:
      position: 102
      prefix: --input-list
  - id: log_file
    type:
      - 'null'
      - File
    doc: File for storing diagnostic messages. Default is standard error.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: memory
    type:
      - 'null'
      - int
    doc: Do not use more than this many megabytes of memory for internal dynamic
      data structures. This number does not include the footprint of the 
      executable code, static data, or stack.
    default: 2048
    inputBinding:
      position: 102
      prefix: --memory
  - id: output
    type: string
    doc: Base name for generated database index files.
    inputBinding:
      position: 102
      prefix: --output
  - id: output_format
    type:
      - 'null'
      - string
    doc: The output format name. The possible values are "standard".
    default: standard
    inputBinding:
      position: 102
      prefix: --output-format
  - id: seg_letters
    type:
      - 'null'
      - int
    doc: Number of letters in sequence store segment. It is recommended that 
      this value is set to less than half of length of a typical sequence in the
      reference database. Each reference sequence occupies at least one segment 
      and the sequence store can store at most 2^32 - 1 bases. If the reference 
      has a large number of very short sequence, decreasing this value can help 
      to pack more sequences into the sequence store and optimize memory usage.
    default: 8192
    inputBinding:
      position: 102
      prefix: --seg-letters
  - id: trace_level
    type:
      - 'null'
      - string
    doc: Minimum message level to report to the log stream. Possible values are 
      "debug", "info", "warning", "error", "quiet".
    default: warning
    inputBinding:
      position: 102
      prefix: --trace-level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srprism:2.4.24--hd6d6fdc_6
stdout: srprism_mkindex.out
