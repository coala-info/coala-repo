cwlVersion: v1.2
class: CommandLineTool
baseCommand: hatchet2bed
label: vafator_hatchet2bed
doc: "Generate copy number BED files from a HATCHet best.seg.ucn file, one file per sample with the average tumor copy number in each segment.\n\nTool homepage: https://github.com/tron-bioinformatics/vafator"
inputs:
  - id: input_file
    type: File
    doc: input *.ucn hatchet file
    inputBinding:
      position: 101
      prefix: --input-file
  - id: output_prefix
    type: string
    doc: output BED file prefix, one file will be created per sample in the input with the average tumor copy number in each segment
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: bed_files
    type:
      type: array
      items: File
    doc: one BED file per sample
    outputBinding:
      glob: |
        ${ return inputs.output_prefix + '.*.bed'; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vafator:2.2.2--pyhdfd78af_0
stdout: vafator_hatchet2bed.out
