cwlVersion: v1.2
class: CommandLineTool
baseCommand: samplot_vcf
label: samplot_vcf
doc: "Plots structural variants from VCF and BAM/CRAM files.\n\nTool homepage: https://github.com/ryanlayer/samplot"
inputs:
  - id: bams
    type:
      - 'null'
      - type: array
        items: File
    doc: Space-delimited list of BAM/CRAM file names
    default: None
    inputBinding:
      position: 101
      prefix: --bams
  - id: command_file
    type:
      - 'null'
      - File
    doc: store commands in this file.
    default: samplot_vcf_cmds.tmp
    inputBinding:
      position: 101
      prefix: --command_file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: prints out the reason for skipping any skipped variant entry
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: dn_only
    type:
      - 'null'
      - boolean
    doc: plots only putative de novo variants (PED file required)
    default: false
    inputBinding:
      position: 101
      prefix: --dn_only
  - id: downsample
    type:
      - 'null'
      - int
    doc: Number of normal reads/pairs to plot
    default: 1
    inputBinding:
      position: 101
      prefix: --downsample
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
    doc: simple filter that samples must meet. Join multiple filters with '&' 
      and specify --filter multiple times for 'or' e.g. DHFFC < 0.7 & SVTYPE = 
      'DEL'
    default: []
    inputBinding:
      position: 101
      prefix: --filter
  - id: format
    type:
      - 'null'
      - string
    doc: comma separated list of FORMAT fields to include in sample plot title
    default: AS,AP,DHFFC
    inputBinding:
      position: 101
      prefix: --format
  - id: gff3
    type:
      - 'null'
      - File
    doc: genomic regions (.gff with .tbi in same directory) used when building 
      HTML table and table filters
    default: None
    inputBinding:
      position: 101
      prefix: --gff3
  - id: important_regions
    type:
      - 'null'
      - File
    doc: only report variants that overlap regions in this bed file
    default: None
    inputBinding:
      position: 101
      prefix: --important_regions
  - id: manual_run
    type:
      - 'null'
      - boolean
    doc: disables auto-run for the plotting commands
    default: false
    inputBinding:
      position: 101
      prefix: --manual_run
  - id: max_entries
    type:
      - 'null'
      - int
    doc: only plot at most this many heterozygotes
    default: 10
    inputBinding:
      position: 101
      prefix: --max_entries
  - id: max_hets
    type:
      - 'null'
      - int
    doc: only plot variants with at most this many heterozygotes
    default: None
    inputBinding:
      position: 101
      prefix: --max_hets
  - id: max_mb
    type:
      - 'null'
      - float
    doc: skip variants longer than this many megabases
    default: None
    inputBinding:
      position: 101
      prefix: --max_mb
  - id: min_bp
    type:
      - 'null'
      - int
    doc: skip variants shorter than this many bases
    default: 20
    inputBinding:
      position: 101
      prefix: --min_bp
  - id: min_call_rate
    type:
      - 'null'
      - float
    doc: only plot variants with at least this call-rate
    default: None
    inputBinding:
      position: 101
      prefix: --min_call_rate
  - id: min_entries
    type:
      - 'null'
      - int
    doc: try to include homref samples as controls to get this many samples in 
      plot
    default: 6
    inputBinding:
      position: 101
      prefix: --min_entries
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: path to write output images
    default: samplot-out
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: output_type
    type:
      - 'null'
      - string
    doc: type of output figure
    default: png
    inputBinding:
      position: 101
      prefix: --output_type
  - id: ped
    type:
      - 'null'
      - File
    doc: path to ped (or .fam) file
    default: None
    inputBinding:
      position: 101
      prefix: --ped
  - id: plot_all
    type:
      - 'null'
      - boolean
    doc: plots all samples and all variants - limited by any filtering arguments
      set
    default: false
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
    default: None
    inputBinding:
      position: 101
      prefix: --sample_ids
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: VCF file containing structural variants
    default: None
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samplot:1.3.0--pyh5e36f6f_1
stdout: samplot_vcf.out
