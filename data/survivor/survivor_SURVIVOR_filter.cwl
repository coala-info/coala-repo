cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - filter
label: survivor_filter
doc: "Filter a VCF file based on size and/or regions to ignore\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: min_size
    type: int
    doc: "Min SV size (-1 to disable)."
    inputBinding:
      position: 3
  - id: max_size
    type: int
    doc: "Max SV size (-1 to disable)."
    inputBinding:
      position: 4
  - id: min_af
    type: float
    doc: "Min allele frequency (0-1)."
    inputBinding:
      position: 5
  - id: min_support
    type: int
    doc: "Min number of reads support: RE flag (-1 to disable)."
    inputBinding:
      position: 6
  - id: output
    type: string
    doc: "Output vcf file."
    inputBinding:
      position: 7
  - id: vcf
    type: File
    doc: VCF file to filter.
    inputBinding:
      position: 1
  - id: ignore_regions
    type:
      - 'null'
      - File
    doc: BED file with regions to ignore (NA is passed when not given, which disables it).
arguments:
  - position: 2
    valueFrom: '$(inputs.ignore_regions ? inputs.ignore_regions.path : "NA")'
outputs:
  - id: filtered_vcf
    type: File
    doc: "Filtered VCF."
    outputBinding:
      glob: '$(inputs.output)'
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_filter.out
