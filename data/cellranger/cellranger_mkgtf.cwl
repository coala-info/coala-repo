cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - mkgtf
label: cellranger_mkgtf
doc: Filter user-supplied GTF files for use as Cell Ranger-compatible genes 
  files for mkref tool.
inputs:
  - id: input_gtf
    type: File
    doc: Path to input genes GTF file.
    inputBinding:
      position: 1
  - id: output_gtf
    type: string
    doc: Path to filtered output genes GTF file.
    inputBinding:
      position: 2
  - id: attribute
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --attribute
          separate: true
    doc: Key-value pair in attributes field to be kept in the GTF file.
    inputBinding:
      position: 103
outputs:
  - id: out_output_gtf
    type: File
    doc: Path to filtered output genes GTF file.
    outputBinding:
      glob: $(inputs.output_gtf)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
