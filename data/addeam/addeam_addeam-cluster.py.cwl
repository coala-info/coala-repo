cwlVersion: v1.2
class: CommandLineTool
baseCommand: addeam-cluster.py
label: addeam_addeam-cluster.py
doc: "Cluster and plot damage profiles.\n\nTool homepage: https://github.com/LouisPwr/AdDeam"
inputs:
  - id: clusters
    type:
      - 'null'
      - int
    doc: Run clustering from 2 to k.
    default: 4
    inputBinding:
      position: 101
      prefix: -k
  - id: input_dir
    type: Directory
    doc: Path to the directory containing the profiles generated with bam2prof.
    inputBinding:
      position: 101
      prefix: -i
  - id: less_plots
    type:
      - 'null'
      - int
    doc: Do not plot probability per sample. Write to TSV only. [off=0,on=1]
    default: 0
    inputBinding:
      position: 101
      prefix: -q
  - id: lib_type
    type:
      - 'null'
      - string
    doc: Type of library reads in your input BAMs. (single, paired, or mixed)
    default: paired
    inputBinding:
      position: 101
      prefix: -lib
  - id: minimum_mapped_reads
    type:
      - 'null'
      - int
    doc: Require at least m reads to be mapped to a reference to be included in 
      clustering
    default: 1000
    inputBinding:
      position: 101
      prefix: -m
  - id: plot_all_profs
    type:
      - 'null'
      - int
    doc: Set to 1 if all profs should be plotted individually. Slow!
    default: 0
    inputBinding:
      position: 101
      prefix: -plotall
outputs:
  - id: output_dir
    type: Directory
    doc: Path where your plots will be saved.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0
