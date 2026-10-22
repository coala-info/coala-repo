cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tigmint-ntlink-map
label: tigmint_tigmint-ntlink-map
doc: "Run ntLink mapping, then output a filtered and sorted BED file with mapping extents\n\nTool homepage: https://github.com/bcgsc/tigmint"
inputs:
  - id: target
    type: File
    doc: "Draft assembly to scaffold (FASTA). It is staged as <name>.fa and the tool is given the name without .fa"
    inputBinding:
      position: 1
      valueFrom: $(self.nameroot)
  - id: reads
    type: File
    doc: "Long reads file"
    inputBinding:
      position: 2
  - id: bed
    type: string
    doc: "Name for output BED file with mapping extents"
    inputBinding:
      position: 100
      prefix: --bed
  - id: k
    type: int
    doc: "K-mer size (bp)"
    inputBinding:
      position: 101
      prefix: -k
  - id: w
    type: int
    doc: "Window size"
    inputBinding:
      position: 102
      prefix: -w
  - id: t
    type:
      - 'null'
      - int
    doc: "Number of threads [4]"
    inputBinding:
      position: 103
      prefix: -t
  - id: path
    type:
      - 'null'
      - string
    doc: "Path to directory with tigmint-fiter-paf executable, if not in PATH"
    inputBinding:
      position: 104
      prefix: --path
  - id: m
    type:
      - 'null'
      - int
    doc: "Minimum size for mapping block (bp) [2000]"
    inputBinding:
      position: 105
      prefix: -m
  - id: span
    type: string
    doc: "Span value specified for tigmint-cut"
    inputBinding:
      position: 106
      prefix: --span
outputs:
  - id: output_bed
    type: File
    doc: "BED file with mapping extents"
    outputBinding:
      glob: $(inputs.bed)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.target)
        entryname: $(inputs.target.nameroot).fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
