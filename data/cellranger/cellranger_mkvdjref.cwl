cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - mkvdjref
label: cellranger_mkvdjref
doc: Prepare a reference for use with Cell Ranger VDJ. Build a Cell Ranger 
  V(D)J-compatible reference folder from user-supplied genome FASTA and gene GTF
  files, or a FASTA file containing V(D)J segments.
inputs:
  - id: genome
    type: string
    doc: Unique genome name, used to name output folder [a-zA-Z0-9_.-]+ (must 
      not start with `.`)
    inputBinding:
      position: 101
      prefix: --genome
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to FASTA file containing your genome reference
    inputBinding:
      position: 101
      prefix: --fasta
  - id: genes
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --genes
          separate: true
    doc: Path to genes GTF file containing annotated genes for your genome 
      reference. Specify multiple genomes by specifying this argument multiple 
      times
    inputBinding:
      position: 101
  - id: seqs
    type:
      - 'null'
      - File
    doc: Path to a FASTA file that directly specifies V(D)J sequences. This is 
      mutually exclusive with the "fasta" and "genes" args
    inputBinding:
      position: 101
      prefix: --seqs
  - id: rm_transcripts
    type:
      - 'null'
      - File
    doc: Path to text file with transcript IDs to ignore. This file should have 
      one transcript ID per line where the IDs correspond to the "transcript_id"
      key in the GTF info column
    inputBinding:
      position: 101
      prefix: --rm-transcripts
  - id: memgb
    type:
      - 'null'
      - int
    doc: Maximum memory (GB) used
    inputBinding:
      position: 101
      prefix: --memgb
  - id: ref_version
    type:
      - 'null'
      - string
    doc: Optional reference version string to include with reference
    inputBinding:
      position: 101
      prefix: --ref-version
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
      glob: $(inputs.output_dir || inputs.genome)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
