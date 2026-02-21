cwlVersion: v1.2
class: CommandLineTool
baseCommand: arcasHLA
label: arcas-hla_arcasHLA
doc: "A tool for HLA extraction, genotyping, and quantification from RNA-seq data.
  It includes commands for extracting chromosome 6 reads, genotyping HLA genes, quantification,
  and processing results.\n\nTool homepage: https://github.com/RabadanLab/arcasHLA"
inputs:
  - id: command
    type: string
    doc: 'The command to execute. Available commands: extract (extracts chromosome
      6 reads from bam), genotype (types HLA genes from extracted reads), partial
      (types partial HLA genes from extracted reads), customize (create custom HLA
      reference), quant (allele specific HLA quantification), merge (processes results
      into a tab-separated table), convert (converts HLA nomenclature/resolution),
      reference (check or update HLA reference).'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
stdout: arcas-hla_arcasHLA.out
