cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agg
  - anno
label: agg_anno
doc: "Annotate BCF files with filters and trusted variant regions\n\nTool homepage:
  https://github.com/Illumina/agg"
inputs:
  - id: input_file
    type: File
    doc: Input BCF file
    inputBinding:
      position: 1
  - id: include
    type:
      - 'null'
      - string
    doc: filters to apply eg. -i 'QUAL>=10 && DP<100000 && HWE<10'
    inputBinding:
      position: 102
      prefix: --include
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed'
    inputBinding:
      position: 102
      prefix: --output-type
  - id: regions
    type:
      - 'null'
      - File
    doc: a set of variants that are trusted (eg. 1000G)
    inputBinding:
      position: 102
      prefix: --regions
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agg:0.3.6--hd28b015_0
