cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict.pl
label: vardict_vardict.pl
doc: "VarDict is a sensitive variant caller for both single and paired samples. (Note:
  The provided text appears to be a container build log and does not contain usage
  information or argument definitions.)\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict_vardict.pl.out
