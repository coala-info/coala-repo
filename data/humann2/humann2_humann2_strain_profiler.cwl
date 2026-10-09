cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_strain_profiler
label: humann2_humann2_strain_profiler
doc: "HUMAnN2 utility for making strain profiles. Based on the principle of detecting variable presence and absence of gene families within a species that is otherwise well-covered in multiple samples.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input
    type: File
    doc: "Original output table (tsv or biom format)"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: critical_mean
    type:
      - 'null'
      - float
    doc: "Default mean non-zero gene abundance for inclusion; default=10.0"
    inputBinding:
      position: 102
      prefix: "--critical_mean"
  - id: critical_count
    type:
      - 'null'
      - int
    doc: "Default non-zero number of genes for inclusion; default=500"
    inputBinding:
      position: 103
      prefix: "--critical_count"
  - id: pinterval
    type:
      - 'null'
      - type: array
        items: float
    doc: "Only genes with prevalence in this interval are allowed: two numbers; default=[1e-10, 1]"
    inputBinding:
      position: 104
      prefix: "--pinterval"
  - id: critical_samples
    type:
      - 'null'
      - int
    doc: "Threshold number of samples having strain; default=2"
    inputBinding:
      position: 105
      prefix: "--critical_samples"
  - id: limit
    type:
      - 'null'
      - string
    doc: "Limit output to species matching a particular pattern, e.g. 'Streptococcus'; default=OFF"
    inputBinding:
      position: 106
      prefix: "--limit"
outputs:
  - id: profiles
    type:
      type: array
      items: File
    doc: "strain profile tables written to the working directory"
    outputBinding:
      glob: "*strain_profile*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
stdout: humann2_strain_profiler.out
