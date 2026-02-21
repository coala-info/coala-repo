cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapCounter
label: hmmcopy_mapCounter
doc: "The provided text contains system error messages (Singularity/Apptainer failure)
  rather than the tool's help documentation. Under normal operation, mapCounter (part
  of the HMMcopy suite) calculates the mappability of a genome within specified window
  sizes.\n\nTool homepage: http://compbio.bccrc.ca/software/hmmcopy/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
stdout: hmmcopy_mapCounter.out
