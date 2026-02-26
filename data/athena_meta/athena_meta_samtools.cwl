cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: athena_meta_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/abishara/athena_meta/"
inputs:
  - id: command
    type: string
    doc: samtools command to execute
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the samtools command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/athena_meta:1.3--py27_0
stdout: athena_meta_samtools.out
