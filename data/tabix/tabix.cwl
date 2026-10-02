cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabix
label: tabix
doc: Generic indexer for TAB-delimited genome position files
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: Input TAB-delimited file
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) to query
    inputBinding:
      position: 2
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: coordinates are zero-based
    inputBinding:
      position: 103
      prefix: --zero-based
  - id: begin
    type:
      - 'null'
      - int
    doc: column number for region start
    inputBinding:
      position: 103
      prefix: --begin
  - id: comment
    type:
      - 'null'
      - string
    doc: skip comment lines starting with CHAR
    inputBinding:
      position: 103
      prefix: --comment
  - id: csi
    type:
      - 'null'
      - boolean
    doc: generate CSI index for VCF (default is TBI)
    inputBinding:
      position: 103
      prefix: --csi
  - id: end
    type:
      - 'null'
      - int
    doc: column number for region end (if no end, set INT to -b)
    inputBinding:
      position: 103
      prefix: --end
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing index without asking
    inputBinding:
      position: 103
      prefix: --force
  - id: min_shift
    type:
      - 'null'
      - int
    doc: set minimal interval size for CSI indices to 2^INT
    inputBinding:
      position: 103
      prefix: --min-shift
  - id: preset
    type:
      - 'null'
      - string
    doc: gff, bed, sam, vcf
    inputBinding:
      position: 103
      prefix: --preset
  - id: sequence
    type:
      - 'null'
      - int
    doc: column number for sequence names (suppressed by -p)
    inputBinding:
      position: 103
      prefix: --sequence
  - id: skip_lines
    type:
      - 'null'
      - int
    doc: skip first INT lines
    inputBinding:
      position: 103
      prefix: --skip-lines
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: print also the header lines
    inputBinding:
      position: 103
      prefix: --print-header
  - id: only_header
    type:
      - 'null'
      - boolean
    doc: print only the header lines
    inputBinding:
      position: 103
      prefix: --only-header
  - id: list_chroms
    type:
      - 'null'
      - boolean
    doc: list chromosome names
    inputBinding:
      position: 103
      prefix: --list-chroms
  - id: reheader
    type:
      - 'null'
      - File
    doc: replace the header with the content of FILE
    inputBinding:
      position: 103
      prefix: --reheader
  - id: regions_file
    type:
      - 'null'
      - File
    doc: restrict to regions listed in the file
    inputBinding:
      position: 103
      prefix: --regions
  - id: targets
    type:
      - 'null'
      - File
    doc: similar to -R but streams rather than index-jumps
    inputBinding:
      position: 103
      prefix: --targets
  - id: no_download
    type:
      - 'null'
      - boolean
    doc: do not download the index file
    inputBinding:
      position: 103
      prefix: -D
  - id: cache
    type:
      - 'null'
      - int
    doc: set cache size to INT megabytes (0 disables)
    inputBinding:
      position: 103
      prefix: --cache
  - id: separate_regions
    type:
      - 'null'
      - boolean
    doc: separate the output by corresponding regions
    inputBinding:
      position: 103
      prefix: --separate-regions
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabix:1.11--hdfd78af_0
stdout: tabix.out
s:url: https://sourceforge.net/projects/samtools
$namespaces:
  s: https://schema.org/
