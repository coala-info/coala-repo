cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldcomp
  - extract
label: foldcomp_extract
doc: "Extract the amino acid sequence or pLDDT scores from Foldcomp FCZ files (one file, or a directory/tar/database).\n\nTool homepage: https://github.com/steineggerlab/foldcomp"
inputs:
  - id: input
    type:
      - File
      - Directory
    secondaryFiles:
      - pattern: .index
        required: false
      - pattern: .dbtype
        required: false
      - pattern: .lookup
        required: false
      - pattern: .source
        required: false
    doc: "Input FCZ file, tar, directory, or Foldcomp database (with .index/.dbtype/.lookup beside it), or (with --file) a list of files."
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: "Output FASTA (or pLDDT) file, or output name for batch input."
    inputBinding:
      position: 11
  - id: plddt
    type:
      - 'null'
      - boolean
    doc: "extract pLDDT score"
    inputBinding:
      position: 1
      prefix: --plddt
  - id: plddt_digits
    type:
      - 'null'
      - int
    doc: "extract pLDDT score with specified number of digits: 1 single digit (fasta-like format), 2 2-digit (00-99; tsv), 3 3-digit, 4 4-digit (max)"
    inputBinding:
      position: 1
      prefix: --plddt-digits
  - id: amino_acid
    type:
      - 'null'
      - boolean
    doc: "extract amino acid sequence"
    inputBinding:
      position: 1
      prefix: --amino-acid
  - id: threads
    type:
      - 'null'
      - int
    doc: "threads for (de)compression of folders/tar files [default=1]"
    inputBinding:
      position: 1
      prefix: --threads
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: "recursively look for files in directory [default=0]"
    inputBinding:
      position: 1
      prefix: --recursive
  - id: file
    type:
      - 'null'
      - boolean
    doc: "input is a list of files [default=0]"
    inputBinding:
      position: 1
      prefix: --file
  - id: tar
    type:
      - 'null'
      - boolean
    doc: "save as tar file [default=false]"
    inputBinding:
      position: 1
      prefix: --tar
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: "do not merge output files"
    inputBinding:
      position: 1
      prefix: --no-merge
  - id: use_title
    type:
      - 'null'
      - boolean
    doc: "use TITLE as the output file name"
    inputBinding:
      position: 1
      prefix: --use-title
  - id: id_list
    type:
      - 'null'
      - File
    doc: "a file of id list to be processed (only for database input)"
    inputBinding:
      position: 1
      prefix: --id-list
  - id: id_mode
    type:
      - 'null'
      - int
    doc: "id mode for database input. 0: database keys, 1: names (.lookup) [default=1]"
    inputBinding:
      position: 1
      prefix: --id-mode
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "overwrite existing files [default=false]"
    inputBinding:
      position: 1
      prefix: --overwrite
  - id: time
    type:
      - 'null'
      - boolean
    doc: "measure time for compression/decompression"
    inputBinding:
      position: 1
      prefix: --time
  - id: use_cache
    type:
      - 'null'
      - boolean
    doc: "use cached index for database input [default=false]"
    inputBinding:
      position: 1
      prefix: --use-cache
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Structure files named in the --file list (staged in the working directory so the names resolve)."
outputs:
  - id: extracted
    type:
      - File
      - Directory
    doc: "Extracted sequences or pLDDT scores."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.listed_files ? inputs.listed_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
