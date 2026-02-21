cwlVersion: v1.2
class: CommandLineTool
baseCommand: pirs-profiles_indelstat_sam_bam
label: pirs-profiles_indelstat_sam_bam
doc: "A tool from the pirs-profiles suite. (Note: The provided help text contains
  system error messages regarding container extraction and disk space rather than
  command usage instructions.)\n\nTool homepage: https://github.com/galaxy001/pirs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pirs-profiles:v2.0.2dfsg-8-deb_cv1
stdout: pirs-profiles_indelstat_sam_bam.out
