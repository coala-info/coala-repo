cwlVersion: v1.2
class: CommandLineTool
baseCommand: dodge
label: dodge
doc: "Dodge is a tool for analyzing genetic variation and identifying outbreaks.\n\
  \nTool homepage: https://github.com/LanLab/dodge"
inputs:
  - id: background_data
    type:
      - 'null'
      - boolean
    doc: data in this input set / time window to be used for background (no 
      outbreak predictions)
    inputBinding:
      position: 101
      prefix: --background_data
  - id: dist_limits
    type:
      - 'null'
      - string
    doc: comma separated list of cluster cutoffs or range or both i.e 1,2,5 or 
      1-8 or 1,2,5-10
    inputBinding:
      position: 101
      prefix: --dist_limits
  - id: distances
    type:
      - 'null'
      - File
    doc: file containing pairwise distances corresponding to the alleleprofiles 
      file (from previous run of this script if applicable)
    inputBinding:
      position: 101
      prefix: --distances
  - id: enddate
    type:
      - 'null'
      - string
    doc: end date for new cluster analysis (format YYYY-MM-DD) if left blank 
      latest date in input metadata will be used
    inputBinding:
      position: 101
      prefix: --enddate
  - id: enterobase_data
    type:
      - 'null'
      - boolean
    doc: metadata and allele profiles downloaded from enterobase, if hierCC in 
      metadata table hierCC will be used for outbreak naming (i.e. column named 
      HCXXX)
    inputBinding:
      position: 101
      prefix: --enterobase_data
  - id: exclude_time_in_static
    type:
      - 'null'
      - boolean
    doc: When identifying clusters with one static threshold do not apply 
      temporal window for cluster, must be used with '--outbreakmethod static'
    inputBinding:
      position: 101
      prefix: --exclude_time_in_static
  - id: inclusters
    type:
      - 'null'
      - File
    doc: existing clusters to be imported
    inputBinding:
      position: 101
      prefix: --inclusters
  - id: inputtype
    type: string
    doc: is input data alleles or snps
    inputBinding:
      position: 101
      prefix: --inputtype
  - id: isolatecolumn
    type:
      - 'null'
      - string
    doc: Name of column in metadata file that contains isolate names that 
      correspond to input variant data, default = 'Strain', 'Name' or 'Isolate'
    inputBinding:
      position: 101
      prefix: --isolatecolumn
  - id: mask
    type:
      - 'null'
      - File
    doc: bed file for reference used to generate SNPs with regions to ignore 
      SNPs (i.e. phages etc)
    inputBinding:
      position: 101
      prefix: --mask
  - id: max_missmatch
    type:
      - 'null'
      - int
    doc: maximum number of missmatches reported between 2 isolates (will default
      to max of --dist_limits + 1 if not set)
    inputBinding:
      position: 101
      prefix: --max_missmatch
  - id: minsize
    type:
      - 'null'
      - int
    doc: smallest cluster size for outbreak detection
    inputBinding:
      position: 101
      prefix: --minsize
  - id: no_cores
    type:
      - 'null'
      - int
    doc: number cores to increase pairwise distance speed
    inputBinding:
      position: 101
      prefix: --no_cores
  - id: nonomenclatureinid
    type:
      - 'null'
      - boolean
    doc: Do not include MGT or HierCC nomenclature in investigation cluster ID
    inputBinding:
      position: 101
      prefix: --nonomenclatureinid
  - id: outbreakmethod
    type:
      - 'null'
      - string
    doc: algorithm for outbreak detection dodge or static
    inputBinding:
      position: 101
      prefix: --outbreakmethod
  - id: outputprefix
    type: string
    doc: output path and prefix for output file generation
    inputBinding:
      position: 101
      prefix: --outputPrefix
  - id: snpqual
    type:
      - 'null'
      - int
    doc: minimum allowable SNP quality score
    inputBinding:
      position: 101
      prefix: --snpqual
  - id: startdate
    type:
      - 'null'
      - string
    doc: start date for new cluster analysis (format YYYY-MM-DD if timesegment =
      week or YYYY-MM if timesegment = month) if left blank earliest date not in
      inclusters will be identified from strain metadata
    inputBinding:
      position: 101
      prefix: --startdate
  - id: static_cutoff
    type:
      - 'null'
      - int
    doc: cutoff for static genetic cutoff method, must be used with 
      '--outbreakmethod static'
    inputBinding:
      position: 101
      prefix: --static_cutoff
  - id: strainmetadata
    type: File
    doc: file containing isolate information (downloaded from mgtdb, enterobase 
      or created for SNPs)
    inputBinding:
      position: 101
      prefix: --strainmetadata
  - id: timesegment
    type:
      - 'null'
      - string
    doc: time segment to perform analysis. every month or every week
    inputBinding:
      position: 101
      prefix: --timesegment
  - id: timewindow
    type:
      - 'null'
      - int
    doc: time period a cluster must fall into to be called as investigation 
      --outbreakmethod dodge only --timesegment week default 28 --timesegment 
      month default 2
    inputBinding:
      position: 101
      prefix: --timewindow
  - id: usegenomes
    type:
      - 'null'
      - boolean
    doc: use the consensus.fasta file from snippy to check for missing data when
      a snp is not called, include these genomes in the same folder as input vcf
      files
    inputBinding:
      position: 101
      prefix: --usegenomes
  - id: useref
    type:
      - 'null'
      - boolean
    doc: include reference in distances/clusters for snp inputtype
    inputBinding:
      position: 101
      prefix: --useref
  - id: variant_data
    type: File
    doc: file containing allele profiles (tab delimited table) or snp data (path
      to folder containing .subs.vcf files from snippy, and optionally 
      consensus.fasta masked genomes.)
    inputBinding:
      position: 101
      prefix: --variant_data
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dodge:1.0.1--pyhdfd78af_0
stdout: dodge.out
