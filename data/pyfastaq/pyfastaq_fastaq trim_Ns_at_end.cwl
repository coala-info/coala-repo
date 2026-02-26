cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfastaq
  - fastaq
  - trim_Ns_at_end
label: pyfastaq_fastaq trim_Ns_at_end
doc: "Remove Ns from the ends of sequences.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: trim_both
    type:
      - 'null'
      - boolean
    doc: Trim Ns from both ends (default)
    inputBinding:
      position: 102
      prefix: --both
  - id: trim_end
    type:
      - 'null'
      - boolean
    doc: Trim Ns from end only
    inputBinding:
      position: 102
      prefix: --end
  - id: trim_start
    type:
      - 'null'
      - boolean
    doc: Trim Ns from start only
    inputBinding:
      position: 102
      prefix: --start
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FASTA/FASTQ file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
