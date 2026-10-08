cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - finaletoolkit
  - gap-bed
label: finaletoolkit_gap-bed
doc: "Creates a BED4 file containing centromeres, telomeres, and short-arm\nintervals,
  similar to the gaps annotation track for hg19 found on the UCSC\nGenome Browser
  (Kent et al 2002). Currently only supports hg19, b37,\nhuman_g1k_v37, hg38, and
  GRCh38\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: reference_genome
    type: string
    doc: Reference genome to provide gaps for (hg19, b37, human_g1k_v37, hg38, GRCh38).
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Path to write BED file to. If "-" used, writes to stdout.
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: BED4 file of gaps (centromeres, telomeres, short arms)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
