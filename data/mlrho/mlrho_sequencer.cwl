cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlrho
label: mlrho_sequencer
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help or usage information for the tool. mlrho is typically
  used for estimating population genetic parameters from sequencing data.\n\nTool
  homepage: http://guanine.evolbio.mpg.de/mlRho/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlrho:2.9--h2d4b398_9
stdout: mlrho_sequencer.out
