cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rust-ncbitaxonomy
  - taxonomy_filter_refseq
label: rust-ncbitaxonomy_taxonomy_filter_refseq
doc: "A tool within the rust-ncbitaxonomy package. (Note: The provided help text contains
  container build error logs rather than command usage information; therefore, specific
  arguments could not be extracted.)\n\nTool homepage: https://github.com/pvanheus/ncbitaxonomy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
stdout: rust-ncbitaxonomy_taxonomy_filter_refseq.out
