cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tradis
  - plot
  - create
label: quatradis_tradis_plot_create
doc: "Create a TraDIS plot file from either FASTQ or alignment file input.\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: fastq
    type: File
    doc: "FASTQ formatted reads (can be gzipped)."
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: "FASTA formatted reference. Indexed in the working directory when no_ref_index is not set."
    inputBinding:
      position: 2
  - id: alignments
    type:
      - 'null'
      - File
    doc: "SAM or BAM file. If provided the FASTQ is not aligned to the reference."
    inputBinding:
      position: 102
      prefix: --alignments
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "The directory in which to put all output files."
    inputBinding:
      position: 103
      prefix: --output_dir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "The filename prefix to use for all output files (default: quatradis_out)."
    inputBinding:
      position: 104
      prefix: --output_prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use when mapping and sorting."
    inputBinding:
      position: 105
      prefix: --threads
  - id: aligner
    type:
      - 'null'
      - string
    doc: "Mapping tool to use (bwa, smalt, minimap2, minimap2_long)."
    inputBinding:
      position: 106
      prefix: --aligner
  - id: no_ref_index
    type:
      - 'null'
      - boolean
    doc: "If the reference is already indexed use this flag to skip indexing."
    inputBinding:
      position: 107
      prefix: --no_ref_index
  - id: mapping_score
    type:
      - 'null'
      - int
    doc: "Mapping quality must be greater than X (default: 30)."
    inputBinding:
      position: 108
      prefix: --mapping_score
  - id: tag
    type:
      - 'null'
      - string
    doc: "The tag to remove from FASTQ input."
    inputBinding:
      position: 109
      prefix: --tag
  - id: mismatch
    type:
      - 'null'
      - int
    doc: "Number of mismatches allowed when matching the tag."
    inputBinding:
      position: 110
      prefix: --mismatch
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
  - id: insert_site_plots
    type:
      type: array
      items: File
    doc: "Insertion site plot files"
    outputBinding:
      glob: |
        ${ return (inputs.output_dir ? inputs.output_dir + "/" : "") + "*.insert_site_plot.gz"; }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: '${ return inputs.output_dir ? inputs.output_dir : "_unused_o"; }'
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis_plot_create.out
