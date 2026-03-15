cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf-convert
label: last_maf-convert
doc: Read MAF-format alignments & write them in another format.
inputs:
  - id: format
    type: string
    doc: Output format (axt, bed, blast, blasttab, blasttab+, chain, gff, html, 
      psl, sam, or tab)
    inputBinding:
      position: 1
  - id: maf_files
    type:
      type: array
      items: File
    doc: MAF-format alignment file(s)
    inputBinding:
      position: 2
  - id: subject
    type:
      - 'null'
      - string
    doc: which sequence to use as subject/reference
    inputBinding:
      position: 103
      prefix: --subject
  - id: protein
    type:
      - 'null'
      - boolean
    doc: assume protein alignments, for psl match counts
    inputBinding:
      position: 103
      prefix: --protein
  - id: join
    type:
      - 'null'
      - int
    doc: join consecutive co-linear alignments separated by <= N letters
    inputBinding:
      position: 103
      prefix: --join
  - id: join_nearest
    type:
      - 'null'
      - int
    doc: join nearest co-linear alignments separated by <= N letters
    inputBinding:
      position: 103
      prefix: --Join
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: omit any header lines from the output
    inputBinding:
      position: 103
      prefix: --noheader
  - id: dictionary
    type:
      - 'null'
      - boolean
    doc: include dictionary of sequence lengths in sam format
    inputBinding:
      position: 103
      prefix: --dictionary
  - id: dict_file
    type:
      - 'null'
      - File
    doc: get sequence dictionary from DICTFILE
    inputBinding:
      position: 103
      prefix: --dictfile
  - id: read_group
    type:
      - 'null'
      - string
    doc: read group info for sam format
    inputBinding:
      position: 103
      prefix: --readgroup
  - id: line_size
    type:
      - 'null'
      - int
    doc: line length for blast and html formats
    inputBinding:
      position: 103
      prefix: --linesize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
stdout: last_maf-convert.out
s:url: https://gitlab.com/mcfrith/last
$namespaces:
  s: https://schema.org/
