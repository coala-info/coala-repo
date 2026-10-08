cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloseq_import_data.py
label: frogs_phyloseq_import_data
doc: "Launch Rmardown script to import data from 3 files: biomfile, samplefile, treefile into a phyloseq object\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: normalisation
    type: ['null', boolean]
    doc: "To normalise data before analysis. Use this option if you didnt do it in FROGS Abundance normalisation. [Default: False]"
    inputBinding:
      position: 2
      prefix: --normalisation
  - id: ranks
    type: ['null', {type: array, items: string}]
    doc: "The ordered taxonomic ranks levels stored in BIOM. Each rank is separated by one space. [Default: ['Kingdom', 'Phylum', 'Class', 'Order', 'Family', 'Genus', 'Species']]"
    inputBinding:
      position: 3
      prefix: --ranks
  - id: input_biom
    type: File
    doc: "path to the abundance BIOM file."
    inputBinding:
      position: 4
      prefix: --input-biom
  - id: sample_metadata_tsv
    type: File
    doc: "path to sample file (format: TSV)."
    inputBinding:
      position: 5
      prefix: --sample-metadata-tsv
  - id: tree_nwk
    type: ['null', File]
    doc: "path to tree file from FROGS Tree (format: Newick \"nhx\" or \"nwk\" )."
    inputBinding:
      position: 6
      prefix: --tree-nwk
  - id: output_phyloseq_rdata_path
    type: ['null', string]
    doc: "path to store phyloseq-class object in Rdata file. [Default: phyloseq_asv.Rdata]"
    inputBinding:
      position: 7
      prefix: --output-phyloseq-rdata
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: phyloseq_import_summary.nb.html]"
    inputBinding:
      position: 8
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    inputBinding:
      position: 9
      prefix: --log-file
outputs:
  - id: output_phyloseq_rdata
    type: ['null', File]
    doc: "path to store phyloseq-class object in Rdata file. [Default: phyloseq_asv.Rdata]"
    outputBinding:
      glob: '${ return inputs.output_phyloseq_rdata_path ? inputs.output_phyloseq_rdata_path : ''phyloseq_asv.Rdata''; }'
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: phyloseq_import_summary.nb.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''phyloseq_import_summary.nb.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''phyloseq_import_data_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: phyloseq_import_data_stdout.txt
