cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_flnc_polya_cleanup.py
label: gs-tama_tama_flnc_polya_cleanup.py
doc: "This script removes tailing poly A from FLNC fasta files\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: flnc_fasta_file
    type:
      - 'null'
      - File
    doc: FLNC Fasta file
    inputBinding:
      position: 101
      prefix: -f
  - id: output_prefix
    type: string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: "Files written with the prefix given in output_prefix (cleaned fasta, removed tails, report)"
    outputBinding:
      glob: $(inputs.output_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_flnc_polya_cleanup.py.out
