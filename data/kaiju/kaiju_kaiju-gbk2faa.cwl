cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju-gbk2faa.pl
label: kaiju_kaiju-gbk2faa
doc: "Extract all amino acid sequences from the /translation fields of a GenBank file into a FASTA file. The FASTA header contains the protein ID and the taxon ID taken from the /db_xref=\"taxon:<ID>\" field.\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
inputs:
  - id: genbank_file
    type: File
    doc: GenBank flat file (plain or compressed)
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Name of the output FASTA file
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: Protein FASTA file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju-gbk2faa.out
