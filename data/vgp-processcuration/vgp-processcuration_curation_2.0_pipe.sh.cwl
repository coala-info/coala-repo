cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgp-processcuration_curation_2.0_pipe.sh
label: vgp-processcuration_curation_2.0_pipe.sh
doc: "VGP process curation pipeline. (Note: The provided text contains system logs
  and error messages rather than command-line help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration_curation_2.0_pipe.sh.out
