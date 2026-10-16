cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger-arc
  - count
label: cellranger-arc_count
doc: |-
  Count ATAC and gene expression reads from a single library.
  The container sees only the files passed to it: list every FASTQ in fastq_files and set
  the libraries CSV fastqs column to '.'. Cell Ranger ARC finds FASTQs by name, so each must
  be named <sample>_S1_L001_<read>_001.fastq.gz, where <sample> is the CSV sample column.
  Rename or link SRA files (SRR..._1.fastq.gz) to that form first; see fastq_files.
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
    doc: Path to folder containing cellranger-arc-compatible reference. 
      Reference packages can be downloaded from support.10xgenomics.com or 
      constructed using the `cellranger-arc mkref` command
    inputBinding:
      position: 101
      prefix: --reference
  - id: libraries
    type: File
    loadContents: true
    doc: |-
      Path to 3-column CSV (fastqs,sample,library_type) defining the ATAC and gene
      expression FASTQ data generated with the Chromium Single Cell Multiome ATAC + Gene
      Expression solution. library_type is 'Gene Expression' or 'Chromatin Accessibility'.
      Set fastqs to '.': a relative path is resolved against the container's working
      directory, where fastq_files are staged, and a host folder is not visible there.
      sample must equal the file-name prefix of that library's FASTQs, e.g.
        fastqs,sample,library_type
        .,rep1_gex,Gene Expression
        .,rep1_atac,Chromatin Accessibility
    inputBinding:
      position: 101
      prefix: --libraries
      valueFrom: $(runtime.outdir)/libraries_staged.csv
  - id: fastq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: |-
      Every FASTQ of every library in the libraries CSV. Needed for a real run: without
      them the container has no FASTQs and count fails with "FASTQ path doesn't exist".
      Each file must be named <sample>_S1_L001_<read>_001.fastq.gz (<sample> as in the CSV).
      Gene Expression: R1 = cell barcode + UMI (28 bp), R2 = cDNA read.
      Chromatin Accessibility: R1 and R3 = genomic reads, R2 = cell barcode read.
      SRA downloads are named SRR..._1/_2/_3.fastq.gz: check each file's read length
      (zcat f | head -2) to tell which read it is, then symlink it under the 10x name and
      pass the links, e.g. rep1_gex_S1_L001_R1_001.fastq.gz -> SRR1234567_1.fastq.gz.
  - id: min_atac_count
    type:
      - 'null'
      - int
    doc: 'Cell caller override: define the minimum number of ATAC transposition events
      in peaks (ATAC counts) for a cell barcode. Note: this option must be specified
      in conjunction with `min-gex-count`.'
    inputBinding:
      position: 101
      prefix: --min-atac-count
  - id: min_gex_count
    type:
      - 'null'
      - int
    doc: 'Cell caller override: define the minimum number of GEX UMI counts for a
      cell barcode. Note: this option must be specified in conjunction with `min-atac-count`.'
    inputBinding:
      position: 101
      prefix: --min-gex-count
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
  - id: gex_exclude_introns
    type:
      - 'null'
      - boolean
    doc: 'Disable counting of intronic reads. In this mode, only reads that are exonic
      and compatible with annotated splice junctions in the reference are counted.
      Note: using this mode will reduce the UMI counts in the feature-barcode matrix'
    inputBinding:
      position: 101
      prefix: --gex-exclude-introns
  - id: tenx_cloud_token_path
    type:
      - 'null'
      - File
    doc: The path to the 10x Cloud Analysis user token used to enable cell 
      annotation. If not provided, will default to the location stored through 
      cellranger-arc cloud auth setup
    inputBinding:
      position: 101
      prefix: --tenx-cloud-token-path
  - id: cell_annotation_model
    type:
      - 'null'
      - string
    doc: Cell annotation model to use. Valid model names can be viewed by 
      running `cellranger-arc cloud annotation models` or on the 10x Genomics 
      Support site. If this option is omitted or set to "auto", uses the default
      model for the species. If a cloud token is not available or the 
      --disable-cell-annotation flag is used, cloud cell annotation will not be 
      performed. For local models, no cell-annotation-model is necessary
    inputBinding:
      position: 101
      prefix: --cell-annotation-model
  - id: disable_cell_annotation
    type:
      - 'null'
      - boolean
    doc: Disable cell type annotation
    inputBinding:
      position: 101
      prefix: --disable-cell-annotation
  - id: create_bam
    type: boolean
    doc: Enable or disable BAM file generation. Setting --create-bam=false 
      reduces the total computation time and the size of the output directory 
      (BAM file not generated). We recommend setting --create-bam=true if 
      unsure. See https://10xgen.com/create-bam for additional guidance
    inputBinding:
      position: 101
      prefix: --create-bam
      valueFrom: '$(self ? "true" : "false")'
  - id: nosecondary
    type:
      - 'null'
      - boolean
    doc: Disable secondary analysis, e.g. clustering
    inputBinding:
      position: 101
      prefix: --nosecondary
  - id: rna_r1_length
    type:
      - 'null'
      - int
    doc: Trim the input Read 1 for GEX data to this length before analysis
    inputBinding:
      position: 101
      prefix: --rna-r1-length
  - id: rna_r2_length
    type:
      - 'null'
      - int
    doc: Trim the input Read 2 for GEX data to this length before analysis
    inputBinding:
      position: 101
      prefix: --rna-r2-length
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
      - entryname: libraries_staged.csv
        entry: |-
          ${
            return inputs.libraries.contents.split('\n').map(function(line) {
              var c = line.split(',');
              if (c.length >= 3 && c[0] != '' && c[0] != 'fastqs' && c[0].charAt(0) != '/') {
                c[0] = c[0] == '.' ? runtime.outdir : runtime.outdir + '/' + c[0];
              }
              return c.join(',');
            }).join('\n');
          }
      - '$(inputs.fastq_files ? inputs.fastq_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger-arc:2.2.0
s:url: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
$namespaces:
  s: https://schema.org/
