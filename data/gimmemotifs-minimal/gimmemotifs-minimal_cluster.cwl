cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - cluster
label: gimmemotifs-minimal_cluster
doc: "Cluster similar motifs\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: no_revcomp
    type:
      - 'null'
      - boolean
    doc: "Don't compare reverse complements of motifs"
    inputBinding:
      position: 1
      prefix: -s
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Cluster threshold"
    inputBinding:
      position: 1
      prefix: -t
  - id: nthreads
    type:
      - 'null'
      - int
    doc: "Number of threads (default 12)"
    inputBinding:
      position: 1
      prefix: --nthreads
  - id: input_file
    type: File
    doc: "Inputfile (PFM format)"
    inputBinding:
      position: 100
  - id: outdir
    type: string
    doc: "Name of output directory"
    inputBinding:
      position: 101
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory with the clustered motifs"
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
