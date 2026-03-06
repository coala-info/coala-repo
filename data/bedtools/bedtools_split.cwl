cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - split
label: bedtools_split
doc: Split a Bed file.
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'Algorithm used to split data. size (default): uses a heuristic algorithm
      to group the items so all files contain the ~ same number of bases; simple :
      route records such that each split file has approximately equal records (like
      Unix split).'
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: input_file
    type: File
    doc: BED input file (req'd).
    inputBinding:
      position: 101
      prefix: --input
  - id: number_of_files
    type: int
    doc: Number of files to create (req'd).
    inputBinding:
      position: 101
      prefix: --number
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output BED file prefix.
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output BED file prefix.
    outputBinding:
      glob: $(inputs.prefix)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
