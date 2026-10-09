cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabix
label: htslib_tabix
doc: "Generic indexer for TAB-delimited genome position files. Without a region it indexes a bgzip-compressed file; with regions it prints the records that overlap them.\n\nTool homepage: https://github.com/samtools/htslib"
inputs:
  - id: input_file
    type: File
    doc: The TAB-delimited file (bgzip compressed) to be indexed or queried
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
    inputBinding:
      position: 200
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional region(s) to query (for example chr1:10-20)
    inputBinding:
      position: 201
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: coordinates are zero-based
    inputBinding:
      position: 101
      prefix: --zero-based
  - id: begin_col
    type:
      - 'null'
      - int
    doc: column number for region start [4]
    inputBinding:
      position: 101
      prefix: -b
  - id: comment_char
    type:
      - 'null'
      - string
    doc: skip comment lines starting with CHAR
    inputBinding:
      position: 101
      prefix: -c
  - id: csi
    type:
      - 'null'
      - boolean
    doc: generate CSI index for VCF (default is TBI)
    inputBinding:
      position: 101
      prefix: --csi
  - id: end_col
    type:
      - 'null'
      - int
    doc: column number for region end (if no end, set INT to -b) [5]
    inputBinding:
      position: 101
      prefix: -e
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing index without asking
    inputBinding:
      position: 101
      prefix: -f
  - id: min_shift
    type:
      - 'null'
      - int
    doc: set minimal interval size for CSI indices to 2^INT [14]
    inputBinding:
      position: 101
      prefix: --min-shift
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Input format: gff, bed, sam, vcf'
    inputBinding:
      position: 101
      prefix: -p
  - id: sequence_col
    type:
      - 'null'
      - int
    doc: column number for sequence names (suppressed by -p) [1]
    inputBinding:
      position: 101
      prefix: -s
  - id: skip_lines
    type:
      - 'null'
      - int
    doc: skip first INT lines [0]
    inputBinding:
      position: 101
      prefix: -S
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: print also the header lines
    inputBinding:
      position: 101
      prefix: --print-header
  - id: only_header
    type:
      - 'null'
      - boolean
    doc: print only the header lines
    inputBinding:
      position: 101
      prefix: --only-header
  - id: list_chroms
    type:
      - 'null'
      - boolean
    doc: list chromosome names
    inputBinding:
      position: 101
      prefix: --list-chroms
  - id: reheader
    type:
      - 'null'
      - File
    doc: replace the header with the content of FILE
    inputBinding:
      position: 101
      prefix: --reheader
  - id: regions
    type:
      - 'null'
      - File
    doc: restrict to regions listed in the file
    inputBinding:
      position: 101
      prefix: --regions
  - id: targets
    type:
      - 'null'
      - File
    doc: similar to --regions but streams rather than index-jumps
    inputBinding:
      position: 101
      prefix: --targets
  - id: do_not_download_index
    type:
      - 'null'
      - boolean
    doc: do not download the index file
    inputBinding:
      position: 101
      prefix: -D
  - id: cache
    type:
      - 'null'
      - int
    doc: set cache size to INT megabytes (0 disables) [10]
    inputBinding:
      position: 101
      prefix: --cache
  - id: separate_regions
    type:
      - 'null'
      - boolean
    doc: separate the output by corresponding regions
    inputBinding:
      position: 101
      prefix: --separate-regions
  - id: verbosity
    type:
      - 'null'
      - int
    doc: set verbosity [3]
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Records overlapping the requested regions, or the chromosome list or header
  - id: indexed
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
    doc: Compressed input file with the tabix index (.tbi or .csi) attached as a secondary file.
    outputBinding:
      glob: $(inputs.input_file.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabix:1.11--hdfd78af_0
stdout: htslib_tabix.out
