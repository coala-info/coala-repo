cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf-convert
label: last-align_maf-convert
doc: "Read MAF-format alignments & write them in another format.\n\nTool homepage:
  https://gitlab.com/mcfrith/last"
inputs:
  - id: output_format
    type: string
    doc: Output format (axt, blast, blasttab, chain, html, psl, sam, tab)
    inputBinding:
      position: 1
  - id: maf_files
    type:
      type: array
      items: File
    doc: Input MAF file(s)
    inputBinding:
      position: 2
  - id: dictfile
    type:
      - 'null'
      - File
    doc: get sequence dictionary from DICTFILE
    inputBinding:
      position: 103
      prefix: --dictfile
  - id: dictionary
    type:
      - 'null'
      - boolean
    doc: include dictionary of sequence lengths in sam format
    inputBinding:
      position: 103
      prefix: --dictionary
  - id: join
    type:
      - 'null'
      - int
    doc: join co-linear alignments separated by <= N letters
    inputBinding:
      position: 103
      prefix: --join
  - id: linesize
    type:
      - 'null'
      - int
    doc: line length for blast and html formats
    inputBinding:
      position: 103
      prefix: --linesize
  - id: noheader
    type:
      - 'null'
      - boolean
    doc: omit any header lines from the output
    inputBinding:
      position: 103
      prefix: --noheader
  - id: protein
    type:
      - 'null'
      - boolean
    doc: assume protein alignments, for psl match counts
    inputBinding:
      position: 103
      prefix: --protein
  - id: readgroup
    type:
      - 'null'
      - string
    doc: read group info for sam format
    inputBinding:
      position: 103
      prefix: --readgroup
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/last-align:v963-2-deb_cv1
stdout: last-align_maf-convert.out
