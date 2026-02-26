cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_vsnp3_step2.py
label: vsnp3_vsnp3_step2.py
doc: "Store VCF files from vSNP step1 to step 2 directory. VCF files must be stored
  by reference type. Make a VCF file directory database that will build over time
  as samples are ran in step 1\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: abs_pos
    type:
      - 'null'
      - string
    doc: 'Optional: Make a group on defining SNP. Must be supplied with --group option.
      Format as chrom in VCF, chrom:10000.'
    inputBinding:
      position: 101
      prefix: --abs_pos
  - id: all_vcf
    type:
      - 'null'
      - boolean
    doc: 'Optional: create table with all isolates'
    inputBinding:
      position: 101
      prefix: --all_vcf
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Optional: Keep debugging files and run without pooling. A pickle file will
      be kept for troubleshooting to be used directly in vsnp3_group_on_defining_snps.py.
      This saves processing time'
    inputBinding:
      position: 101
      prefix: --debug
  - id: defining_snps
    type:
      - 'null'
      - File
    doc: 'Optional: Defining SNPs with positions to filter. See template_define_filter.xlsx
      in vsnp dependency folder. Recommended having this file in reference type folder'
    inputBinding:
      position: 101
      prefix: --defining_snps
  - id: density_threshold
    type:
      - 'null'
      - int
    doc: 'Optional: Minimum number of SNPs required to trigger density filtering (default:
      3)'
    default: 3
    inputBinding:
      position: 101
      prefix: --density_threshold
  - id: density_window
    type:
      - 'null'
      - int
    doc: 'Optional: Window size in base pairs for density filtering (default: 20)'
    default: 20
    inputBinding:
      position: 101
      prefix: --density_window
  - id: dp
    type:
      - 'null'
      - boolean
    doc: 'Optional: Include average depth of coverage in tables'
    inputBinding:
      position: 101
      prefix: --dp
  - id: find_new_filters
    type:
      - 'null'
      - boolean
    doc: 'Optional: find new positions to apply to the filter file. Positions must
      be manually added to filter file. They are not added by running this command.
      Only text files are output showing position detail. Curant before adding filters'
    inputBinding:
      position: 101
      prefix: --find_new_filters
  - id: fix_vcfs
    type:
      - 'null'
      - boolean
    doc: 'Optional: Just fix VCF files and exit'
    inputBinding:
      position: 101
      prefix: --fix_vcfs
  - id: gbk_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Optional: gbk to annotate VCF file. Multiple gbk files can be specified
      with wildcard'
    inputBinding:
      position: 101
      prefix: --gbk
  - id: group
    type:
      - 'null'
      - string
    doc: 'Optional: Name a group on defining SNP. Must be supplied with --abs_pos
      option'
    inputBinding:
      position: 101
      prefix: --group
  - id: hash_groups
    type:
      - 'null'
      - boolean
    doc: 'Optional: The option will run defining snps marked with a # in the defining
      snps file. The # is removed and the defining snps are run.'
    inputBinding:
      position: 101
      prefix: --hash_groups
  - id: html_tree
    type:
      - 'null'
      - boolean
    doc: 'Optional: Generate HTML tree visualization (automatically enables -dp)'
    inputBinding:
      position: 101
      prefix: --html_tree
  - id: keep_ind_vcfs
    type:
      - 'null'
      - boolean
    doc: 'Optional: Keep VCF files in current working directory when VCF files in
      current working director are used, VCF files are always saved and zipped in
      "vcf_starting_files.zip".'
    inputBinding:
      position: 101
      prefix: --keep_ind_vcfs
  - id: metadata
    type:
      - 'null'
      - File
    doc: 'Optional: Two column Excel file, Column One: full VCF file name, Column
      Two: Updated name. Recommended having this file in reference type folder'
    inputBinding:
      position: 101
      prefix: --metadata
  - id: mq_threshold
    type:
      - 'null'
      - float
    doc: 'Optional: At least one position per group must have this minimum MQ threshold
      to be called.'
    inputBinding:
      position: 101
      prefix: --mq_threshold
  - id: n_threshold
    type:
      - 'null'
      - float
    doc: 'Optional: Minimum N threshold. SNPs between this and qual_threshold are
      reported as N'
    inputBinding:
      position: 101
      prefix: --n_threshold
  - id: no_filters
    type:
      - 'null'
      - boolean
    doc: 'Optional: turn off filters'
    inputBinding:
      position: 101
      prefix: --no_filters
  - id: qual_threshold
    type:
      - 'null'
      - float
    doc: 'Optional: Minimum QUAL threshold for calling a SNP'
    inputBinding:
      position: 101
      prefix: --qual_threshold
  - id: reference_type
    type:
      - 'null'
      - string
    doc: 'Optional: A valid reference_type name will be automatically found, but a
      valid reference_type name can be supplied. See vsnp3_path_adder.py -s'
    inputBinding:
      position: 101
      prefix: --reference_type
  - id: remove_by_name
    type:
      - 'null'
      - File
    doc: 'Optional: Excel file containing samples to remove from analysis Column 1:
      to match sample name minus extension. No header allowed. Recommended having
      this file in reference type folder'
    inputBinding:
      position: 101
      prefix: --remove_by_name
  - id: show_groups
    type:
      - 'null'
      - boolean
    doc: Show group names in SNP table
    inputBinding:
      position: 101
      prefix: --show_groups
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: 'Optional: path to VCF files. By default .vcf in current working directory
      are used.'
    inputBinding:
      position: 101
      prefix: --wd
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Optional: Provide a name. This name will be a directory output files are
      writen to. Name can be a directory path, but doesn't have to be. By default
      VCF files are worked on in your current working directory"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
