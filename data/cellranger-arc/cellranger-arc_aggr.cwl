cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger-arc
  - aggr
label: cellranger-arc_aggr
doc: Aggregate data from multiple `cellranger-arc count` runs
inputs:
  - id: id
    type: string
    doc: A unique run id and output folder name [a-zA-Z0-9_-]+ of maximum length
      64 characters
    inputBinding:
      position: 101
      prefix: --id
  - id: description
    type:
      - 'null'
      - string
    doc: Sample description to embed in output files
    inputBinding:
      position: 101
      prefix: --description
  - id: reference
    type: Directory
    doc: 'Path to folder containing cellranger-arc-compatible reference. Reference
      packages can be downloaded from support.10xgenomics.com or constructed using
      the `cellranger-arc mkref` command. Note: this reference must match the reference
      used for the initial `cellranger-arc count` run'
    inputBinding:
      position: 101
      prefix: --reference
  - id: csv
    type: File
    doc: Path to CSV file enumerating 'cellranger-arc count' outputs required 
      for aggregation.
    inputBinding:
      position: 101
      prefix: --csv
  - id: peaks
    type:
      - 'null'
      - File
    doc: 'Override peak caller: specify peaks to use in downstream analyses from supplied
      3-column BED file. The supplied peaks file must be sorted by position and not
      contain overlapping peaks; comment lines beginning with `#` are allowed'
    inputBinding:
      position: 101
      prefix: --peaks
  - id: normalize
    type:
      - 'null'
      - string
    doc: Library depth normalization mode
    inputBinding:
      position: 101
      prefix: --normalize
  - id: nosecondary
    type:
      - 'null'
      - boolean
    doc: Disable secondary analysis, e.g. clustering
    inputBinding:
      position: 101
      prefix: --nosecondary
  - id: dry
    type:
      - 'null'
      - boolean
    doc: Do not execute the pipeline. Generate a pipeline invocation (.mro) file
      and stop
    inputBinding:
      position: 101
      prefix: --dry
  - id: jobmode
    type:
      - 'null'
      - string
    doc: 'Job manager to use. Valid options: local (default), sge, lsf, slurm or path
      to a .template file. Search for help on "Cluster Mode" at support.10xgenomics.com
      for more details on configuring the pipeline to use a compute cluster'
    inputBinding:
      position: 101
      prefix: --jobmode
  - id: localcores
    type:
      - 'null'
      - int
    doc: Set max cores the pipeline may request at one time. Only applies to 
      local jobs
    inputBinding:
      position: 101
      prefix: --localcores
  - id: localmem
    type:
      - 'null'
      - int
    doc: Set max GB the pipeline may request at one time. Only applies to local 
      jobs
    inputBinding:
      position: 101
      prefix: --localmem
  - id: localvmem
    type:
      - 'null'
      - int
    doc: Set max virtual address space in GB for the pipeline. Only applies to 
      local jobs
    inputBinding:
      position: 101
      prefix: --localvmem
  - id: mempercore
    type:
      - 'null'
      - int
    doc: Reserve enough threads for each job to ensure enough memory will be 
      available, assuming each core on your cluster has at least this much 
      memory available. Only applies to cluster jobmodes
    inputBinding:
      position: 101
      prefix: --mempercore
  - id: maxjobs
    type:
      - 'null'
      - int
    doc: Set max jobs submitted to cluster at one time. Only applies to cluster 
      jobmodes
    inputBinding:
      position: 101
      prefix: --maxjobs
  - id: jobinterval
    type:
      - 'null'
      - int
    doc: Set delay between submitting jobs to cluster, in ms. Only applies to 
      cluster jobmodes
    inputBinding:
      position: 101
      prefix: --jobinterval
  - id: overrides
    type:
      - 'null'
      - File
    doc: The path to a JSON file that specifies stage-level overrides for cores 
      and memory. Finer-grained than --localcores, --mempercore and --localmem. 
      Consult https://10xgen.com/resource-override for an example override file
    inputBinding:
      position: 101
      prefix: --overrides
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Output the results to this directory
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: uiport
    type:
      - 'null'
      - int
    doc: Serve web UI at http://localhost:PORT
    inputBinding:
      position: 101
      prefix: --uiport
  - id: disable_ui
    type:
      - 'null'
      - boolean
    doc: Do not serve the web UI
    inputBinding:
      position: 101
      prefix: --disable-ui
  - id: noexit
    type:
      - 'null'
      - boolean
    doc: Keep web UI running after pipestance completes or fails
    inputBinding:
      position: 101
      prefix: --noexit
  - id: nopreflight
    type:
      - 'null'
      - boolean
    doc: Skip preflight checks
    inputBinding:
      position: 101
      prefix: --nopreflight
outputs:
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: Output the results to this directory
    outputBinding:
      glob: $(inputs.output_dir || inputs.id)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger-arc:2.2.0
s:url: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
$namespaces:
  s: https://schema.org/
