cwlVersion: v1.2
class: CommandLineTool
baseCommand: msa4u
label: msa4u
doc: "Simple visualisation tool for Multiple Sequence Alignments.\n\nTool homepage:
  https://github.com/GCA-VH-lab/msa4u"
inputs:
  - id: config_file
    type:
      - 'null'
      - string
    doc: "Path to a configuration file or name of a premade config file\n[default:
      standard]."
    inputBinding:
      position: 101
      prefix: -c
  - id: data
    type:
      - 'null'
      - boolean
    doc: "Creates the 'uorf4u_data' folder in the current working directory.\nThe
      folder contains adjustable configuration files used by msa4u\n(e.g. config,
      palettes...)"
    inputBinding:
      position: 101
      prefix: --data
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Provide detailed stack trace for debugging purposes.
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_fasta_aligned
    type: File
    doc: Path to a fasta file with aligned sequences.
    inputBinding:
      position: 101
      prefix: -aln
  - id: input_fasta_unaligned
    type: File
    doc: "Path to a fasta file with unaligned sequences.\nAlignment will be performed
      with mafft:\n[mafft --auto input.fa > input.aln.fa]"
    inputBinding:
      position: 101
      prefix: -fa
  - id: label_style
    type:
      - 'null'
      - string
    doc: "Label style based on input fasta file.\nid: sequence id from header (after
      > and before first space)\ndescription: after first space on header\nall: both
      (all header string)"
    inputBinding:
      position: 101
      prefix: -label
  - id: linux
    type:
      - 'null'
      - boolean
    doc: "Replaces the mafft path in the pre-made config file from the MacOS'\nversion
      [default] to the Linux'."
    inputBinding:
      position: 101
      prefix: --linux
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show progress messages.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: "Sequence type\n[default: auto; detected by used alphabet]"
    inputBinding:
      position: 101
      prefix: -st
outputs:
  - id: alignment_output_filename
    type:
      - 'null'
      - File
    doc: "Alignment output filename.\n(used only if input is unaligned sequences)\n\
      [default: auto; based on input file name]"
    outputBinding:
      glob: $(inputs.alignment_output_filename)
  - id: visualisation_output_filename
    type:
      - 'null'
      - File
    doc: "Aligment visualisation filename.\n[default: auto; based on input file name]"
    outputBinding:
      glob: $(inputs.visualisation_output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msa4u:0.4.0--pyh7e72e81_0
