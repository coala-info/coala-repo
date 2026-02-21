cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - multiinter
label: bedtools_multiinter
doc: "Identifies common intervals among multiple BED/GFF/VCF files.\n\nTool homepage:
  http://bedtools.readthedocs.org/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Names of the BAM/BED/GFF/VCF file(s) to combine.
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_multiinter.out
