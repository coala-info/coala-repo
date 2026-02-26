cwlVersion: v1.2
class: CommandLineTool
baseCommand: cojac generate-sigs-nextstrains
label: cojac_generate-sigs-nextstrains
doc: "Generating a list of variants from nextstrain\n\nTool homepage: https://github.com/cbg-ethz/cojac"
inputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: The output directory for the YAML files
    inputBinding:
      position: 101
      prefix: --outdir
  - id: url
    type:
      - 'null'
      - string
    doc: url to fetch the JSON from
    inputBinding:
      position: 101
      prefix: --url
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cojac:0.9.3--pyh7e72e81_0
stdout: cojac_generate-sigs-nextstrains.out
