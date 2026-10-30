cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_group_on_defining_snps.py
label: vsnp3_vsnp3_group_on_defining_snps.py
doc: "Group samples on a defining SNP position from the dictionary of dataframes (pickle)\
  \ written by vsnp3_step2.py --debug, and build tables and a tree for the group.\n\nTool\
  \ homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: pickle_file
    type:
      - 'null'
      - File
    doc: 'Pickle file: dictionary of dataframes'
    inputBinding:
      position: 101
      prefix: -p
  - id: gbk
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Optional: gbk to annotate VCF file. Multiple can be specified with wildcard'
    inputBinding:
      position: 101
      prefix: -b
  - id: metadata
    type:
      - 'null'
      - File
    doc: 'Explicit metadata file. Two column Excel file --> Column One: VCF file name, Column
      Two: Updated name'
    inputBinding:
      position: 101
      prefix: -m
  - id: defining_snps
    type:
      - 'null'
      - File
    doc: Defining SNPs with positions to filter. See template_define_filter.xlsx
    inputBinding:
      position: 101
      prefix: -s
  - id: abs_pos
    type:
      - 'null'
      - string
    doc: Must be supplied with --group option. Format as chrom in VCF, likely chrom:10000...
      NC_002945.4:2138896.
    inputBinding:
      position: 101
      prefix: -abs_pos
  - id: group
    type:
      - 'null'
      - string
    doc: Must be supplied with --abs_pos option
    inputBinding:
      position: 101
      prefix: -group
  - id: qual_threshold
    type:
      - 'null'
      - int
    doc: 'Optional: Minimum QUAL threshold for calling a SNP'
    inputBinding:
      position: 101
      prefix: -w
  - id: n_threshold
    type:
      - 'null'
      - int
    doc: 'Optional: Minimum N threshold. SNPs between this and qual_threshold are reported
      as N'
    inputBinding:
      position: 101
      prefix: -x
  - id: mq_threshold
    type:
      - 'null'
      - int
    doc: 'Optional: At least one position per group must have this minimum MQ threshold to
      be called.'
    inputBinding:
      position: 101
      prefix: -y
  - id: reference_type
    type:
      - 'null'
      - string
    doc: Reference type group/directory with dependencies
    inputBinding:
      position: 101
      prefix: -t
  - id: filter_density
    type:
      - 'null'
      - boolean
    doc: 'Optional: Remove SNPs when density threshold is exceeded within specified window
      size'
    inputBinding:
      position: 101
      prefix: --filter_density
  - id: density_threshold
    type:
      - 'null'
      - int
    doc: 'Optional: Minimum number of SNPs required to trigger density filtering (default:
      3)'
    inputBinding:
      position: 101
      prefix: --density_threshold
  - id: density_window
    type:
      - 'null'
      - int
    doc: 'Optional: Window size in base pairs for density filtering (default: 20)'
    inputBinding:
      position: 101
      prefix: --density_window
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Optional: Keep debugging files and run without pooling'
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: group_dirs
    type:
      type: array
      items: Directory
    doc: One folder per group with the FASTA alignment, tree and tables
    outputBinding:
      glob: '*'
      outputEval: $(self.filter(function(f) { return f.class == 'Directory'; }))
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_group_on_defining_snps.py.stdout.txt
