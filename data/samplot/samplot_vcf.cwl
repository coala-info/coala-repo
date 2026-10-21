cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samplot
  - vcf
label: samplot_vcf
doc: "Plots structural variants from VCF and BAM/CRAM files.\n\nTool homepage: https://github.com/ryanlayer/samplot"
inputs:
  - id: bams
    type:
      type: array
      items: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
    doc: Space-delimited list of BAM/CRAM file names
    inputBinding:
      position: 101
      prefix: --bams
  - id: command_file
    type:
      - 'null'
      - string
    default: samplot_vcf_cmds.tmp
    doc: store commands in this file.
    inputBinding:
      position: 101
      prefix: --command_file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: prints out the reason for skipping any skipped variant entry
    inputBinding:
      position: 101
      prefix: --debug
  - id: dn_only
    type:
      - 'null'
      - boolean
    doc: plots only putative de novo variants (PED file required)
    inputBinding:
      position: 101
      prefix: --dn_only
  - id: downsample
    type:
      - 'null'
      - int
    doc: Number of normal reads/pairs to plot
    inputBinding:
      position: 101
      prefix: --downsample
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --filter
    doc: simple filter that samples must meet. Join multiple filters with '&' 
      and specify --filter multiple times for 'or' e.g. DHFFC < 0.7 & SVTYPE = 
      'DEL'
    inputBinding:
      position: 101
  - id: format
    type:
      - 'null'
      - string
    doc: comma separated list of FORMAT fields to include in sample plot title
    inputBinding:
      position: 101
      prefix: --format
  - id: gff3
    type:
      - 'null'
      - File
    doc: genomic regions (.gff with .tbi in same directory) used when building 
      HTML table and table filters
    inputBinding:
      position: 101
      prefix: --gff3
  - id: important_regions
    type:
      - 'null'
      - File
    doc: only report variants that overlap regions in this bed file
    inputBinding:
      position: 101
      prefix: --important_regions
  - id: manual_run
    type:
      - 'null'
      - boolean
    doc: disables auto-run for the plotting commands
    inputBinding:
      position: 101
      prefix: --manual_run
  - id: max_entries
    type:
      - 'null'
      - int
    doc: only plot at most this many heterozygotes
    inputBinding:
      position: 101
      prefix: --max_entries
  - id: max_hets
    type:
      - 'null'
      - int
    doc: only plot variants with at most this many heterozygotes
    inputBinding:
      position: 101
      prefix: --max_hets
  - id: max_mb
    type:
      - 'null'
      - float
    doc: skip variants longer than this many megabases
    inputBinding:
      position: 101
      prefix: --max_mb
  - id: min_bp
    type:
      - 'null'
      - int
    doc: skip variants shorter than this many bases
    inputBinding:
      position: 101
      prefix: --min_bp
  - id: min_call_rate
    type:
      - 'null'
      - float
    doc: only plot variants with at least this call-rate
    inputBinding:
      position: 101
      prefix: --min_call_rate
  - id: min_entries
    type:
      - 'null'
      - int
    doc: try to include homref samples as controls to get this many samples in 
      plot
    inputBinding:
      position: 101
      prefix: --min_entries
  - id: out_dir
    type:
      - 'null'
      - string
    default: samplot-out
    doc: path to write output images
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: output_type
    type:
      - 'null'
      - string
    doc: type of output figure
    inputBinding:
      position: 101
      prefix: --output_type
  - id: ped
    type:
      - 'null'
      - File
    doc: path to ped (or .fam) file
    inputBinding:
      position: 101
      prefix: --ped
  - id: plot_all
    type:
      - 'null'
      - boolean
    doc: plots all samples and all variants - limited by any filtering arguments
      set
    inputBinding:
      position: 101
      prefix: --plot_all
  - id: sample_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-delimited list of sample IDs, must have same order as BAM/CRAM 
      file names. BAM RG tag required if this is omitted.
    inputBinding:
      position: 101
      prefix: --sample_ids
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: VCF file containing structural variants
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: out_dir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory with the plots and index.html
    outputBinding:
      glob: $(inputs.out_dir)
  - id: command_file_out
    type:
      - 'null'
      - File
    doc: File with the plotting commands
    outputBinding:
      glob: $(inputs.command_file)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samplot:1.3.0--pyh5e36f6f_1
stdout: samplot_vcf.out
