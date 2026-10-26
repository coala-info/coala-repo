cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unikmer
  - sort
label: unikmer_sort
doc: |-
  Sort k-mers to reduce the file size and accelerate downstream analysis

  Tool homepage: https://github.com/shenwei356/unikmer
inputs:
  - id: chunk_size
    type: ['null', string]
    doc: "split input into chunks of N k-mers, supports K/M/G suffix, type \"unikmer sort -h\" for detail"
    inputBinding:
      position: 10
      prefix: --chunk-size
  - id: force
    type: ['null', boolean]
    doc: "overwrite tmp dir"
    inputBinding:
      position: 10
      prefix: --force
  - id: keep_tmp_dir
    type: ['null', boolean]
    doc: "keep tmp dir"
    inputBinding:
      position: 10
      prefix: --keep-tmp-dir
  - id: max_open_files
    type: ['null', int]
    doc: "max number of open files"
    inputBinding:
      position: 10
      prefix: --max-open-files
  - id: repeated
    type: ['null', boolean]
    doc: "only print duplicate k-mers"
    inputBinding:
      position: 10
      prefix: --repeated
  - id: tmp_dir
    type: ['null', string]
    doc: "directory for intermediate files"
    inputBinding:
      position: 10
      prefix: --tmp-dir
  - id: unique
    type: ['null', boolean]
    doc: "remove duplicate k-mers"
    inputBinding:
      position: 10
      prefix: --unique
  - id: compact
    type: ['null', boolean]
    doc: "write compact binary file with little loss of speed"
    inputBinding:
      position: 10
      prefix: --compact
  - id: compression_level
    type: ['null', int]
    doc: "compression level"
    inputBinding:
      position: 10
      prefix: --compression-level
  - id: data_dir
    type: ['null', Directory]
    doc: "directory containing NCBI Taxonomy files, including nodes.dmp, names.dmp, merged.dmp and delnodes.dmp"
    inputBinding:
      position: 10
      prefix: --data-dir
  - id: ignore_taxid
    type: ['null', boolean]
    doc: "ignore taxonomy information"
    inputBinding:
      position: 10
      prefix: --ignore-taxid
  - id: infile_list
    type: ['null', File]
    doc: "file of input files list (one file per line), if given, they are appended to files from cli arguments (names inside must match the staged files; give them also in listed_files)"
    inputBinding:
      position: 10
      prefix: --infile-list
  - id: max_taxid
    type: ['null', long]
    doc: "for smaller TaxIds, we can use less space to store TaxIds. default value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds"
    inputBinding:
      position: 10
      prefix: --max-taxid
  - id: no_compress
    type: ['null', boolean]
    doc: "do not compress binary file (not recommended)"
    inputBinding:
      position: 10
      prefix: --no-compress
  - id: nocheck_file
    type: ['null', boolean]
    doc: "do not check binary file, when using process substitution or named pipe"
    inputBinding:
      position: 10
      prefix: --nocheck-file
  - id: threads
    type: ['null', int]
    doc: "number of CPUs to use"
    inputBinding:
      position: 10
      prefix: --threads
  - id: verbose
    type: ['null', boolean]
    doc: "print verbose information"
    inputBinding:
      position: 10
      prefix: --verbose
  - id: unik_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input k-mer binary (.unik) files. Required unless --infile-list is given."
    inputBinding:
      position: 200
  - id: out_prefix
    type: string
    doc: "Output file prefix (the wrapper requires a name; '-' for stdout is not supported)"
    inputBinding:
      position: 10
      prefix: --out-prefix
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the --infile-list file (staged into the working directory so the names resolve)."
outputs:
  - id: out_unik
    type: File
    doc: Output k-mer binary file (<out-prefix>.unik)
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.listed_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
