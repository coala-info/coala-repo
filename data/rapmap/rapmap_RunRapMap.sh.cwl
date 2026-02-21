cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapmap_RunRapMap.sh
label: rapmap_RunRapMap.sh
doc: "Rapid sensitive mapping of RNA-seq reads (Note: The provided text contains container
  runtime errors and does not include usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/COMBINE-lab/RapMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap:v0.12.0dfsg-3b1-deb_cv1
stdout: rapmap_RunRapMap.sh.out
