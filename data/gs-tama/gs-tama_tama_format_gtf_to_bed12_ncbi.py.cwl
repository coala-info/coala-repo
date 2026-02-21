cwlVersion: v1.2
class: CommandLineTool
baseCommand: gs-tama_tama_format_gtf_to_bed12_ncbi.py
label: gs-tama_tama_format_gtf_to_bed12_ncbi.py
doc: "Format GTF to BED12 for NCBI (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_format_gtf_to_bed12_ncbi.py.out
