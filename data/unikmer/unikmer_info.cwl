cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unikmer
  - info
label: unikmer_info
doc: |-
  Information of binary files

  Tool homepage: https://github.com/shenwei356/unikmer
inputs:
  - id: all
    type: ['null', boolean]
    doc: "all information, including number of k-mers"
    inputBinding:
      position: 10
      prefix: --all
  - id: basename
    type: ['null', boolean]
    doc: "only output basename of files"
    inputBinding:
      position: 10
      prefix: --basename
  - id: skip_err
    type: ['null', boolean]
    doc: "skip error, only show warning message"
    inputBinding:
      position: 10
      prefix: --skip-err
  - id: symbol_false
    type: ['null', string]
    doc: "smybol for false"
    inputBinding:
      position: 10
      prefix: --symbol-false
  - id: symbol_true
    type: ['null', string]
    doc: "smybol for true"
    inputBinding:
      position: 10
      prefix: --symbol-true
  - id: tabular
    type: ['null', boolean]
    doc: "output in machine-friendly tabular format"
    inputBinding:
      position: 10
      prefix: --tabular
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
  - id: out_file
    type: string
    doc: "Output file name (the wrapper requires a name; '-' for stdout is not supported)"
    inputBinding:
      position: 10
      prefix: --out-file
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the --infile-list file (staged into the working directory so the names resolve)."
outputs:
  - id: out
    type: File
    doc: Output text file
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.listed_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
