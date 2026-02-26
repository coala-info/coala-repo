cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - bamtag
label: umis_bamtag
doc: "Convert a BAM/SAM with fastqtransformed read names to have UMI and cellular
  barcode tags\n\nTool homepage: https://github.com/vals/umis"
inputs:
  - id: sam_file
    type: File
    doc: Input BAM/SAM file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
stdout: umis_bamtag.out
