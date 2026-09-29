cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - upload
label: cellranger_upload
doc: Upload a file with cellranger
inputs:
  - id: email
    type: string
    doc: Your email address
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
    dockerPull: cumulusprod/cellranger:10.1.0
stdout: cellranger_upload.out
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
