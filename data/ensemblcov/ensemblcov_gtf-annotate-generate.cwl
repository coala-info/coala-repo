cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensemblcov_gtf-annotate-generate
label: ensemblcov_gtf-annotate-generate
doc: "Generate annotations from GTF files.\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: gtf_file
    type: File
    doc: Path to the GTF file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_gtf-annotate-generate.out
