cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Run_abSENSE.py
label: Run_abSENSE.py
doc: abSENSE arguments
inputs:
  - id: distfile
    type: File
    doc: Required. Name of file containing pairwise evolutionary distances 
      between focal species and each of the other species
    inputBinding:
      position: 101
      prefix: --distfile
  - id: scorefile
    type: File
    doc: Required. Name of file containing bitscores between focal species gene 
      and orthologs in other species
    inputBinding:
      position: 101
      prefix: --scorefile
  - id: eval
    type:
      - 'null'
      - float
    doc: Optional. E-value threshold. Scientific notation (e.g. 10E-5) accepted.
      Default 0.001.
    inputBinding:
      position: 101
      prefix: --Eval
  - id: includeonly
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional. Species whose orthologs' bitscores will be included in fit; 
      all others will be omitted. Default is all species. Format as species 
      names, exactly as in input files, separated by commas (no spaces).
    inputBinding:
      position: 101
      prefix: --includeonly
      itemSeparator: ','
  - id: genelenfile
    type:
      - 'null'
      - File
    doc: Optional. File containing lengths (aa) of all genes to be analyzed. 
      Used to accurately calculate E-value threshold. Default is 400aa for all 
      genes. Only large deviations will qualitatively affect results.
    inputBinding:
      position: 101
      prefix: --genelenfile
  - id: dblenfile
    type:
      - 'null'
      - File
    doc: Optional. File containing size (aa) of databases on which the 
      anticipated homology searches will be performed. Species-specific. Used to
      accurately calculate E-value threshold. Default is 400aa/gene * 20,000 
      genes for each species, intended to be the size of an average proteome. 
      Only large deviations will significantly affect results.
    inputBinding:
      position: 101
      prefix: --dblenfile
  - id: predall
    type:
      - 'null'
      - string
    doc: Predict bitscores and P(detectable) of homologs in all species, 
      including those where homologs were detected. Off unless set.
    inputBinding:
      position: 101
      prefix: --predall
      valueFrom: '$(self ? "True" : null)'
  - id: out
    type:
      - 'null'
      - string
    doc: Optional. Name of directory for output data. Default is date and time 
      when analysis was run.
    default: abSENSE_results
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: output_out
    type:
      - 'null'
      - Directory
    doc: Optional. Name of directory for output data. Default is date and time 
      when analysis was run.
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0
s:url: https://github.com/caraweisman/abSENSE
$namespaces:
  s: https://schema.org/
