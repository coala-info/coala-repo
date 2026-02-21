cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - table
label: autocycler_table
doc: "create TSV line from YAML files\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: autocycler_dir
    type:
      - 'null'
      - Directory
    doc: Autocycler directory (if absent, a header line will be output)
    inputBinding:
      position: 101
      prefix: --autocycler_dir
  - id: fields
    type:
      - 'null'
      - string
    doc: Comma-delimited list of YAML fields to include
    default: input_read_count, input_read_bases, input_read_n50, pass_cluster_count,
      fail_cluster_count, overall_clustering_score, untrimmed_cluster_size, untrimmed_cluster_distance,
      trimmed_cluster_size, trimmed_cluster_median, trimmed_cluster_mad, consensus_assembly_bases,
      consensus_assembly_unitigs, consensus_assembly_fully_resolved
    inputBinding:
      position: 101
      prefix: --fields
  - id: name
    type:
      - 'null'
      - string
    doc: Sample name
    default: blank
    inputBinding:
      position: 101
      prefix: --name
  - id: sigfigs
    type:
      - 'null'
      - int
    doc: Significant figures to use for floating point numbers
    default: 3
    inputBinding:
      position: 101
      prefix: --sigfigs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
stdout: autocycler_table.out
