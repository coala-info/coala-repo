cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapmap-example-data_RunRapMap.sh
label: rapmap-example-data_RunRapMap.sh
doc: "RapMap Transcriptome Aligner v0.6.0\n\nTool homepage: https://github.com/COMBINE-lab/RapMap"
inputs:
  - id: subcommand
    type: string
    doc: RapMap subcommand (quasiindex or quasimap)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap-example-data:v0.12.0dfsg-3-deb_cv1
stdout: rapmap-example-data_RunRapMap.sh.out
