cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas
label: metagenome-atlas_atlas
doc: "ATLAS - workflows for assembly, annotation, and genomic binning of metagenomic
  and metatranscriptomic data.\n\nTool homepage: https://github.com/metagenome-atlas"
inputs:
  - id: download
    type:
      - 'null'
      - boolean
    doc: download reference files (need ~50GB)
    inputBinding:
      position: 101
  - id: init
    type:
      - 'null'
      - boolean
    doc: prepare configuration file and sample table for atlas run
    inputBinding:
      position: 101
  - id: run
    type:
      - 'null'
      - boolean
    doc: run atlas main workflow
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagenome-atlas:19.0.1--pyhdfd78af_0
stdout: metagenome-atlas_atlas.out
