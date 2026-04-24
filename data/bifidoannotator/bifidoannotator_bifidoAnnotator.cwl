cwlVersion: v1.2
class: CommandLineTool
baseCommand: bifidoAnnotator
label: bifidoannotator_bifidoAnnotator
doc: "Complete GH Annotation & Visualization Pipeline\n\nTool homepage: https://github.com/nicholaspucci/bifidoAnnotator"
inputs:
  - id: annotations_file
    type:
      - 'null'
      - File
    doc: TSV file with genome annotations for heatmap legends
    inputBinding:
      position: 101
      prefix: --annotations_file
  - id: bifdb
    type:
      - 'null'
      - File
    doc: Path to MMseqs2 database
    inputBinding:
      position: 101
      prefix: --bifdb
  - id: cluster_figsize_width
    type:
      - 'null'
      - type: array
        items: float
    doc: Cluster heatmap figure size (width height)
    inputBinding:
      position: 101
      prefix: --cluster-figsize
  - id: enzyme_figsize_width
    type:
      - 'null'
      - type: array
        items: float
    doc: Enzyme heatmap figure size (width height)
    inputBinding:
      position: 101
      prefix: --enzyme-figsize
  - id: genome_directory
    type: Directory
    doc: Path to directory containing input FASTA files
    inputBinding:
      position: 101
      prefix: --genome_directory
  - id: gh_figsize_width
    type:
      - 'null'
      - type: array
        items: float
    doc: GH heatmap figure size (width height)
    inputBinding:
      position: 101
      prefix: --gh-figsize
  - id: heatmap_col
    type:
      - 'null'
      - string
    doc: Color scheme for heatmap and annotations
    inputBinding:
      position: 101
      prefix: --heatmap_col
  - id: input_file
    type: File
    doc: Path to single input FASTA file
    inputBinding:
      position: 101
      prefix: --input_file
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: Path to mapping file
    inputBinding:
      position: 101
      prefix: --mapping_file
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: sample_file
    type:
      - 'null'
      - File
    doc: Text file listing genome names for processing (required with -d)
    inputBinding:
      position: 101
      prefix: --sample_file
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: MMseqs2 sensitivity
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for MMseqs2
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifidoannotator:1.0.2--pyhdfd78af_0
stdout: bifidoannotator_bifidoAnnotator.out
