cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_format_gtf_to_bed12_stringtie.py
label: gs-tama_tama_format_gtf_to_bed12_stringtie.py
doc: "This script converts cufflinks/stringtie gtf into bed format file\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: gtf_file
    type: File
    doc: Cufflinks or StringTie gtf file
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
stdout: gs-tama_tama_format_gtf_to_bed12_stringtie.py.out
