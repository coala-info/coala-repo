cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cw_get_uniprot_data
label: cazy_webscraper_cw_get_uniprot_data
doc: "The provided text is an error log indicating a failure to build or extract a
  container image due to insufficient disk space. It does not contain help text, usage
  instructions, or argument definitions for the tool.\n\nTool homepage: https://hobnobmancer.github.io/cazy_webscraper/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cazy_webscraper:2.3.0.4--pyhdfd78af_0
stdout: cazy_webscraper_cw_get_uniprot_data.out
