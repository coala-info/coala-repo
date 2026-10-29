cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - stratify
label: truvari_stratify
doc: "Count variants which start and end within each bed region\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: output
    type:
      - 'null'
      - string
    default: stratify.bed
    doc: Output bed-like file
    inputBinding:
      position: 1
      prefix: "-o"
  - id: header
    type:
      - 'null'
      - boolean
    doc: Input regions have header to preserve in output
    inputBinding:
      position: 1
      prefix: "-H"
  - id: complement
    type:
      - 'null'
      - boolean
    doc: Only count variants not within region boundaries
    inputBinding:
      position: 1
      prefix: "-v"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: bed
    type: File
    doc: Regions to process
    inputBinding:
      position: 2
  - id: vcf
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: A single VCF to count (give this or bench_dir)
    inputBinding:
      position: 3
  - id: bench_dir
    type:
      - 'null'
      - Directory
    doc: Truvari bench result directory (give this or vcf)
    inputBinding:
      position: 3
outputs:
  - id: output_bed
    type: File
    doc: Bed-like file of region counts
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
