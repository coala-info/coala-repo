cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikmer_view
label: unikmer_view
doc: "Read and output binary format to plain text\n\nTool homepage: https://github.com/shenwei356/unikmer"
inputs:
  - id: compact
    type:
      - 'null'
      - boolean
    doc: write compact binary file with little loss of speed
    inputBinding:
      position: 101
      prefix: --compact
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing NCBI Taxonomy files, including nodes.dmp, 
      names.dmp, merged.dmp and delnodes.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: output in FASTA format, with encoded integer as FASTA header
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: output in FASTQ format, with encoded integer as FASTQ header
    inputBinding:
      position: 101
      prefix: --fastq
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: genomes in (gzipped) fasta file(s) for decoding hashed k-mers
    inputBinding:
      position: 101
      prefix: --genome
  - id: ignore_taxid
    type:
      - 'null'
      - boolean
    doc: ignore taxonomy information
    inputBinding:
      position: 101
      prefix: --ignore-taxid
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: max_taxid
    type:
      - 'null'
      - string
    doc: for smaller TaxIds, we can use less space to store TaxIds. default 
      value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds
    inputBinding:
      position: 101
      prefix: --max-taxid
  - id: no_compress
    type:
      - 'null'
      - boolean
    doc: do not compress binary file (not recommended)
    inputBinding:
      position: 101
      prefix: --no-compress
  - id: nocheck_file
    type:
      - 'null'
      - boolean
    doc: do not check binary file, when using process substitution or named pipe
    inputBinding:
      position: 101
      prefix: --nocheck-file
  - id: show_code
    type:
      - 'null'
      - boolean
    doc: show encoded integer along with k-mer
    inputBinding:
      position: 101
      prefix: --show-code
  - id: show_code_only
    type:
      - 'null'
      - boolean
    doc: only show encoded integers, faster than cutting from result of 
      -n/--show-cde
    inputBinding:
      position: 101
      prefix: --show-code-only
  - id: show_taxid
    type:
      - 'null'
      - boolean
    doc: show taxid
    inputBinding:
      position: 101
      prefix: --show-taxid
  - id: show_taxid_only
    type:
      - 'null'
      - boolean
    doc: show taxid only
    inputBinding:
      position: 101
      prefix: --show-taxid-only
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
