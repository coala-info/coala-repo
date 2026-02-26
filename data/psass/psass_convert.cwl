cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psass
  - convert
label: psass_convert
doc: "Convert samtools pileup output to PSASS format\n\nTool homepage: https://github.com/RomainFeron/PSASS"
inputs:
  - id: input
    type: File
    doc: Either a path to a samtools pileup output file or "-" for stdin
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write to an output file instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psass:3.1.0--hf5e1c6e_4
