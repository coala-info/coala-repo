cwlVersion: v1.2
class: CommandLineTool
baseCommand: faSplit
label: ucsc-fasplit
doc: "Split an fa file into several files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: how
    type:
      type: enum
      symbols:
        - about
        - byname
        - base
        - gap
        - sequence
        - size
    doc: "How to split: 'about', 'byname', 'base', 'gap', 'sequence' or 'size'"
    inputBinding:
      position: 1
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 2
  - id: count
    type:
      - 'null'
      - int
    doc: Number of files (sequence, base), bases per piece (size, gap) or bytes per file (about). Not used with byname.
    inputBinding:
      position: 3
  - id: out_root
    type: string
    doc: Prefix of the output files. With byname, give a directory name that ends with / (it is created before the run).
    inputBinding:
      position: 4
  - id: verbose
    type:
      - 'null'
      - int
    doc: Write names of each file created (2) or more details (3)
    inputBinding:
      position: 101
      prefix: -verbose=
      separate: false
  - id: max_n
    type:
      - 'null'
      - int
    doc: Suppress pieces with more than maxN n's. Only used with size.
    inputBinding:
      position: 101
      prefix: -maxN=
      separate: false
  - id: one_file
    type:
      - 'null'
      - boolean
    doc: Put output in one file. Only used with size.
    inputBinding:
      position: 101
      prefix: -oneFile
  - id: extra
    type:
      - 'null'
      - int
    doc: Add N extra bytes at the end to form overlapping pieces. Only used with size.
    inputBinding:
      position: 101
      prefix: -extra=
      separate: false
  - id: out_file
    type:
      - 'null'
      - File
    doc: Get masking from this out file. Only used with size.
    inputBinding:
      position: 101
      prefix: -out=
      separate: false
  - id: lift_file
    type:
      - 'null'
      - string
    doc: Name of a lift file with info on how to reconstruct the sequence from pieces. Only used with size and gap.
    inputBinding:
      position: 101
      prefix: -lift=
      separate: false
  - id: min_gap_size
    type:
      - 'null'
      - int
    doc: Consider a block of Ns to be a gap if block size >= X. Default 1000. Only used with gap.
    inputBinding:
      position: 101
      prefix: -minGapSize=
      separate: false
  - id: no_gap_drops
    type:
      - 'null'
      - boolean
    doc: Include all N's when splitting by gap.
    inputBinding:
      position: 101
      prefix: -noGapDrops
  - id: out_dir_depth
    type:
      - 'null'
      - int
    doc: Create N levels of output directory under the current dir.
    inputBinding:
      position: 101
      prefix: -outDirDepth=
      separate: false
  - id: prefix_length
    type:
      - 'null'
      - int
    doc: Used with byname. Create a separate output file for each group of sequence names with the same prefix of length N.
    inputBinding:
      position: 101
      prefix: -prefixLength=
      separate: false
outputs:
  - id: pieces
    type: 'File[]'
    doc: Split FASTA files
    outputBinding:
      glob: $(inputs.out_root)*.fa
  - id: lift
    type:
      - 'null'
      - File
    doc: Lift file
    outputBinding:
      glob: $(inputs.lift_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - |
        ${
          var r = inputs.out_root;
          if (r.length > 1 && r.charAt(r.length - 1) == '/') {
            return {class: 'Directory', basename: r.substring(0, r.length - 1), listing: [], writable: true};
          }
          return null;
        }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fasplit:482--h0b57e2e_0
