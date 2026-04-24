cwlVersion: v1.2
class: CommandLineTool
baseCommand: alignoth
label: alignoth
doc: "A tool to create alignment plots from bam files.\n\nTool homepage: https://github.com/koesterlab/alignoth"
inputs:
  - id: around
    type:
      - 'null'
      - string
    doc: 'Chromosome and single base for the visualization. The plotted region will
      start 500bp before and end 500bp after the given base. Example: 2:20000'
    inputBinding:
      position: 101
      prefix: --around
  - id: around_vcf_record
    type:
      - 'null'
      - string
    doc: Plots a region around a specified VCF record taken via its index from 
      the VCF file given via the --vcf option
    inputBinding:
      position: 101
      prefix: --around-vcf-record
  - id: aux_tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Displays the given content of the aux tags in the tooltip of the plot. 
      Multiple usage for more than one tag is possible
    inputBinding:
      position: 101
      prefix: --aux-tag
  - id: bam_path
    type:
      - 'null'
      - File
    doc: BAM file to be visualized
    inputBinding:
      position: 101
      prefix: --bam-path
  - id: bed
    type:
      - 'null'
      - File
    doc: Path to a BED file that will be used to highlight all BED records 
      overlapping the given region
    inputBinding:
      position: 101
      prefix: --bed
  - id: data_format
    type:
      - 'null'
      - string
    doc: Set the data format of the read, reference and highlight data
    inputBinding:
      position: 101
      prefix: --data-format
  - id: highlight
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Interval or single base position that will be highlighted in the visualization.
      Example: 132440-132450 or 132440'
    inputBinding:
      position: 101
      prefix: --highlight
  - id: html
    type:
      - 'null'
      - boolean
    doc: If present, the generated plot will inserted into a plain html file 
      containing the plot centered which is then written to stdout
    inputBinding:
      position: 101
      prefix: --html
  - id: max_read_depth
    type:
      - 'null'
      - int
    doc: Set the maximum rows of reads that will be shown in the alignment plots
    inputBinding:
      position: 101
      prefix: --max-read-depth
  - id: max_width
    type:
      - 'null'
      - int
    doc: Sets the maximum width of the resulting plot
    inputBinding:
      position: 101
      prefix: --max-width
  - id: mismatch_display_min_percent
    type:
      - 'null'
      - float
    doc: The minimum percentage of mismatches compared to total read depth at 
      that point to display in the coverage plot
    inputBinding:
      position: 101
      prefix: --mismatch-display-min-percent
  - id: no_embed_js
    type:
      - 'null'
      - boolean
    doc: If present, the generated html will not embed javscript dependencies 
      and therefore be considerably smaller but require internet access to load 
      the dependencies
    inputBinding:
      position: 101
      prefix: --no-embed-js
  - id: plot_all
    type:
      - 'null'
      - boolean
    doc: A short command to plot the whole bam file. We advise to only use this 
      command for small bam files
    inputBinding:
      position: 101
      prefix: --plot-all
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to the reference fasta file
    inputBinding:
      position: 101
      prefix: --reference
  - id: region
    type:
      - 'null'
      - string
    doc: 'Chromosome and region (1-based, fully inclusive) for the visualization.
      Example: 2:132424-132924'
    inputBinding:
      position: 101
      prefix: --region
  - id: vcf
    type:
      - 'null'
      - File
    doc: Path to a VCF file that will be used to highlight all variant position 
      located within the given region
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: coverage_output
    type:
      - 'null'
      - File
    doc: If present coverage data will be written to the given file path
    outputBinding:
      glob: $(inputs.coverage_output)
  - id: highlight_data_output
    type:
      - 'null'
      - File
    doc: If present highlight data will be written to the given file path
    outputBinding:
      glob: $(inputs.highlight_data_output)
  - id: output
    type:
      - 'null'
      - Directory
    doc: If present, data and vega-lite specs of the generated plot will be 
      split and written to the given directory
    outputBinding:
      glob: $(inputs.output)
  - id: read_data_output
    type:
      - 'null'
      - File
    doc: If present read data will be written to the given file path
    outputBinding:
      glob: $(inputs.read_data_output)
  - id: ref_data_output
    type:
      - 'null'
      - File
    doc: If present reference data will be written to the given file path
    outputBinding:
      glob: $(inputs.ref_data_output)
  - id: spec_output
    type:
      - 'null'
      - File
    doc: If present vega-lite specs will be written to the given file path
    outputBinding:
      glob: $(inputs.spec_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignoth:1.4.6--h1520f10_0
