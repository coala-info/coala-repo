cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcftools
label: bcftools-gtc2vcf-plugin_bcftools
doc: "The provided text is an error log indicating a failure to build or extract the
  container image (no space left on device) and does not contain help text or argument
  definitions.\n\nTool homepage: https://github.com/freeseek/gtc2vcf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-gtc2vcf-plugin:1.22--hb66fcc3_0
stdout: bcftools-gtc2vcf-plugin_bcftools.out
