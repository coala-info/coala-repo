cwlVersion: v1.2
class: CommandLineTool
baseCommand: [netmd]
label: netmd
doc: "NetMD analyses residue-contact files from molecular dynamics replicas (made with
  GetContacts): it builds contact graphs, embeds frames with Graph2Vec, aligns the
  replicas with dynamic time warping and clusters them.\n\nTool homepage: https://github.com/mazzalab/NetMD"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more contact file paths (replicas). Use either files or input_dir with input_prefix.
    inputBinding:
      position: 1
      prefix: --Files
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Directory tree with the contact files (first value of --InputPath).
    inputBinding:
      position: 2
      prefix: --InputPath
  - id: input_prefix
    type:
      - 'null'
      - string
    doc: Standardized prefix of the contact file names (second value of --InputPath).
    inputBinding:
      position: 3
  - id: features
    type:
      - 'null'
      - File
    doc: "Tab-separated file with node features. If no file is given, the unique chain identifier of each residue is the node feature."
    inputBinding:
      position: 4
      prefix: --features
  - id: edge_filter
    type:
      - 'null'
      - float
    doc: Entropy threshold used to filter the graph edges, between 0 and 1 (default 0.1).
    inputBinding:
      position: 4
      prefix: --edgeFilter
  - id: config_file
    type:
      - 'null'
      - File
    doc: YAML configuration file with Graph2Vec arguments. Default values are used when it is not given.
    inputBinding:
      position: 4
      prefix: --configFile
  - id: output_path
    type: string
    default: results
    doc: Output folder (created before the run).
    inputBinding:
      position: 4
      prefix: --outputPath
  - id: plot_format
    type:
      - 'null'
      - type: enum
        symbols: [svg, png]
        name: netmd_plot_format
    doc: Format of the image output (default svg).
    inputBinding:
      position: 4
      prefix: --plotFormat
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Allow extra prints.
    inputBinding:
      position: 4
      prefix: --verbose
outputs:
  - id: results
    type: Directory
    doc: Output folder with the plots, metadata.tsv, subgraphs_emb.pkl, dtw_matrix.tsv, dtw_mapping.txt and iterative_ranks.tsv.
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({class: "Directory", basename: inputs.output_path, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netmd:1.0.3--pyh3c853c9_0
stdout: netmd.out
