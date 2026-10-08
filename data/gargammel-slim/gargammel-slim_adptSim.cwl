cwlVersion: v1.2
class: CommandLineTool
baseCommand: adptSim
label: gargammel-slim_adptSim
doc: "This program reads a fasta file containing aDNA fragments and splits them into
  two records, one containing the forward read and the second containing the reverse
  read (-fr,-rr) or into a single for single-end mode (-fr)\n\nTool homepage: https://github.com/grenaud/gargammel"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: BAM/fasta file
    inputBinding:
      position: 200
  - id: append_name
    type:
      - 'null'
      - boolean
    doc: Append BAM tags or to deflines if adapters are added
    inputBinding:
      position: 102
      prefix: -name
  - id: append_tag
    type:
      - 'null'
      - string
    doc: Append this string to deflines or BAM tags
    inputBinding:
      position: 102
      prefix: -tag
  - id: forward_read_adapter
    type:
      - 'null'
      - string
    doc: Adapter that is observed after the forward read
    inputBinding:
      position: 102
      prefix: -f
  - id: read_length
    type:
      - 'null'
      - int
    doc: Desired read length
    inputBinding:
      position: 102
      prefix: -l
  - id: reverse_read_adapter
    type:
      - 'null'
      - string
    doc: Adapter that is observed after the reverse read
    inputBinding:
      position: 102
      prefix: -s
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Produce uncompressed BAM (good for unix pipe)
    inputBinding:
      position: 102
      prefix: -u
  - id: output_art_paired_end_path
    type:
      - 'null'
      - string
    doc: "[out]\t\tOutput reads as ART (unzipped fasta) (Default: /dev/null) with
      wrap-around for paired-end mode"
    inputBinding:
      position: 103
      prefix: -artp
  - id: output_art_single_end_path
    type:
      - 'null'
      - string
    doc: 'Output single-end reads as ART (unzipped fasta) (Default: /dev/null)'
    inputBinding:
      position: 104
      prefix: -arts
  - id: output_forward_read_path
    type:
      - 'null'
      - string
    doc: "[out fwdr]\tOutput forward read as zipped fasta (Default: )"
    inputBinding:
      position: 105
      prefix: -fr
  - id: output_reverse_read_path
    type:
      - 'null'
      - string
    doc: "[out rwdr]\tOutput reverse read as zipped fasta (Default: /dev/null)"
    inputBinding:
      position: 106
      prefix: -rr
  - id: read_bam_output_paired_end_path
    type:
      - 'null'
      - string
    doc: Read BAM and write output as a paired-end BAM (-bp)
    inputBinding:
      position: 107
      prefix: -bp
  - id: read_bam_output_single_end_path
    type:
      - 'null'
      - string
    doc: Read BAM and write output as a single-end BAM (-bs)
    inputBinding:
      position: 108
      prefix: -bs
outputs:
  - id: output_art_single_end
    type:
      - 'null'
      - File
    doc: Output single-end reads as ART (unzipped fasta)
    outputBinding:
      glob: $(inputs.output_art_single_end_path)
  - id: output_art_paired_end
    type:
      - 'null'
      - File
    doc: Output reads as ART (unzipped fasta) with wrap-around for paired-end 
      mode
    outputBinding:
      glob: $(inputs.output_art_paired_end_path)
  - id: output_forward_read
    type:
      - 'null'
      - File
    doc: Output forward read as zipped fasta
    outputBinding:
      glob: $(inputs.output_forward_read_path)
  - id: output_reverse_read
    type:
      - 'null'
      - File
    doc: Output reverse read as zipped fasta
    outputBinding:
      glob: $(inputs.output_reverse_read_path)
  - id: read_bam_output_single_end
    type:
      - 'null'
      - File
    doc: Read BAM and write output as a single-end BAM
    outputBinding:
      glob: $(inputs.read_bam_output_single_end_path)
  - id: read_bam_output_paired_end
    type:
      - 'null'
      - File
    doc: Read BAM and write output as a paired-end BAM
    outputBinding:
      glob: $(inputs.read_bam_output_paired_end_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
