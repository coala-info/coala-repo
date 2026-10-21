cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-bam2readdepth]
label: rsem_rsem-bam2readdepth
doc: "Compute the read depth of every transcript from a sorted BAM file.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: sorted_bam_input
    type: File
    doc: Sorted transcript BAM file.
    inputBinding:
      position: 1
  - id: readdepth_output
    type: string
    doc: Output read depth file name.
    inputBinding:
      position: 2
outputs:
  - id: readdepth
    type: File
    doc: Read depth file (one line per transcript).
    outputBinding:
      glob: $(inputs.readdepth_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
