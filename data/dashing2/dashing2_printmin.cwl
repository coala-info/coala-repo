cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing2
  - printmin
label: dashing2_printmin
doc: "Prints the minimum sketch size for a given k-mer size and sketch size.\n\nTool
  homepage: https://github.com/dnbaker/dashing2"
inputs:
  - id: kmer_size
    type: int
    doc: The k-mer size.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing2:2.1.20--he9e5f93_0
stdout: dashing2_printmin.out
