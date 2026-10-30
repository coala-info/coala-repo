cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_kernel_plots.py
label: vsnp3_vsnp3_kernel_plots.py
doc: "Make a SNP distance kernel density plot or histogram from an alignment FASTA written\
  \ by vSNP step 2.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: fasta
    type: File
    doc: Alignment FASTA (required)
    inputBinding:
      position: 101
      prefix: -f
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Force a sample name
    inputBinding:
      position: 101
      prefix: -n
  - id: xlim_low
    type:
      - 'null'
      - int
    doc: Lower limit of the x-axis
    inputBinding:
      position: 101
      prefix: -xh
  - id: xlim_high
    type:
      - 'null'
      - int
    doc: Upper limit of the x-axis
    inputBinding:
      position: 101
      prefix: -yh
  - id: bin_max
    type:
      - 'null'
      - int
    doc: Max y length
    inputBinding:
      position: 101
      prefix: -bm
  - id: bin_increment
    type:
      - 'null'
      - int
    doc: Bin increment for histogram
    inputBinding:
      position: 101
      prefix: -bi
  - id: color
    type:
      - 'null'
      - string
    doc: Color of the kernel density plot
    inputBinding:
      position: 101
      prefix: -c
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: Generate histogram instead of kernel density plot
    inputBinding:
      position: 101
      prefix: -g
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Keep temp files for debugging
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: plots
    type:
      type: array
      items: File
    doc: Plot images
    outputBinding:
      glob: '*.png'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_kernel_plots.py.stdout.txt
