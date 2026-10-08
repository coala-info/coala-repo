cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_nucleotide_changer
label: fastx_toolkit_fasta_nucleotide_changer
doc: "Change nucleotides in a FASTA/Q file: DNA to RNA (T to U) or RNA to DNA (U to T).\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: "Compress output with GZIP."
    inputBinding:
      position: 101
      prefix: -z
  - id: dna_to_rna
    type:
      - 'null'
      - boolean
    doc: "DNA-to-RNA mode - change T's into U's."
    inputBinding:
      position: 101
      prefix: -r
  - id: input_file
    type:
      - 'null'
      - File
    doc: "FASTA/Q input file. Default is STDIN."
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file_path
    type: string
    doc: "Output or path parameter `output_file_path`"
    inputBinding:
      position: 102
      prefix: -o
  - id: rna_to_dna
    type:
      - 'null'
      - boolean
    doc: "RNA-to-DNA mode - change U's into T's."
    inputBinding:
      position: 101
      prefix: -d
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose mode. Prints a short summary. With [-o], the summary is printed to STDOUT. Otherwise, the summary is printed to STDERR."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "FASTA/Q output file. Default is STDOUT."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
