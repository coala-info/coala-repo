cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-trim-fastq
label: illumina-utils_iu-trim-fastq
doc: "A tool from the illumina-utils suite for trimming FASTQ files. (Note: The provided
  help text contains only system error messages regarding container execution and
  disk space; no specific argument definitions were found in the input.)\n\nTool homepage:
  https://github.com/meren/illumina-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
stdout: illumina-utils_iu-trim-fastq.out
