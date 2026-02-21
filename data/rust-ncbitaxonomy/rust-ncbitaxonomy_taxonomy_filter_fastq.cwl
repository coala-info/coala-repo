cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonomy_filter_fastq
label: rust-ncbitaxonomy_taxonomy_filter_fastq
doc: "A tool for filtering FASTQ files based on NCBI taxonomy information.\n\nTool
  homepage: https://github.com/pvanheus/ncbitaxonomy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
stdout: rust-ncbitaxonomy_taxonomy_filter_fastq.out
