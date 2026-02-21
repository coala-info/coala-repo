cwlVersion: v1.2
class: CommandLineTool
baseCommand: viral-ngs_BMTagger
label: viral-ngs_BMTagger
doc: "The provided text does not contain help information as it is a log of a fatal
  error during a container build process. No arguments or tool descriptions could
  be extracted from the input.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_BMTagger.out
