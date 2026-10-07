cwlVersion: v1.2
class: CommandLineTool
baseCommand: fetch_all_refseq_chloroplast_genomes
label: cct_fetch_all_refseq_chloroplast_genomes
doc: "Downloads all chloroplast RefSeq sequences form NCBI in GenBank format.\n\nTool homepage:
  https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: output
    type: string
    doc: The output directory to download the GenBank file(s) into.
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the downloaded GenBank files
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
