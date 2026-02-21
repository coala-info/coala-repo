cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2-hisat-3n-build
label: hisat2_hisat-3n-build
doc: "HISAT2 index builder for 3-nucleotide (3N) aware alignment. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: http://daehwankimlab.github.io/hisat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
stdout: hisat2_hisat-3n-build.out
