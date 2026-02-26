cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_filter_primary_transcripts_orf.py
label: gs-tama_tama_filter_primary_transcripts_orf.py
doc: "This script uses the ORF/NMD output bed file and filters to have only 1\ntranscript
  per gene\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: bed_file
    type: File
    doc: bed file (required)
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: output_file
    type: File
    doc: Output file name (required)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
