cwlVersion: v1.2
class: CommandLineTool
baseCommand: postmaster
label: postmaster
doc: "\nTool homepage: https://github.com/COMBINE-lab/postmaster"
inputs:
  - id: alignments
    type:
      - 'null'
      - File
    doc: SAM or BAM alignment file written by salmon with --writeMappings (stdin if not given)
    inputBinding:
      position: 101
      prefix: --alignments
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (default 2)
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: output
    type: string
    doc: Output alignment file; the format follows the suffix (.sam or .bam).
    inputBinding:
      position: 101
      prefix: --output
  - id: quant
    type: File
    doc: quant.sf file of the corresponding salmon run
    inputBinding:
      position: 101
      prefix: --quant
outputs:
  - id: output_file
    type: File
    doc: Annotated alignments written with --output
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/postmaster:0.1.0--ha6fb395_1
