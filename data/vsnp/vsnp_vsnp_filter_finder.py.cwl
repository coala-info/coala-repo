cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_filter_finder.py
label: vsnp_vsnp_filter_finder.py
doc: "Find positions with low quality or low mapping quality across the VCF files in the working\
  \ directory and list candidates to filter.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: working_directory
    type:
      - 'null'
      - string
    doc: 'Working directory to be added as path to dependency files (absolute path; default:
      current folder)'
    inputBinding:
      position: 101
      prefix: --cwd
  - id: defining_snp_filter_file
    type:
      - 'null'
      - File
    doc: Defining SNPs/Filter file
    inputBinding:
      position: 101
      prefix: --filters
  - id: group
    type:
      - 'null'
      - string
    doc: Group/directory name
    inputBinding:
      position: 101
      prefix: --group
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turn off map.pooling of samples
    inputBinding:
      position: 101
      prefix: --debug
  - id: vcf_files
    type:
      type: array
      items: File
    doc: VCF files to scan (staged in the working directory)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: positions_to_filter
    type:
      type: array
      items: File
    doc: Positions and details files
    outputBinding:
      glob:
        - '*_positions_to_filter.txt'
        - '*_positions_to_filter_details.txt'
        - '*_good_snps_details.txt'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.vcf_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_filter_finder.py.out
