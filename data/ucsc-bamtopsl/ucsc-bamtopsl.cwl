cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamToPsl
label: ucsc-bamtopsl
doc: "Convert BAM file to PSL format. (Note: The provided help text contains only
  system error messages regarding a failed container build and does not list command-line
  arguments.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bamtopsl:482--h0b57e2e_0
stdout: ucsc-bamtopsl.out
