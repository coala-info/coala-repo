cwlVersion: v1.2
class: CommandLineTool
baseCommand: tntblast
label: tntblast
doc: "The provided text does not contain help information for tntblast. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the tool's image.\n\nTool homepage: https://github.com/jgans/thermonucleotideBLAST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tntblast:2.66--h6b557da_0
stdout: tntblast.out
