cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - gc
label: seqtk_gc
doc: "Identify GC-rich or AT-rich regions in a FASTA file\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: identify_high_at
    type:
      - 'null'
      - boolean
    doc: identify high-AT regions
    inputBinding:
      position: 102
      prefix: -w
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: min GC fraction (or AT fraction for -w)
    inputBinding:
      position: 102
      prefix: -f
  - id: min_region_length
    type:
      - 'null'
      - int
    doc: min region length to output
    inputBinding:
      position: 102
      prefix: -l
  - id: x_dropoff
    type:
      - 'null'
      - float
    doc: X-dropoff
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_gc.out
