cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcftools-gtc2vcf-plugin_build
label: bcftools-gtc2vcf-plugin_build
doc: "The provided text is a log of a failed container build process (Singularity/Apptainer)
  and does not contain CLI help information or argument definitions.\n\nTool homepage:
  https://github.com/freeseek/gtc2vcf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-gtc2vcf-plugin:1.22--hb66fcc3_0
stdout: bcftools-gtc2vcf-plugin_build.out
