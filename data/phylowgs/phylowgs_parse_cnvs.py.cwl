cwlVersion: v1.2
class: CommandLineTool
baseCommand: [python, /usr/local/share/phylowgs/parser/parse_cnvs.py]
label: phylowgs_parse_cnvs.py
doc: "Create CNV input file for parser from Battenberg or TITAN data\n\nTool
  homepage: https://github.com/morrislab/phylowgs"
inputs:
  - id: cnv_file
    type: File
    doc: Copy-number calls from Battenberg or TITAN
    inputBinding:
      position: 2
  - id: cnv_format
    type:
      type: enum
      symbols: [battenberg, battenberg-smchet, titan]
    doc: Type of CNV input
    inputBinding:
      position: 1
      prefix: --cnv-format
  - id: cellularity
    type: float
    doc: Fraction of sample that is cancerous rather than somatic. Used only for
      estimating CNV confidence -- if no CNVs, need not specify argument.
    inputBinding:
      position: 1
      prefix: --cellularity
  - id: cnv_output_filename
    type: ['null', string]
    default: cnvs.txt
    doc: Output destination for parsed CNVs
    inputBinding:
      position: 1
      prefix: --cnv-output
outputs:
  - id: cnv_output
    type: File
    doc: Parsed CNVs
    outputBinding:
      glob: $(inputs.cnv_output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylowgs:20181105--py27ha7db03b_3
