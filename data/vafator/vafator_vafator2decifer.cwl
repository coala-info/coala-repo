cwlVersion: v1.2
class: CommandLineTool
baseCommand: vafator2decifer
label: vafator_vafator2decifer
doc: "Generate input for Decifer using VCF file and HATCHet CNA file.\n\nTool homepage: https://github.com/tron-bioinformatics/vafator"
inputs:
  - id: vcf_file
    type: File
    doc: single or multi-sample VCF file
    inputBinding:
      position: 101
      prefix: --vcf_file
  - id: samples
    type: string
    doc: "comma separated list of sample name prefixes to use for VAFator annotations, eg: primary_tumor,metastasis_tumor; the annotations primary_tumor_ac, primary_tumor_dp, etc. will be expected to exist"
    inputBinding:
      position: 102
      prefix: --samples
  - id: cna_file
    type: File
    doc: "HATCHet CNA file: best.seg.ucn"
    inputBinding:
      position: 103
      prefix: --cna_file
  - id: out_dir
    type: string
    doc: directory for printing files; please make unique for each patient!
    inputBinding:
      position: 104
      prefix: --out_dir
  - id: min_depth
    type: int
    doc: minimum depth PER sample
    inputBinding:
      position: 105
      prefix: --min_depth
  - id: min_alt_depth
    type: int
    doc: minimum depth of ALT allele in at least one sample
    inputBinding:
      position: 106
      prefix: --min_alt_depth
  - id: min_vaf
    type: float
    doc: minimum VAF of ALT allele in at least one sample
    inputBinding:
      position: 107
      prefix: --min_vaf
  - id: max_cn
    type:
      - 'null'
      - int
    doc: maximum total copy number for each observed clone
    inputBinding:
      position: 108
      prefix: --max_CN
  - id: exclude_list
    type:
      - 'null'
      - File
    doc: BED file of genomic regions to exclude
    inputBinding:
      position: 109
      prefix: --exclude_list
  - id: min_purity
    type:
      - 'null'
      - float
    doc: minimum purity to consider samples
    inputBinding:
      position: 110
      prefix: --min_purity
  - id: snp_file
    type:
      - 'null'
      - File
    doc: HATCHet file containing germline SNP counts in tumor samples, baf/tumor.1bed
    inputBinding:
      position: 111
      prefix: --snp_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_dir_dir
    type: Directory
    doc: directory with the Decifer input files
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_dir)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vafator:2.2.2--pyhdfd78af_0
stdout: vafator_vafator2decifer.out
