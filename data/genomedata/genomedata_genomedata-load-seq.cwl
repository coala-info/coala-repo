cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-load-seq
label: genomedata_genomedata-load-seq
doc: "Load sequence data into a Genomedata archive (Note: The provided help text contained
  only container runtime error messages and no usage information).\n\nTool homepage:
  http://genomedata.hoffmanlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-load-seq.out
