cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CalcGeneCov.py
label: desman_CalcGeneCov.py
doc: "Calculate the mean coverage of each gene in every sample from a DESMAN gene
  base frequency table and print it as CSV (Gene, then one column per sample).\n\n  Tool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: gene_freq_file
    type: File
    doc: input gene base frequencies
    inputBinding:
      position: 10
  - id: output_name
    type: string
    doc: Name of the file that receives the gene coverage table written to stdout
    default: gene_cov.csv
outputs:
  - id: gene_coverage
    type: File
    doc: Gene coverage per sample (CSV)
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
