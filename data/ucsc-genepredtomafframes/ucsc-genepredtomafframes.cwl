cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToMafFrames
label: ucsc-genepredtomafframes
doc: "The provided text does not contain help information for the tool, as it is a
  container runtime error log. Based on the tool name, it is a UCSC Genome Browser
  utility used to convert genePred files to MAF frames.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtomafframes:482--h0b57e2e_0
stdout: ucsc-genepredtomafframes.out
