cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo-qc
label: panaroo_qc
doc: "Generate quality control plots and tables (contamination, number of contigs and genes, MDS) before a Panaroo run.

Tool homepage: https://gtonkinhill.github.io/panaroo"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.out_dir, "listing": []})'
        writable: true
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input GFF3 files (usually output from running Prokka)."
    inputBinding:
      prefix: --input
  - id: out_dir
    type: string
    doc: "Location of an output directory."
    inputBinding:
      prefix: --out_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default 1)."
    inputBinding:
      prefix: --threads
  - id: graph_type
    type:
      - 'null'
      - string
    doc: "The type of graph to generate: all, contam, ncontigs, ngenes or mds (default 'all')."
    inputBinding:
      prefix: --graph_type
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: "Do not generate the plots; only create the data tables."
    inputBinding:
      prefix: --no_plot
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed for reproducibility (default 1)."
    inputBinding:
      prefix: --random_seed
  - id: ref_db
    type:
      - 'null'
      - File
    doc: "Reference mash database for contamination quantification."
    inputBinding:
      prefix: --ref_db
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the QC tables and plots."
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo_qc.out
