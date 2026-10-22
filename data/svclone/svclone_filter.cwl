cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svclone
  - filter
label: svclone_filter
doc: "Filter output from process step\n\nTool homepage: https://github.com/mcmero/SVclone"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: "Config file."
    inputBinding:
      position: 101
      prefix: -cfg
  - id: sample
    type: string
    doc: "Sample name. WARNING: if clustering using mutect SNVs, the sample name must match the sample name in the vcf file."
    inputBinding:
      position: 101
      prefix: --sample
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: "Required: Processed structural variation input (comma separated if multiple)."
    inputBinding:
      position: 101
      prefix: --input
      itemSeparator: ","
  - id: germline
    type:
      - 'null'
      - File
    doc: "Germline SVs in output format from process step. If not provided, will assume all SVs are somatic."
    inputBinding:
      position: 101
      prefix: --germline
  - id: cnvs
    type:
      - 'null'
      - File
    doc: "Phased copy-number states from Battenberg. If not provided, all SVs assumed copy-neutral."
    inputBinding:
      position: 101
      prefix: --cnvs
  - id: params
    type:
      - 'null'
      - File
    doc: "Read parameters file containing read length, average insert and insert standard deviation (see README)."
    inputBinding:
      position: 101
      prefix: --params
  - id: snvs
    type:
      - 'null'
      - File
    doc: "SNVs in VCF format to (optionally) compare the clustering with SVs."
    inputBinding:
      position: 101
      prefix: --snvs
  - id: snv_format
    type:
      - 'null'
      - string
    doc: "Supplied SNV VCF is in the following input format: sanger (default), mutect, consensus (PCAWG) or mutect_callstats (non-VCF)."
    inputBinding:
      position: 101
      prefix: --snv_format
  - id: out
    type:
      - 'null'
      - string
    doc: "Output directory. Default: sample name."
    inputBinding:
      position: 101
      prefix: --out
  - id: purity_ploidy
    type:
      - 'null'
      - File
    doc: "Tumour purity ploidy file. See README for format. If not found, default purity = 1 (100%); default ploidy = 2."
    inputBinding:
      position: 101
      prefix: --purity_ploidy
  - id: blacklist
    type:
      - 'null'
      - File
    doc: "Takes a file in BED format as an argument. Filter out any break-pairs where either SV break-end overlaps an interval specified in the supplied bed file."
    inputBinding:
      position: 101
      prefix: --blacklist
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory (the --out value, or the sample name by default).
    outputBinding:
      glob: '$(inputs.out ? inputs.out : inputs.sample)'
  - id: filtered_snvs
    type:
      - 'null'
      - File
    doc: Filtered SNVs (<sample>_filtered_snvs.tsv), written when --snvs is given.
    outputBinding:
      glob: '$((inputs.out ? inputs.out : inputs.sample) + "/" + inputs.sample + "_filtered_snvs.tsv")'
  - id: filtered_svs
    type: File
    doc: Filtered structural variants (<sample>_filtered_svs.tsv).
    outputBinding:
      glob: '$((inputs.out ? inputs.out : inputs.sample) + "/" + inputs.sample + "_filtered_svs.tsv")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
