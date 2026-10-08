cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_bed_extract_cds.py
label: gs-tama_tama_bed_extract_cds.py
doc: "This script takes a bed file with cds information and creates a bed file with only cds regions\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: bed_file
    type: File
    doc: Bed file (required)
    inputBinding:
      position: 101
      prefix: -b
  - id: stop_codon_flag
    type: string
    doc: "Stop codon include flag (required). Use include_stop to keep the stop codon in the CDS region, or no_stop to leave it out."
    inputBinding:
      position: 101
      prefix: -s
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
    doc: Bed file with only the CDS regions
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_bed_extract_cds.py.out
