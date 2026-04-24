cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ete3
  - ncbiquery
label: ete3_ncbiquery
doc: "Query NCBI databases for sequences and retrieve them in Newick format.\n\nTool
  homepage: http://etetoolkit.org/"
inputs:
  - id: query
    type: string
    doc: The query string to search NCBI databases.
    inputBinding:
      position: 1
  - id: database
    type:
      - 'null'
      - string
    doc: The NCBI database to query (e.g., nr, nt, pdb, sw,瞽).
    inputBinding:
      position: 102
      prefix: --database
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (newick, fasta, phylip).
    inputBinding:
      position: 102
      prefix: --format
  - id: max_results
    type:
      - 'null'
      - int
    doc: Maximum number of results to retrieve.
    inputBinding:
      position: 102
      prefix: --max_results
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to save the output Newick tree.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ete3:3.1.2
