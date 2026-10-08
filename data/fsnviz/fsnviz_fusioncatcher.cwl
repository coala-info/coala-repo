cwlVersion: v1.2
class: CommandLineTool
baseCommand: fsnviz
label: fsnviz_fusioncatcher
doc: "Plots output of FusionCatcher using circos.\n\nTool homepage: https://github.com/bow/fsnviz"
inputs:
  - id: out_dir
    type:
      - 'null'
      - string
    doc: 'Output directory. Default: current run directory.'
    inputBinding:
      position: 1
      prefix: --out-dir
  - id: base_name
    type:
      - 'null'
      - string
    doc: Base file name of the image output. Filename extensions will be added accordingly.
    inputBinding:
      position: 2
      prefix: --base-name
  - id: karyotype
    type:
      - 'null'
      - string
    doc: 'Karyotype to use: human.hg19 or human.hg38. Must be supported by circos.
      Ignored if karyotype_file is given. Default: human.hg19.'
    inputBinding:
      position: 3
      prefix: --karyotype
  - id: circos_conf
    type:
      - 'null'
      - File
    doc: Circos configuration file. If not supplied, fsnviz generates a default one.
    inputBinding:
      position: 4
      prefix: --circos-conf
  - id: png
    type:
      - 'null'
      - boolean
    doc: 'Create PNG plots (default: no).'
    inputBinding:
      position: 5
      prefix: --png
  - id: no_svg
    type:
      - 'null'
      - boolean
    doc: 'Do not create SVG plots (default: SVG plots are created).'
    inputBinding:
      position: 6
      prefix: --no-svg
  - id: karyotype_file
    type:
      - 'null'
      - File
    doc: Karyotype file to use. This parameter takes precedence over the karyotype
      parameter.
    inputBinding:
      position: 7
      prefix: --karyotype-file
  - id: circos_exe
    type:
      - 'null'
      - string
    doc: 'Circos executable. Default: circos (the one accessible via PATH).'
    inputBinding:
      position: 8
      prefix: --circos-exe
  - id: input
    type: File
    doc: Output file of FusionCatcher to plot.
    inputBinding:
      position: 30
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: plots
    type:
      type: array
      items: File
    doc: Plot images (SVG and/or PNG)
    outputBinding:
      glob: '${ var o = inputs.out_dir ? inputs.out_dir + ''/'' : ''''; return [o
        + ''*.svg'', o + ''*.png'']; }'
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory (--out-dir)
    outputBinding:
      glob: '${ return inputs.out_dir ? inputs.out_dir : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fsnviz:0.3.0--py35_1
stdout: fsnviz_fusioncatcher.out
arguments:
  - position: 20
    valueFrom: fusioncatcher
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ if (inputs.out_dir) { return [{"entryname": inputs.out_dir, "entry":
      {"class": "Directory", "listing": []}, "writable": true}]; } return []; }'
