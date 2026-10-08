cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dmtools
  - dmDMR
label: dmtools_dmDMR
doc: "Differential DNA methylation analysis between two groups of DM files\n\nTool
  homepage: https://github.com/ZhouQiangwei/dmtools"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: output_prefix
    type: string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: -p
  - id: sample1_dm_files
    type:
      type: array
      items: File
    doc: sample1 methy dm files, separated by comma
    inputBinding:
      position: 101
      prefix: '-1'
      itemSeparator: ','
  - id: sample2_dm_files
    type:
      type: array
      items: File
    doc: sample2 methy dm files, separated by comma
    inputBinding:
      position: 101
      prefix: '-2'
      itemSeparator: ','
  - id: min_dmc
    type:
      - 'null'
      - int
    doc: min dmc sites in dmr region. [default 4]
    inputBinding:
      position: 101
      prefix: --mindmc
  - id: min_step
    type:
      - 'null'
      - int
    doc: min step in bp [default 100]
    inputBinding:
      position: 101
      prefix: --minstep
  - id: max_dis
    type:
      - 'null'
      - int
    doc: max length of dmr [default 0]
    inputBinding:
      position: 101
      prefix: --maxdis
  - id: pvalue
    type:
      - 'null'
      - float
    doc: 'pvalue cutoff, default: 0.01'
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: fdr
    type:
      - 'null'
      - float
    doc: 'adjust pvalue cutoff, default: 1.0'
    inputBinding:
      position: 101
      prefix: --fdr
  - id: methdiff
    type:
      - 'null'
      - float
    doc: 'the cutoff of methylation differention. default: 0.25 [CpG]'
    inputBinding:
      position: 101
      prefix: --methdiff
  - id: element
    type:
      - 'null'
      - File
    doc: caculate gene or TE etc function elements.
    inputBinding:
      position: 101
      prefix: --element
  - id: context
    type:
      - 'null'
      - string
    doc: Context for DM. C/CG/CHG/CHH, [C]
    inputBinding:
      position: 101
      prefix: --context
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: dmr_results
    type:
      type: array
      items: File
    doc: Result files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
stdout: dmtools_dmDMR.out
