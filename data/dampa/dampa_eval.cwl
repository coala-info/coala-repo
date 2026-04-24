cwlVersion: v1.2
class: CommandLineTool
baseCommand: dampa eval
label: dampa_eval
doc: "Check probe coverage against genomes or capture files.\n\nTool homepage: https://github.com/MultipathogenGenomics/dampa"
inputs:
  - id: clusterassign
    type:
      - 'null'
      - File
    doc: clstr file from cd-hit
    inputBinding:
      position: 101
      prefix: --clusterassign
  - id: clustertype
    type:
      - 'null'
      - string
    doc: type of cluster file input cdhit (produced by cdhit) or tabular (genome
      and cluster tab delimited)
    inputBinding:
      position: 101
      prefix: --clustertype
  - id: filtnonstandard
    type:
      - 'null'
      - boolean
    doc: remove genomes with non standard nucleotides i.e. not A,T,G,C or N
    inputBinding:
      position: 101
      prefix: --filtnonstandard
  - id: input
    type: Directory
    doc: Genomes to check probe coverage. If genomes either folder containing 
      individual genome fasta files OR a single fasta file containing all 
      genomes (files must end in .fna, .fa or .fasta) If capture file then a pt 
      file from a previous pangraph design or pangraph eval run
    inputBinding:
      position: 101
      prefix: --input
  - id: inputtype
    type:
      - 'null'
      - string
    doc: type of cluster file input cdhit (produced by cdhit) or tabular (genome
      and cluster tab delimited)
    inputBinding:
      position: 101
      prefix: --inputtype
  - id: keeplogs
    type:
      - 'null'
      - boolean
    doc: keep logs containing output from pangraph and probetools
    inputBinding:
      position: 101
      prefix: --keeplogs
  - id: keeptmp
    type:
      - 'null'
      - boolean
    doc: keep intermediate files from pangraph and probetools
    inputBinding:
      position: 101
      prefix: --keeptmp
  - id: maxdepth_describe
    type:
      - 'null'
      - int
    doc: Maximum depth of probe coverage to describe separately. i.e. if 1 there
      will be 0,1 and >1 depth categories
    inputBinding:
      position: 101
      prefix: --maxdepth_describe
  - id: nodust
    type:
      - 'null'
      - boolean
    doc: Do not run low complexity filter in BLAST (within probetools). If 
      sample has very low GC or is very repetitive this option can be enabled to
      prevent low complexity regions from being removed
    inputBinding:
      position: 101
      prefix: --nodust
  - id: outputfolder
    type:
      - 'null'
      - Directory
    doc: path to output folder
    inputBinding:
      position: 101
      prefix: --outputfolder
  - id: outputprefix
    type:
      - 'null'
      - string
    doc: prefix for all output files and folders
    inputBinding:
      position: 101
      prefix: --outputprefix
  - id: probelen
    type:
      - 'null'
      - int
    doc: length of output probes
    inputBinding:
      position: 101
      prefix: --probelen
  - id: probes
    type: File
    doc: Fasta file containing probes to evaluate (files must end in .fna, .fa 
      or .fasta)
    inputBinding:
      position: 101
      prefix: --probes
  - id: probetools0covnmin
    type:
      - 'null'
      - int
    doc: Minimum length (bp) of 0 coverage region in input genomes to trigger 
      design of additional probes
    inputBinding:
      position: 101
      prefix: --probetools0covnmin
  - id: probetoolsalignmin
    type:
      - 'null'
      - int
    doc: Minimum length (bp) of probe-target binding to allow call of binding
    inputBinding:
      position: 101
      prefix: --probetoolsalignmin
  - id: probetoolsidentity
    type:
      - 'null'
      - int
    doc: Minimum identity in probe match to target to call probe binding
    inputBinding:
      position: 101
      prefix: --probetoolsidentity
  - id: report0covperc
    type:
      - 'null'
      - float
    doc: threshold above which genomes are reported as having too much of their 
      genome not covered by any probes
    inputBinding:
      position: 101
      prefix: --report0covperc
  - id: shannonthresh
    type:
      - 'null'
      - float
    doc: minimum shannon entropy of probes and reported coverage regions 
      (filters out low complexity probes/regions)
    inputBinding:
      position: 101
      prefix: --shannonthresh
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dampa:0.2.0--pyhdfd78af_0
stdout: dampa_eval.out
