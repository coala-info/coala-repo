cwlVersion: v1.2
class: CommandLineTool
baseCommand: SEACR_1.3.sh
label: seacr_SEACR_1.3.sh
doc: "SEACR (Sparse Enrichment Analysis for CUT&RUN) is a tool intended to call peaks
  and footprints from CUT&RUN network data.\n\nTool homepage: https://github.com/FredHutch/SEACR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seacr:1.3--hdfd78af_2
stdout: seacr_SEACR_1.3.sh.out
