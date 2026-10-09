cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot.sg_generation
label: knot-asm-analysis_knot.sg_generation
doc: "Keep only the reads mapped on the assembly (reads2contig PAF) and write them to a new fasta file\n\nTool homepage: https://github.com/natir/knot"
inputs:
  - id: reads2contig
    type: File
    doc: read mapped against the assembly (PAF)
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: input reads fasta
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: output fasta
    inputBinding:
      position: 3
outputs:
  - id: filtered_reads
    type: File
    doc: filtered reads
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
