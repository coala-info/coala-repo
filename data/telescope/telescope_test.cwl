cwlVersion: v1.2
class: CommandLineTool
baseCommand: telescope assign
label: telescope_test
doc: "Assigns reads to genomic features.\n\nTool homepage: https://github.com/mlbendall/telescope"
inputs:
  - id: alignment_bam
    type: File
    doc: Path to the alignment BAM file.
    inputBinding:
      position: 1
  - id: annotation_gtf
    type: File
    doc: Path to the annotation GTF file.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telescope:1.0.3--py36h14c3975_0
stdout: telescope_test.out
