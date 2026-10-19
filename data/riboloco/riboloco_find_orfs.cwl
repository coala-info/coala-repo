cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboloco_find_orfs
label: riboloco_find_orfs
doc: "Find open reading frames in a transcriptome FASTA; the table can be passed
  to riboloco with --orf_file.\n\nTool homepage: https://github.com/Delayed-Gitification/riboloco.git"
inputs:
  - id: fasta
    type: File
    doc: Transcriptome fasta - can be generated with riboloco_convert_gtf
    inputBinding:
      position: 101
      prefix: --fasta
  - id: info
    type: File
    doc: A info file with transcript details - can also be generated with 
      riboloco_convert_gtf
    inputBinding:
      position: 101
      prefix: --info
  - id: output_directory
    type:
      - 'null'
      - string
    doc: The directory to save outputs.
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: output
    type: string
    doc: Output file
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: orf_table
    type:
      - 'null'
      - File
    doc: ORF table (when no output directory is given)
    outputBinding:
      glob: $(inputs.output)
  - id: orf_directory
    type:
      - 'null'
      - Directory
    doc: Output directory (when --output_directory is given)
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboloco:0.3.10--pyhdfd78af_0
