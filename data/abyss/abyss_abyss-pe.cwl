cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss-pe
label: abyss_abyss-pe
doc: "The provided text is an error log from a container build process and does not
  contain help information for the tool. ABySS is a de novo, parallel, paired-end
  sequence assembler.\n\nTool homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
stdout: abyss_abyss-pe.out
