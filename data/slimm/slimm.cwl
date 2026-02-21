cwlVersion: v1.2
class: CommandLineTool
baseCommand: slimm
label: slimm
doc: "Species Level Identification of Microbes from Metagenomes (Note: The provided
  text contains build logs and error messages rather than the tool's help documentation.
  No arguments could be extracted.)\n\nTool homepage: https://github.com/seqan/slimm/blob/master/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slimm:0.3.4--hd6d6fdc_6
stdout: slimm.out
