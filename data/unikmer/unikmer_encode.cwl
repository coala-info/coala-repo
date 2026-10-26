cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unikmer
  - encode
label: unikmer_encode
doc: |-
  Encode plain k-mer texts to integers

  Tool homepage: https://github.com/shenwei356/unikmer
inputs:
  - id: all
    type: ['null', boolean]
    doc: "output all data: orginial k-mer, parsed k-mer, encoded integer, encode bits"
    inputBinding:
      position: 10
      prefix: --all
  - id: canonical
    type: ['null', boolean]
    doc: "keep the canonical k-mers"
    inputBinding:
      position: 10
      prefix: --canonical
  - id: hash
    type: ['null', boolean]
    doc: "save hash of k-mer, automatically on for k>32"
    inputBinding:
      position: 10
      prefix: --hash
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
  - id: text_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input text files with one k-mer per line."
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
