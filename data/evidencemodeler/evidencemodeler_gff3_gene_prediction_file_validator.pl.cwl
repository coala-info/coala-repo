cwlVersion: v1.2
class: CommandLineTool
baseCommand: evidencemodeler_gff3_gene_prediction_file_validator.pl
label: evidencemodeler_gff3_gene_prediction_file_validator.pl
doc: "A tool to validate GFF3 gene prediction files for EvidenceModeler.\n\nTool homepage:
  https://github.com/EVidenceModeler/EVidenceModeler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evidencemodeler:2.1.0--h9948957_5
stdout: evidencemodeler_gff3_gene_prediction_file_validator.pl.out
