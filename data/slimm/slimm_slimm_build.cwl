cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slimm
  - build
label: slimm_slimm_build
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the tool. Based on the tool
  name hint, this refers to the 'build' subcommand of SLIMM (Species Level Identification
  of Microbes from Metagenomes).\n\nTool homepage: https://github.com/seqan/slimm/blob/master/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slimm:0.3.4--hd6d6fdc_6
stdout: slimm_slimm_build.out
