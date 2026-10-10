cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpit-run.py
label: mtb-snp-it_snpit-run.py
doc: "Reports the species and lineage of a Mycobacterium tuberculosis complex sample from a VCF or FASTA file aligned to NC_000962 (H37Rv).\n\nTool homepage: https://github.com/samlipworth/snpit"
stdout: snpit_result.tsv
inputs:
  - id: input_file
    type: File
    doc: The path to the VCF or FASTA file to read and classify (either can be bzip2ed or gzipped)
    inputBinding:
      prefix: --input
outputs:
  - id: result
    type: stdout
    doc: Tab-separated line with the input name, species, lineage, sublineage and percentage
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtb-snp-it:1.1--py_0
