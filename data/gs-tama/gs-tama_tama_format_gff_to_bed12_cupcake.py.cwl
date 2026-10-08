cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_format_gff_to_bed12_cupcake.py
label: gs-tama_tama_format_gff_to_bed12_cupcake.py
doc: "This script converts Cupcake collapsed.gff to bed12 format\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: gff_file
    type: File
    doc: Cupcake collapsed gff file
    inputBinding:
      position: 1
  - id: output_file_name
    type: string
    doc: Output file name
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Bed12 file
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_format_gff_to_bed12_cupcake.py.out
