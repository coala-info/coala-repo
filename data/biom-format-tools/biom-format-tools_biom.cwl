cwlVersion: v1.2
class: CommandLineTool
baseCommand: biom
label: biom-format-tools_biom
doc: "The BIOM file format provides a standardized way to represent biological observation
  tables. (Note: The provided help text indicates a runtime error: ImportError: No
  module named 'pkg_resources')\n\nTool homepage: https://github.com/molbiodiv/biom-conversion-server"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biom-format-tools:v2.1.5dfsg-7-deb_cv1
stdout: biom-format-tools_biom.out
