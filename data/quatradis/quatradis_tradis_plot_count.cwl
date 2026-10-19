cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tradis
  - plot
  - count
label: quatradis_tradis_plot_count
doc: "Take in one or more plot files and an EMBL file to produce a tab delimited file with insert site details to use as input to an essentiality test.\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: embl_in
    type: File
    doc: "The EMBL formatted annotation file."
    inputBinding:
      position: 1
  - id: plot_in
    type:
      type: array
      items: File
    doc: "The insertion site plot files (can be gzipped)."
    inputBinding:
      position: 2
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "The directory in which to put all output files."
    inputBinding:
      position: 103
      prefix: --output_dir
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: "The suffix to add to output files (default: tradis_gene_insert_sites.csv)."
    inputBinding:
      position: 104
      prefix: --output_suffix
  - id: trim5
    type:
      - 'null'
      - boolean
    doc: "Trim insertion sites from the 5' end of the gene."
    inputBinding:
      position: 105
      prefix: --trim5
  - id: trim3
    type:
      - 'null'
      - boolean
    doc: "Trim insertion sites from the 3' end of the gene."
    inputBinding:
      position: 106
      prefix: --trim3
  - id: joined_output
    type:
      - 'null'
      - boolean
    doc: "Output a single file with all info."
    inputBinding:
      position: 107
      prefix: --joined_output
  - id: profile
    type:
      - 'null'
      - boolean
    doc: "Turn on profiling."
    inputBinding:
      position: 100
      prefix: --profile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print out extra information about the process while it runs."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_out
    type:
      - 'null'
      - Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output_dir)
  - id: count_files
    type:
      type: array
      items: File
    doc: "Gene insertion site count files"
    outputBinding:
      glob: |
        ${ return (inputs.output_dir ? inputs.output_dir + "/" : "") + "*.csv"; }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: '${ return inputs.output_dir ? inputs.output_dir : "_unused_o"; }'
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis_plot_count.out
