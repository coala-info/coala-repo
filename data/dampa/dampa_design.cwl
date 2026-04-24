cwlVersion: v1.2
class: CommandLineTool
baseCommand: dampa design
label: dampa_design
doc: "Design probes for pangenomes\n\nTool homepage: https://github.com/MultipathogenGenomics/dampa"
inputs:
  - id: clusterassign
    type:
      - 'null'
      - File
    doc: clstr file from cd-hit
    inputBinding:
      position: 101
      prefix: --clusterassign
  - id: clustercov
    type:
      - 'null'
      - float
    doc: Minimum coverage of genomes over which clusterident must apply (0-1)
    inputBinding:
      position: 101
      prefix: --clustercov
  - id: clusterident
    type:
      - 'null'
      - float
    doc: Minimum identity to cluster genomes
    inputBinding:
      position: 101
      prefix: --clusterident
  - id: clustering_inputno_trigger
    type:
      - 'null'
      - int
    doc: if number of input sequences exceeds this number then cdhit will be 
      used to deduplcate genomes above 99.9 percent identity Set to 0 to always 
      cluster
    inputBinding:
      position: 101
      prefix: --clustering_inputno_trigger
  - id: clustertype
    type:
      - 'null'
      - string
    doc: type of cluster file input cdhit (produced by cdhit) or tabular (genome
      and cluster tab delimited)
    inputBinding:
      position: 101
      prefix: --clustertype
  - id: input
    type: File
    doc: Either folder containing individual genome fasta files OR a single 
      fasta file containing all genomes (files must end in .fna, .fa or .fasta)
    inputBinding:
      position: 101
      prefix: --input
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
  - id: maxambig
    type:
      - 'null'
      - int
    doc: The maximum number of ambiguous bases allowed in a probe
    inputBinding:
      position: 101
      prefix: --maxambig
  - id: maxdepth_describe
    type:
      - 'null'
      - int
    doc: Maximum depth of probe coverage to describe separately. i.e. if 1 there
      will be 0,1 and >1 depth categories
    inputBinding:
      position: 101
      prefix: --maxdepth_describe
  - id: maxdiv
    type:
      - 'null'
      - boolean
    doc: use new maxdiv pangraph version
    inputBinding:
      position: 101
      prefix: --maxdiv
  - id: maxnonspandard
    type:
      - 'null'
      - float
    doc: maximum proportion of genome that can be non ATGC (0-1)
    inputBinding:
      position: 101
      prefix: --maxnonspandard
  - id: minlenforpadding
    type:
      - 'null'
      - int
    doc: minimum length for a pancontig for it to be padded (WARNING setting 
      this below ~80 may result in probes that do not effectively bind, leave 
      these small sequences for final probetools step)
    inputBinding:
      position: 101
      prefix: --minlenforpadding
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
  - id: outlierclustercov
    type:
      - 'null'
      - float
    doc: Minimum coverage of genomes over which clusterident must apply (0-1)
    inputBinding:
      position: 101
      prefix: --outlierclustercov
  - id: outlierclusterident
    type:
      - 'null'
      - float
    doc: outlier identity threshold, i.e. if a cluster is <outlierclusterident 
      and <=outliersizelimit members it is treated as an outlier
    inputBinding:
      position: 101
      prefix: --outlierclusterident
  - id: outliersizelimit
    type:
      - 'null'
      - int
    doc: In two step clustering if a cluster is <=outliersizelimit at both high 
      and low identity then it is treated as an outlier
    inputBinding:
      position: 101
      prefix: --outliersizelimit
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
  - id: padding_nuc
    type:
      - 'null'
      - string
    doc: nucleotide to use for padding probes to args.probelen
    inputBinding:
      position: 101
      prefix: --padding_nuc
  - id: pangraphalpha
    type:
      - 'null'
      - float
    doc: Energy cost for splitting a block during alignment merger. Controls 
      graph fragmentation
    inputBinding:
      position: 101
      prefix: --pangraphalpha
  - id: pangraphbeta
    type:
      - 'null'
      - float
    doc: Energy cost for diversity in the alignment. A high value prevents 
      merging of distantly-related sequences in the same block
    inputBinding:
      position: 101
      prefix: --pangraphbeta
  - id: pangraphdepth
    type:
      - 'null'
      - int
    doc: Minimum depth of a node to allow in pangenome graph. Nodes with depth 
      below this will be removed from the graph. Set to 0 to not remove any 
      nodes based on depth
    inputBinding:
      position: 101
      prefix: --pangraphdepth
  - id: pangraphident
    type:
      - 'null'
      - int
    doc: Pangenome percentage identity setting allowable values are 5,10 or 20
    inputBinding:
      position: 101
      prefix: --pangraphident
  - id: pangraphlen
    type:
      - 'null'
      - int
    doc: Minimum length of a node to allow in pangenome graph
    inputBinding:
      position: 101
      prefix: --pangraphlen
  - id: pangraphstrict
    type:
      - 'null'
      - boolean
    doc: enable the -S strict identity option which limits merges to 
      1/pangraphbeta divergence
    inputBinding:
      position: 101
      prefix: --pangraphstrict
  - id: probelen
    type:
      - 'null'
      - int
    doc: length of output probes
    inputBinding:
      position: 101
      prefix: --probelen
  - id: probestep
    type:
      - 'null'
      - int
    doc: step of probes (for no overlap set to same as probelen)
    inputBinding:
      position: 101
      prefix: --probestep
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
  - id: remove_outliers
    type:
      - 'null'
      - boolean
    doc: perform initial high threshold clustering followed by low threshold 
      clustering of representatives, remove low level clusters composed of one 
      high level cluster with <= outliersizelimit members
    inputBinding:
      position: 101
      prefix: --remove_outliers
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
  - id: skip_padding
    type:
      - 'null'
      - boolean
    doc: do not generate additional probes for pangenome nodes between 
      pangraphlen and probelen in length. i.e. if padding is run 30*T would be 
      added to the end of a 90bp pancontig
    inputBinding:
      position: 101
      prefix: --skip_padding
  - id: skip_probetoolsfinal
    type:
      - 'null'
      - boolean
    doc: do NOT run final probe design step. i.e. this step uses probetools to 
      design probes to regions that are not represented in the pangenome
    inputBinding:
      position: 101
      prefix: --skip_probetoolsfinal
  - id: skip_summaries
    type:
      - 'null'
      - boolean
    doc: do NOT run visualisation generaton of dampa probes relative to input 
      genomes
    inputBinding:
      position: 101
      prefix: --skip_summaries
  - id: skipsubambig
    type:
      - 'null'
      - boolean
    doc: do NOT substitute ambiguous nucleotides (by default N or other 
      ambiguous nucleotides are substituted for ATGC in a random selection 
      weighted by proportions in input genomes
    inputBinding:
      position: 101
      prefix: --skipsubambig
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: unioncov
    type:
      - 'null'
      - boolean
    doc: minimise pangenome graph size by removing nodes represented elsewhere 
      in sections
    inputBinding:
      position: 101
      prefix: --unioncov
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dampa:0.2.0--pyhdfd78af_0
stdout: dampa_design.out
