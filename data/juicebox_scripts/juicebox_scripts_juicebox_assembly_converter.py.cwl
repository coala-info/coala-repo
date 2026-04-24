cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicebox_assembly_converter.py
label: juicebox_scripts_juicebox_assembly_converter.py
doc: "Converts a Juicebox assembly file to other formats.\n\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs:
  - id: assembly_file
    type: File
    doc: juicebox assembly file
    inputBinding:
      position: 101
      prefix: --assembly
  - id: contig_mode
    type:
      - 'null'
      - boolean
    doc: ignore scaffold specification and just output contigs. useful when only
      trying to obtain a fasta reflecting juicebox breaks.
    inputBinding:
      position: 101
      prefix: --contig_mode
  - id: fasta_file
    type: File
    doc: the fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: the prefix to use for writing outputs.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: simple_chr_names
    type:
      - 'null'
      - boolean
    doc: use simple chromosome names ("ChromosomeX") for scaffolds instead of 
      detailed chromosome names ("PGA_scaffold_X__Y_contigs__length_Z"). Has no 
      effect in contig_mode.
    inputBinding:
      position: 101
      prefix: --simple_chr_names
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print summary of processing steps to stdout, otherwise silent.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
stdout: juicebox_scripts_juicebox_assembly_converter.py.out
