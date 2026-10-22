cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-correlate-genes.R
label: scran-cli_scran-correlate-genes.R
doc: "Get per-gene correlation statistics from the gene-pair table made by correlatePairs.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: input_corr_pairs
    type: File
    doc: "Path to the DataFrame of pairwise correlation statistics, returned by correlatePairs."
    inputBinding:
      prefix: --input-corr-pairs
  - id: output_corr_genes_path
    type: string
    doc: "A DataFrame with one row per unique gene in stats and containing the fields: gene, rho, p.value, FDR, limited."
    inputBinding:
      prefix: --output-corr-genes
outputs:
  - id: output_corr_genes
    type: File
    doc: "Table with one row per gene: gene, rho, p.value, FDR, limited"
    outputBinding:
      glob: $(inputs.output_corr_genes_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
