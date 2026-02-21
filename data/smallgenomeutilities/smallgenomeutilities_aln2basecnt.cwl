cwlVersion: v1.2
class: CommandLineTool
baseCommand: aln2basecnt
label: smallgenomeutilities_aln2basecnt
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message indicating a failure to fetch the
  OCI image.\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_aln2basecnt.out
