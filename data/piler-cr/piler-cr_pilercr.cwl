cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilercr
label: piler-cr_pilercr
doc: "A tool for finding CRISPR repeats in DNA sequences.\n\nTool homepage: http://www.drive5.com/pilercr/"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file in FASTA format
    inputBinding:
      position: 101
      prefix: -in
outputs:
  - id: output_file
    type: File
    doc: Report file to be written
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piler-cr:1.06--h9948957_6
