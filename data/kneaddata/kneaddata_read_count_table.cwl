cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kneaddata_read_count_table
label: kneaddata_read_count_table
doc: "Create a table of read counts for all samples\n\nTool homepage: https://huttenhower.sph.harvard.edu/kneaddata"
inputs:
  - id: input
    type: Directory
    doc: the input folder with kneaddata log files
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path
    type: string
    doc: the output file to write
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type: File
    doc: table of read counts for all samples
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kneaddata:0.12.4--pyhdfd78af_0
