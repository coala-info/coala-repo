cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger-arc
  - mkfastq
label: cellranger-arc_mkfastq
doc: Run Illumina demultiplexer on sample sheets that contain 10x-specific 
  sample index sets, and generate 10x-specific quality metrics after the 
  demultiplex.
inputs:
  - id: run
    type: Directory
    doc: Path of Illumina BCL run folder.
    inputBinding:
      position: 101
      prefix: --run
  - id: id
    type:
      - 'null'
      - string
    doc: Name of the folder created by mkfastq. If not supplied, will default to
      the name of the flowcell referred to by the --run argument.
    inputBinding:
      position: 101
      prefix: --id
  - id: csv
    type:
      - 'null'
      - File
    doc: Path to the sample sheet. The sample sheet can either be a simple CSV 
      with lane, sample and index columns, or an Illumina Experiment 
      Manager-compatible sample sheet. Sample sheet indexes can refer to 10x 
      sample index set names (e.g., SI-GA-A12).
    inputBinding:
      position: 101
      prefix: --csv
  - id: samplesheet
    type:
      - 'null'
      - File
    doc: Path to the sample sheet. Same meaning as --csv.
    inputBinding:
      position: 101
      prefix: --samplesheet
  - id: sample_sheet
    type:
      - 'null'
      - File
    doc: Path to the sample sheet. Same meaning as --csv.
    inputBinding:
      position: 101
      prefix: --sample-sheet
  - id: simple_csv
    type:
      - 'null'
      - File
    doc: Deprecated. Same meaning as --csv.
    inputBinding:
      position: 101
      prefix: --simple-csv
  - id: force_single_index
    type:
      - 'null'
      - boolean
    doc: If 10x-supplied i7/i5 paired indices are specified, but the flowcell 
      was run with only one sample index, allow the demultiplex to proceed using
      the i7 half of the sample index pair.
    inputBinding:
      position: 101
      prefix: --force-single-index
  - id: filter_single_index
    type:
      - 'null'
      - boolean
    doc: Only demultiplex samples identified by an i7-only sample index, 
      ignoring dual-indexed samples. Dual-indexed samples will not be 
      demultiplexed.
    inputBinding:
      position: 101
      prefix: --filter-single-index
  - id: filter_dual_index
    type:
      - 'null'
      - boolean
    doc: Only demultiplex samples identified by i7/i5 dual-indices (e.g., 
      SI-TT-A6), ignoring single-index samples. Single-index samples will not be
      demultiplexed.
    inputBinding:
      position: 101
      prefix: --filter-dual-index
  - id: rc_i2_override
    type:
      - 'null'
      - boolean
    doc: "Indicates if the bases in the I2 read are emitted as reverse complement
      by the sequencing workflow. Set to 'true' for the Reverse Complement Workflow
      (Workflow B)/ NovaSeq Reagent Kit v1.5 or greater. Set to 'false' for the Forward
      Strand Workflow (Workflow A) / older NovaSeq Reagent Kits. NOTE: this parameter
      is autodetected and should only be passed in special circumstances."
    inputBinding:
      position: 101
      prefix: --rc-i2-override
  - id: lanes
    type:
      - 'null'
      - type: array
        items: int
    doc: Comma-delimited series of lanes to demultiplex. Shortcut for the 
      --tiles argument.
    inputBinding:
      position: 101
      prefix: --lanes
      itemSeparator: ','
  - id: use_bases_mask
    type:
      - 'null'
      - string
    doc: Same as bcl2fastq; override the read lengths as specified in 
      RunInfo.xml. See Illumina bcl2fastq documentation for more information.
    inputBinding:
      position: 101
      prefix: --use-bases-mask
  - id: delete_undetermined
    type:
      - 'null'
      - boolean
    doc: Delete the Undetermined FASTQ files left by bcl2fastq Useful if your 
      sample sheet is only expected to match a subset of the flowcell.
    inputBinding:
      position: 101
      prefix: --delete-undetermined
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Same as in bcl2fastq. Folder where FASTQs, reports and stats will be 
      generated.
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: project
    type:
      - 'null'
      - string
    doc: Custom project name, to override the samplesheet or to use in 
      conjunction with the --csv argument.
    inputBinding:
      position: 101
      prefix: --project
  - id: jobmode
    type:
      - 'null'
      - string
    doc: 'Job manager to use. Valid options: local (default), sge, lsf, or a .template
      file'
    inputBinding:
      position: 101
      prefix: --jobmode
  - id: localcores
    type:
      - 'null'
      - int
    doc: Set max cores the pipeline may request at one time. Only applies to 
      local jobs.
    inputBinding:
      position: 101
      prefix: --localcores
  - id: localmem
    type:
      - 'null'
      - int
    doc: Set max GB the pipeline may request at one time. Only applies to local 
      jobs.
    inputBinding:
      position: 101
      prefix: --localmem
  - id: localvmem
    type:
      - 'null'
      - int
    doc: Set max virtual address space in GB for the pipeline. Only applies to 
      local jobs.
    inputBinding:
      position: 101
      prefix: --localvmem
  - id: mempercore
    type:
      - 'null'
      - int
    doc: Reserve enough threads for each job to ensure enough memory will be 
      available, assuming each core on your cluster has at least this much 
      memory available. Only applies in cluster jobmodes.
    inputBinding:
      position: 101
      prefix: --mempercore
  - id: maxjobs
    type:
      - 'null'
      - int
    doc: Set max jobs submitted to cluster at one time. Only applies in cluster 
      jobmodes.
    inputBinding:
      position: 101
      prefix: --maxjobs
  - id: jobinterval
    type:
      - 'null'
      - int
    doc: Set delay between submitting jobs to cluster, in ms. Only applies in 
      cluster jobmodes.
    inputBinding:
      position: 101
      prefix: --jobinterval
  - id: overrides
    type:
      - 'null'
      - File
    doc: The path to a JSON file that specifies stage-level overrides for cores 
      and memory. Finer-grained than --localcores, --mempercore and --localmem. 
      Consult the 10x support website for an example override file.
    inputBinding:
      position: 101
      prefix: --overrides
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
    doc: Do not serve the UI.
    inputBinding:
      position: 101
      prefix: --disable-ui
  - id: noexit
    type:
      - 'null'
      - boolean
    doc: Keep web UI running after pipestance completes or fails.
    inputBinding:
      position: 101
      prefix: --noexit
  - id: nopreflight
    type:
      - 'null'
      - boolean
    doc: Skip preflight checks.
    inputBinding:
      position: 101
      prefix: --nopreflight
outputs:
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: Same as in bcl2fastq. Folder where FASTQs, reports and stats will be 
      generated.
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
