cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - remove_white_space_in_id.pl
label: mirdeep2_remove_white_space_in_id.pl
doc: "Remove everything after the first whitespace in the id lines of a fasta file (sequences are printed in upper case)\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: file_fasta
    type: File
    doc: Fasta file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Fasta file with clean ids
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: clean_ids.fa
