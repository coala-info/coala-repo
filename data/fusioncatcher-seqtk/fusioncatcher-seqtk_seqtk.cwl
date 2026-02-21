cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqtk
label: fusioncatcher-seqtk_seqtk
doc: "The provided help text contains only system error messages related to a container
  runtime (Apptainer/Singularity) and does not contain usage information for the tool.
  Seqtk is generally used for processing sequences in FASTA/FASTQ format.\n\nTool
  homepage: https://github.com/ndaniel/seqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusioncatcher-seqtk:1.2--h577a1d6_7
stdout: fusioncatcher-seqtk_seqtk.out
