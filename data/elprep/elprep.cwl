cwlVersion: v1.2
class: CommandLineTool
baseCommand: elprep
label: elprep
doc: "A high-performance tool for preparing .sam/.bam/.cram files for variant calling.\n
  \nTool homepage: https://github.com/ExaScience/elprep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elprep:5.1.3--he881be0_2
stdout: elprep.out
