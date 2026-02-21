cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cw_get_db_schema
label: cazy_webscraper_cw_get_db_schema
doc: "Get the database schema for cazy_webscraper. (Note: The provided help text contained
  only system error logs and no argument definitions.)\n\nTool homepage: https://hobnobmancer.github.io/cazy_webscraper/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cazy_webscraper:2.3.0.4--pyhdfd78af_0
stdout: cazy_webscraper_cw_get_db_schema.out
