cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - dumpHeader
label: bamutil_dumpHeader
doc: "Print SAM/BAM Header\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: input_file
    type: File
    doc: SAM/BAM file
    inputBinding:
      position: 1
outputs:
  - id: header
    type: stdout
    doc: SAM/BAM header
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
stdout: bamutil_dumpHeader.txt
