cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - vdj
label: cellranger_vdj
doc: |-
  Assembles single-cell VDJ receptor sequences from 10x Immune Profiling libraries.
  The container sees only the files passed to it. Cell Ranger finds FASTQs by name: <sample>_S1_L001_<read>_001.fastq.gz, where <sample>
  is the --sample value (or the libraries CSV sample column).
  Pass the FASTQs as a folder (fastqs) or as files (fastq_files); with fastq_files and no
  fastqs, --fastqs is the working directory.
arguments:
  - position: 100
    valueFrom: '${ if (inputs.fastq_files && inputs.fastq_files.length && !inputs.fastqs)
      return ["--fastqs", runtime.outdir]; return null; }'
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
  - id: reference
    type:
      - 'null'
      - Directory
    doc: Path of folder containing 10x-compatible VDJ reference. Optional if 
      '--denovo' is specified
    inputBinding:
      position: 101
      prefix: --reference
  - id: fastqs
    type:
      - 'null'
      - Directory
    doc: |-
      Folder of input FASTQs, named <sample>_S1_L001_<read>_001.fastq.gz. The folder is
      mounted as it is: symlinks in it that point outside it do not resolve inside the
      container. To give SRA files 10x names by linking, pass the links in fastq_files.
    inputBinding:
      position: 101
      prefix: --fastqs
  - id: project
    type:
      - 'null'
      - string
    doc: Name of the project folder within a mkfastq or bcl2fastq-generated 
      folder to pick FASTQs from
    inputBinding:
      position: 101
      prefix: --project
  - id: sample
    type:
      - 'null'
      - string
    doc: |-
      Prefix of the filenames of FASTQs to select: <sample> in
      <sample>_S1_L001_<read>_001.fastq.gz
    inputBinding:
      position: 101
      prefix: --sample
  - id: fastq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: |-
      FASTQ files to stage in the working directory. Use this instead of fastqs when
      the files are not already in one folder under 10x names: link each file under
      its 10x name and pass the links; they are staged under the link names.
      Each must be named <sample>_S1_L001_<read>_001.fastq.gz (<sample> as in sample).
      Gene Expression: R1 = cell barcode + UMI (28 bp), R2 = cDNA read; V(D)J: R1 =
      barcode + UMI, R2 = the receptor read. SRA downloads are named SRR..._1/_2.fastq.gz:
      check each file's read length (zcat f | head -2) to tell R1 from R2.
  - id: lanes
    type:
      - 'null'
      - string
    doc: Only use FASTQs from selected lanes
    inputBinding:
      position: 101
      prefix: --lanes
  - id: denovo
    type:
      - 'null'
      - boolean
    doc: Run in reference-free mode (do not use annotations)
    inputBinding:
      position: 101
      prefix: --denovo
  - id: chain
    type:
      - 'null'
      - string
    doc: "Chain type to display metrics for: 'TR' for T cell receptors, 'IG' for B
      cell receptors, or 'auto' to autodetect"
    inputBinding:
      position: 101
      prefix: --chain
  - id: inner_enrichment_primers
    type:
      - 'null'
      - File
    doc: If inner enrichment primers other than those provided in the 10x kits 
      are used, they need to be specified here as a textfile with one primer per
      line. Disable secondary analysis, e.g. clustering
    inputBinding:
      position: 101
      prefix: --inner-enrichment-primers
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
  - class: InitialWorkDirRequirement
    listing:
      - '$(inputs.fastq_files ? inputs.fastq_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
