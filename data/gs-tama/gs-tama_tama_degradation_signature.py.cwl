cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_degradation_signature.py
label: gs-tama_tama_degradation_signature.py
doc: "This script takes the tama collapse trans_read.bed files from a nocap run and a capped run to calculate degradation signature\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: capped_bed_file
    type: File
    doc: Bed file from capped TAMA Collapse run (required)
    inputBinding:
      position: 101
      prefix: -c
  - id: nocap_bed_file
    type: File
    doc: Bed file from no_cap TAMA Collapse run (required)
    inputBinding:
      position: 101
      prefix: -nc
  - id: output_file_name
    type: string
    doc: Output file name (required)
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Degradation signature report
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_degradation_signature.py.out
