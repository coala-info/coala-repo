cwlVersion: v1.2
class: CommandLineTool
baseCommand: epicore
label: epicore_plot-landscape
doc: "Plots the consensus epitope landscape of proteins from an epicore result file.\n\nTool homepage: https://github.com/AG-Walz/epicore"
inputs:
  - id: reference_proteome
    type: File
    doc: Reference proteome FASTA file containing all protein accessions of the evidence file
    inputBinding:
      position: 1
      prefix: --reference_proteome
  - id: out_dir
    type: string
    doc: Output directory (created before the run)
    inputBinding:
      position: 2
      prefix: --out_dir
  - id: epicore_csv
    type: File
    doc: Epicore result file (epicore_result.csv from generate-epicore-csv)
    inputBinding:
      position: 10
      prefix: --epicore_csv
  - id: protacc
    type: string
    doc: Protein accession(s) to visualize, separated by commas
    inputBinding:
      position: 11
      prefix: --protacc
arguments:
  - position: 5
    valueFrom: plot-landscape
outputs:
  - id: out_dir_out
    type: Directory
    doc: Output directory with the results
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.out_dir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epicore:0.1.7--pyhdfd78af_0
stdout: epicore_plot-landscape.out
