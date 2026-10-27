cwlVersion: v1.2
class: CommandLineTool
baseCommand: vSNP_step2.py
label: vsnp_vSNP_step2.py
doc: "Current working directory used by default, but can specify working directory
  with -w. Directory must contain VCF files with file extension \".vcf\"\n\nTool homepage:
  https://github.com/USDA-VS/vSNP"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: create table with all isolates
    inputBinding:
      position: 101
      prefix: --all
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turn off map.pooling of samples
    inputBinding:
      position: 101
      prefix: --debug
  - id: filter_finder
    type:
      - 'null'
      - boolean
    doc: write possible positions to filter to text file
    inputBinding:
      position: 101
      prefix: --filter_finder
  - id: gbk
    type:
      - 'null'
      - File
    doc: 'Optional: provide full path to gbk file'
    inputBinding:
      position: 101
      prefix: --gbk
  - id: no_filters
    type:
      - 'null'
      - boolean
    doc: run without applying filters
    inputBinding:
      position: 101
      prefix: --no_filters
  - id: reference
    type:
      - 'null'
      - string
    doc: provide a valid reference, see -t output
    inputBinding:
      position: 101
      prefix: --reference
  - id: subset
    type:
      - 'null'
      - boolean
    doc: create trees with a subset of sample that represent the whole
    inputBinding:
      position: 101
      prefix: --subset
  - id: table
    type:
      - 'null'
      - boolean
    doc: see valid reference types available
    inputBinding:
      position: 101
      prefix: --table
  - id: vcf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF files (extension .vcf) to compare, staged in the working directory
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: 'Optional: path to VCF files'
    inputBinding:
      position: 101
      prefix: --cwd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: step2_results
    type:
      - 'null'
      - type: array
        items: File
    doc: Tables, trees and summaries written to the working directory
    outputBinding:
      glob: ['*.xlsx', '*.tre', '*.newick', '*.html', '*.fasta', '*.txt', '*.json']
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: >-
      $((inputs.vcf_files ? inputs.vcf_files : []).map(function(f) { return {"entry": f, "writable": true}; }))
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vSNP_step2.py.out
