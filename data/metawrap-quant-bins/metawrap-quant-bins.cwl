cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - quant_bins
label: metawrap-quant-bins
doc: "The provided text contains a fatal error message from a container runtime (Singularity/Apptainer)
  and does not include the actual help text for the tool. As a result, no arguments
  could be extracted from the input.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-quant-bins:1.3.0--hdfd78af_3
stdout: metawrap-quant-bins.out
