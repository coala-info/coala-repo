cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enasearch
  - get_filter_types
label: enasearch_get_filter_types
doc: "Return the filters usable for the different type of data.\n\nThis function returns the filters that can be used for the different type of data (information available with the information on the filter fileds). Each filter is described with its name, the possible operators or paramters, a description of the expected values\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_filter_types.out
