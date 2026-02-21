cwlVersion: v1.2
class: CommandLineTool
baseCommand: sneakernet-qc_SneakerNetPlugins.pl
label: sneakernet-qc_SneakerNetPlugins.pl
doc: "SneakerNet QC Plugins. (Note: The provided text contains container runtime logs
  and a fatal error message rather than tool help text; therefore, no arguments could
  be extracted.)\n\nTool homepage: https://github.com/lskatz/sneakernet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sneakernet-qc:0.27.2--pl5321hdfd78af_0
stdout: sneakernet-qc_SneakerNetPlugins.pl.out
