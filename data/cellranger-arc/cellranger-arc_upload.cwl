cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger-arc
  - upload
label: cellranger-arc_upload
doc: Upload files to 10x Genomics support
inputs:
  - id: your_email
    type: string
    doc: User email address
    inputBinding:
      position: 1
  - id: file
    type: File
    doc: File to upload
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger-arc:2.2.0
stdout: cellranger-arc_upload.out
s:url: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
$namespaces:
  s: https://schema.org/
