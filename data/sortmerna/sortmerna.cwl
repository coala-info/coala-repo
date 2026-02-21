cwlVersion: v1.2
class: CommandLineTool
baseCommand: sortmerna
label: sortmerna
doc: "SortMeRNA is a local sequence alignment tool for filtering, mapping and clustering
  NGS reads. (Note: The provided text is a container build error log and does not
  contain help documentation or argument definitions.)\n\nTool homepage: http://bioinfo.lifl.fr/RNA/sortmerna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sortmerna:4.3.7--hdbdd923_1
stdout: sortmerna.out
