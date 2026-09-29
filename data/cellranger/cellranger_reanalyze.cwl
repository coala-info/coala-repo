cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - reanalyze
label: cellranger_reanalyze
doc: Re-run secondary analysis (dimensionality reduction, clustering, etc)
inputs:
  - id: id
    type: string
    doc: A unique run id and output folder name [a-zA-Z0-9_-]+
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
  - id: matrix
    type: File
    doc: A feature-barcode matrix containing data for one genome. Should be the 
      filtered version, unless using --force-cells
    inputBinding:
      position: 101
      prefix: --matrix
  - id: params
    type:
      - 'null'
      - File
    doc: A CSV file specifying analysis parameters. Optional
    inputBinding:
      position: 101
      prefix: --params
  - id: barcodes
    type:
      - 'null'
      - File
    doc: A CSV file containing a list of cell barcodes to use for reanalysis, 
      e.g. barcodes exported from Loupe Browser. Optional
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: genes
    type:
      - 'null'
      - File
    doc: A CSV file containing a list of feature IDs to use for reanalysis. For 
      gene expression, this should correspond to the gene_id field in the 
      reference GTF should be (e.g. ENSG... for ENSEMBL-based references). 
      Optional
    inputBinding:
      position: 101
      prefix: --genes
  - id: exclude_genes
    type:
      - 'null'
      - File
    doc: A CSV file containing a list of feature IDs to exclude from reanalysis.
      For gene expression, this should correspond to the gene_id field in the 
      reference GTF (e.g., ENSG... for ENSEMBL-based references). The exclusion 
      is applied after --genes. Optional
    inputBinding:
      position: 101
      prefix: --exclude-genes
  - id: agg
    type:
      - 'null'
      - File
    doc: If the input matrix was produced by 'aggr', you may pass the same 
      aggregation CSV in order to retain per-library tag information in the 
      resulting .cloupe file. This argument is required to enable chemistry 
      batch correction. Optional
    inputBinding:
      position: 101
      prefix: --agg
  - id: force_cells
    type:
      - 'null'
      - int
    doc: 'Force pipeline to use this number of cells, bypassing cell calling algorithm.
      [MINIMUM: 10]'
    inputBinding:
      position: 101
      prefix: --force-cells
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
    dockerPull: cumulusprod/cellranger:10.1.0
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
