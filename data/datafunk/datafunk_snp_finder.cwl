cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - snp_finder
label: datafunk_snp_finder
doc: "Query an alignment position for informative SNP\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: alignment_file
    type: File
    doc: Alignment (to Wuhan-Hu-1 / WH04) in FASTA format
    inputBinding:
      position: 101
      prefix: -a
  - id: snp_csv
    type: File
    doc: 'CSV with a header line and the SNPs to type, format: 
      name,location,nuc1,label1,nuc2,label2 (e.g. D614G,23403,A,D,G,G)'
    inputBinding:
      position: 101
      prefix: --snp-csv
  - id: output_path
    type: string
    doc: CSV file with the typing results to write
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: SNP typing results
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
stdout: datafunk_snp_finder.out
