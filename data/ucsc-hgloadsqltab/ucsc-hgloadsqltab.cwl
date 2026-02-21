cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadSqlTab
label: ucsc-hgloadsqltab
doc: "The provided text does not contain help information for the tool, as it consists
  of container runtime error messages. Based on the tool name, this is a UCSC Genome
  Browser utility used to load a tab-separated file into a SQL table using a schema
  definition.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadsqltab:482--h0b57e2e_0
stdout: ucsc-hgloadsqltab.out
