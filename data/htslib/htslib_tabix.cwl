cwlVersion: v1.2
class: CommandLineTool
label: htslib_tabix
doc: Generic indexer for TAB-delimited genome position files
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: $(inputs.input_file.basename)
    entry: $(inputs.input_file)
- class: InlineJavascriptRequirement
baseCommand: tabix
inputs:
- id: input_file
  type: File
  doc: Input TAB-delimited file
  inputBinding:
    position: 100
    valueFrom: $(self.basename)
- id: regions
  type: string[]?
  doc: Region(s) to query
  inputBinding:
    position: 101
- id: begin
  type: int?
  doc: column number for region start
  inputBinding:
    position: 1
    prefix: --begin
- id: cache
  type: int?
  doc: set cache size to INT megabytes (0 disables)
  inputBinding:
    position: 1
    prefix: --cache
- id: comment
  type: string?
  doc: skip comment lines starting with CHAR
  inputBinding:
    position: 1
    prefix: --comment
- id: csi
  type: boolean?
  doc: generate CSI index for VCF (default is TBI)
  inputBinding:
    position: 1
    prefix: --csi
- id: end
  type: int?
  doc: column number for region end (if no end, set INT to -b)
  inputBinding:
    position: 1
    prefix: --end
- id: force
  type: boolean?
  doc: overwrite existing index without asking
  inputBinding:
    position: 1
    prefix: --force
- id: list_chroms
  type: boolean?
  doc: list chromosome names
  inputBinding:
    position: 1
    prefix: --list-chroms
- id: min_shift
  type: int?
  doc: set minimal interval size for CSI indices to 2^INT
  inputBinding:
    position: 1
    prefix: --min-shift
- id: no_download
  type: boolean?
  doc: do not download the index file
  inputBinding:
    position: 1
    prefix: -D
- id: only_header
  type: boolean?
  doc: print only the header lines
  inputBinding:
    position: 1
    prefix: --only-header
- id: preset
  type: string?
  doc: gff, bed, sam, vcf, gaf
  inputBinding:
    position: 1
    prefix: --preset
- id: print_header
  type: boolean?
  doc: print also the header lines
  inputBinding:
    position: 1
    prefix: --print-header
- id: regions_file
  type: File?
  doc: restrict to regions listed in the file
  inputBinding:
    position: 1
    prefix: --regions
- id: reheader
  type: File?
  doc: replace the header with the content of FILE
  inputBinding:
    position: 1
    prefix: --reheader
- id: separate_regions
  type: boolean?
  doc: separate the output by corresponding regions
  inputBinding:
    position: 1
    prefix: --separate-regions
- id: sequence
  type: int?
  doc: column number for sequence names (suppressed by -p)
  inputBinding:
    position: 1
    prefix: --sequence
- id: skip_lines
  type: int?
  doc: skip first INT lines
  inputBinding:
    position: 1
    prefix: --skip-lines
- id: targets
  type: File?
  doc: similar to -R but streams rather than index-jumps
  inputBinding:
    position: 1
    prefix: --targets
- id: threads
  type: int?
  doc: number of additional threads to use
  inputBinding:
    position: 1
    prefix: --threads
- id: zero_based
  type: boolean?
  doc: coordinates are zero-based
  inputBinding:
    position: 1
    prefix: --zero-based
outputs:
- id: stdout
  type: stdout
  doc: Standard output
- id: index
  type: File?
  outputBinding:
    glob: '$(inputs.input_file.basename + (inputs.csi ? ''.csi'' : ''.tbi''))'
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/htslib:1.23--h566b1c6_0
stdout: htslib_tabix.out
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/htslib