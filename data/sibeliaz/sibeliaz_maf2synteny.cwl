cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf2synteny
label: sibeliaz_maf2synteny
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain the help text or usage information for the tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/medvedevgroup/SibeliaZ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sibeliaz:1.2.7--h9948957_0
stdout: sibeliaz_maf2synteny.out
