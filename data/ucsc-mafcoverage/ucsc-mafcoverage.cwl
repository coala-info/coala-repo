cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafCoverage
label: ucsc-mafcoverage
doc: "Extract coverage information from a MAF file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The database name (e.g., hg19).
    inputBinding:
      position: 1
  - id: maf_file
    type: File
    doc: The input MAF file to process.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafcoverage:482--h0b57e2e_0
stdout: ucsc-mafcoverage.out
