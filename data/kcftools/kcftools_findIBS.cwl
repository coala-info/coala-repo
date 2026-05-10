cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcftools_findIBS
label: kcftools_findIBS
doc: "Find IBS windows in a KCF file\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
inputs:
  - id: bed_file
    type:
      - 'null'
      - boolean
    doc: Write bed file
    inputBinding:
      position: 101
      prefix: --bed
  - id: detect_variable_regions
    type:
      - 'null'
      - boolean
    doc: Detect Variable Regions instead of IBS
    inputBinding:
      position: 101
      prefix: --var
  - id: input_file
    type: File
    doc: Input KCF file name
    inputBinding:
      position: 101
      prefix: --input
  - id: min_consecutive
    type:
      - 'null'
      - int
    doc: Minimum number of consecutive windows
    inputBinding:
      position: 101
      prefix: --min
  - id: score_cut_off
    type:
      - 'null'
      - float
    doc: Score cut-off
    inputBinding:
      position: 101
      prefix: --score
  - id: summary_file
    type:
      - 'null'
      - boolean
    doc: Write summary tsv file
    inputBinding:
      position: 101
      prefix: --summary
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Output KCF file name
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
