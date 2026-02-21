cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedClip
label: ucsc-bedclip
doc: "The provided text does not contain help information as it is an error log indicating
  a failure to build the container image (no space left on device). Under normal circumstances,
  bedClip is used to remove lines from a BED file that refer to nucleotides outside
  of a chromosome's boundaries.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedclip:482--h0b57e2e_0
stdout: ucsc-bedclip.out
