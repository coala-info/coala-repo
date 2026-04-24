cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3 main.py
label: netmd
doc: "Parser testing\n\nTool homepage: https://github.com/mazzalab/NetMD"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Specify the path to the configuration file containing arguments for 
      Graph2Vec. If no path is provided, default values will be used.
    inputBinding:
      position: 101
      prefix: --configFile
  - id: edge_filter
    type:
      - 'null'
      - float
    doc: Specify the entropy threshold used to filter the graph edges.
    inputBinding:
      position: 101
      prefix: --edgeFilter
  - id: features
    type:
      - 'null'
      - File
    doc: Specify the path to the input file containing node features. If 
      provided, the file must be in tab-separated values (TSV) format. If no 
      path is provided, the unique chain identifier of each residue in the 
      contacts file will be used as the node feature
    inputBinding:
      position: 101
      prefix: --features
  - id: files
    type:
      type: array
      items: File
    doc: Specify one or more contact file paths.
    inputBinding:
      position: 101
      prefix: --Files
  - id: input_path
    type:
      type: array
      items: File
    doc: 'Specify the directory tree path followed by the standardized prefix of the
      contacts file name. Example: -i examples_dir contacts.tsv'
    inputBinding:
      position: 101
      prefix: --InputPath
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Specify the output path. If no path is provided, the "results" folder 
      will be used.
    inputBinding:
      position: 101
      prefix: --outputPath
  - id: plot_format
    type:
      - 'null'
      - string
    doc: 'Specify the format of the image output. (svg or png; default: svg)'
    inputBinding:
      position: 101
      prefix: --plotFormat
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Allow extra prints.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netmd:1.0.3--pyh3c853c9_0
stdout: netmd.out
