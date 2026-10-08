cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldcomp
  - compress
label: foldcomp_compress
doc: "Compress protein structures (PDB/mmCIF) into the Foldcomp FCZ format: one file, or a directory/tar of files into a directory, tar or database.\n\nTool homepage: https://github.com/steineggerlab/foldcomp"
inputs:
  - id: input
    type:
      - File
      - Directory
    doc: "Input PDB/mmCIF file, a directory or tar(.gz) of structures, or (with --file) a list of files."
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: "Output FCZ file, or output directory/tar/database name for batch input."
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
  - id: alt
    type:
      - 'null'
      - boolean
    doc: "use alternative atom order [default=false]"
    inputBinding:
      position: 1
      prefix: --alt
  - id: break_interval
    type:
      - 'null'
      - int
    doc: "interval size to save absolute atom coordinates [default=25]"
    inputBinding:
      position: 1
      prefix: --break
  - id: tar
    type:
      - 'null'
      - boolean
    doc: "save as tar file [default=false]"
    inputBinding:
      position: 1
      prefix: --tar
  - id: db
    type:
      - 'null'
      - boolean
    doc: "save as database [default=false]"
    inputBinding:
      position: 1
      prefix: --db
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "overwrite existing files [default=false]"
    inputBinding:
      position: 1
      prefix: --overwrite
  - id: skip_discontinuous
    type:
      - 'null'
      - boolean
    doc: "skip PDB with with discontinuous residues (only batch compression)"
    inputBinding:
      position: 1
      prefix: --skip-discontinuous
  - id: time
    type:
      - 'null'
      - boolean
    doc: "measure time for compression/decompression"
    inputBinding:
      position: 1
      prefix: --time
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Structure files named in the --file list (staged in the working directory so the names resolve)."
outputs:
  - id: compressed
    type:
      - File
      - Directory
    doc: "Compressed FCZ file, tar file, database file, or directory of FCZ files."
    outputBinding:
      glob: $(inputs.output)
  - id: database_files
    type: File[]
    doc: "Database side files (.index, .dbtype, .lookup, .source) written with --db."
    outputBinding:
      glob: $(inputs.output).*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.listed_files ? inputs.listed_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
