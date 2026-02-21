cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genomedata-close-data
label: genomedata_genomedata-close-data
doc: "A tool from the Genomedata package. (Note: The provided help text contains only
  container runtime error messages and no usage information.)\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-close-data.out
