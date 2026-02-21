cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktUpdateTaxonomy.sh
label: krona_ktUpdateTaxonomy.sh
doc: "Update the Krona taxonomy database. (Note: The provided help text contains only
  system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/marbl/Krona"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona_ktUpdateTaxonomy.sh.out
