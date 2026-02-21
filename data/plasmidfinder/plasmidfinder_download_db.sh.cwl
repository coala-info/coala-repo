cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidfinder_download_db.sh
label: plasmidfinder_download_db.sh
doc: "Download script for the PlasmidFinder database. (Note: The provided text is
  an error log and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://bitbucket.org/genomicepidemiology/plasmidfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidfinder:2.1.6--py314hdfd78af_2
stdout: plasmidfinder_download_db.sh.out
