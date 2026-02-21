cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - bin_refinement
label: metawrap-refinement_metawrap
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain the help documentation or argument definitions for the tool.
  It indicates a 'no space left on device' failure during image conversion.\n\nTool
  homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-refinement:1.3.0--hdfd78af_3
stdout: metawrap-refinement_metawrap.out
