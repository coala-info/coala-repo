cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_format_gtf_to_bed12_ncbi.py
label: gs-tama_tama_format_gtf_to_bed12_ncbi.py
doc: "This script converts NCBI gtf to bed format. It is designed to work with all current versions. It includes CDS boundaries for the 7th and 8th columns of the bed file.\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: gtf_file
    type: File
    doc: NCBI gtf file
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
stdout: gs-tama_tama_format_gtf_to_bed12_ncbi.py.out
