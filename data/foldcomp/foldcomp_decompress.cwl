cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldcomp
  - decompress
label: foldcomp_decompress
doc: "Decompress Foldcomp FCZ files back to PDB: one file, or a directory/tar/database of FCZ files into a directory or tar.\n\nTool homepage: https://github.com/steineggerlab/foldcomp"
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
    doc: "Output PDB file, or output directory/tar name for batch input."
    inputBinding:
      position: 11
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
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "overwrite existing files [default=false]"
    inputBinding:
      position: 1
      prefix: --overwrite
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
  - id: check
    type:
      - 'null'
      - boolean
    doc: "check FCZ before and skip entries with error (only for batch decompression)"
    inputBinding:
      position: 1
      prefix: --check
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
  - id: decompressed
    type:
      - File
      - Directory
    doc: "Decompressed PDB file, tar file, or directory of PDB files."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.listed_files ? inputs.listed_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
