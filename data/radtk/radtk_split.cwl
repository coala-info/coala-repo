cwlVersion: v1.2
class: CommandLineTool
baseCommand: radtk_split
label: radtk_split
doc: "split an input RAD file into multiple output files\n\nTool homepage: https://github.com/COMBINE-lab/radtk"
inputs:
  - id: input
    type: File
    doc: input RAD file to split
    inputBinding:
      position: 101
      prefix: --input
  - id: num_reads
    type: int
    doc: 'approximate number of reads in each sub-RAD file (Note: This is approximate
      because file chunks will not be split and input chunks will reside entirely
      within a single output file)'
    inputBinding:
      position: 101
      prefix: --num-reads
  - id: output_prefix
    type: string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet (no progress bar or standard output messages)
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radtk:0.2.0--ha6fb395_1
stdout: radtk_split.out
