cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf_sort
label: multiz_maf_sort
doc: "maf_sort: sort the alignment blocks of a MAF file by the position of one species. Usage: maf_sort maf-file species-name [unused-ali-file]. The sorted alignment goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: maf_file
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: species_name
    type: string
    doc: Species (source) name to sort by
    inputBinding:
      position: 2
  - id: unused_path
    type:
      - 'null'
      - string
    doc: File name for the unused alignment blocks
    inputBinding:
      position: 3
outputs:
  - id: sorted
    type: stdout
    doc: Sorted MAF alignment (standard output)
  - id: unused
    type:
      - 'null'
      - File
    doc: Unused alignment blocks
    outputBinding:
      glob: $(inputs.unused_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: maf_sort.maf
