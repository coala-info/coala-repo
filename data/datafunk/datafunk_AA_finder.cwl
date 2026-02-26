cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk AA_finder
label: datafunk_AA_finder
doc: "Query a codon position for amino acids\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: codons_file
    type: File
    doc: "Input CSV file with codon locations to parse. Format\nis: name,1-based start
      position of codon (dont include\na header line), eg: d614g,23402"
    inputBinding:
      position: 101
      prefix: --codons-file
  - id: input_fasta
    type: File
    doc: Alignment (to Wuhan-Hu-1) in Fasta format to type
    inputBinding:
      position: 101
      prefix: --input-fasta
outputs:
  - id: genotypes_table
    type: File
    doc: "CSV file with amino acid typing results to write.\nReturns the amino acid
      at each position in --codons-\nfile for each sequence in --input-fasta, or \"\
      X\" for\nmissing data"
    outputBinding:
      glob: $(inputs.genotypes_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
