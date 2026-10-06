cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - refquery
label: ariba_refquery
doc: "Get cluster or sequence info from the output directory made by prepareref\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
inputs:
  - id: prepareref_dir
    type: Directory
    doc: "Name of directory output by prepareref"
    inputBinding:
      position: 10
  - id: query_type
    type: string
    doc: "Use \"cluster\" to get the sequences in a cluster, or \"seq\" to get information about a sequence (cluster or seq)"
    inputBinding:
      position: 11
  - id: search_name
    type: string
    doc: "Name of cluster or sequence to search for"
    inputBinding:
      position: 12
outputs:
  - id: stdout
    type: stdout
    doc: Cluster or sequence information
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
stdout: ariba_refquery.out
