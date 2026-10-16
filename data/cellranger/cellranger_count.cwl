cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - count
label: cellranger_count
doc: |-
  Count gene expression and/or feature barcode reads from a single sample and GEM well.
  The container sees only the files passed to it. Cell Ranger finds FASTQs by name: <sample>_S1_L001_<read>_001.fastq.gz, where <sample>
  is the --sample value (or the libraries CSV sample column).
  Pass the FASTQs as a folder (fastqs) or as files (fastq_files); with fastq_files and no
  fastqs, --fastqs is the working directory. In a libraries CSV, a relative fastqs path
  ('.') is resolved against the working directory, where fastq_files are staged.
arguments:
  - position: 100
    valueFrom: '${ if (inputs.fastq_files && inputs.fastq_files.length && !inputs.fastqs && !inputs.libraries)
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
  - id: transcriptome
    type:
      - 'null'
      - Directory
    doc: Path of folder containing 10x-compatible transcriptome reference
    inputBinding:
      position: 101
      prefix: --transcriptome
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
      folder from which to pick FASTQs
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
  - id: lanes
    type:
      - 'null'
      - string
    doc: Only use FASTQs from selected lanes
    inputBinding:
      position: 101
      prefix: --lanes
  - id: libraries
    type:
      - 'null'
      - File
    loadContents: true
    doc: |-
      CSV file declaring input library data sources (fastqs,sample,library_type). A host
      folder in its fastqs column is not visible inside the container: set it to '.' and
      pass the FASTQs in fastq_files, which are staged in the working directory.
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
      FASTQ files to stage in the working directory. Use this instead of fastqs when
      the files are not already in one folder under 10x names: link each file under
      its 10x name and pass the links; they are staged under the link names.
      With a libraries CSV, set its fastqs column to '.'.
      Each must be named <sample>_S1_L001_<read>_001.fastq.gz (<sample> as in sample).
      Gene Expression: R1 = cell barcode + UMI (28 bp), R2 = cDNA read; V(D)J: R1 =
      barcode + UMI, R2 = the receptor read. SRA downloads are named SRR..._1/_2.fastq.gz:
      check each file's read length (zcat f | head -2) to tell R1 from R2.
  - id: feature_ref
    type:
      - 'null'
      - File
    doc: Feature reference CSV file, declaring Feature Barcode constructs and 
      associated barcodes
    inputBinding:
      position: 101
      prefix: --feature-ref
  - id: expect_cells
    type:
      - 'null'
      - int
    doc: Expected number of recovered cells, used as input to cell calling 
      algorithm
    inputBinding:
      position: 101
      prefix: --expect-cells
  - id: force_cells
    type:
      - 'null'
      - int
    doc: 'Force pipeline to use this number of cells, bypassing cell calling algorithm.
      [MINIMUM: 10]'
    inputBinding:
      position: 101
      prefix: --force-cells
  - id: create_bam
    type: boolean
    doc: Enable or disable BAM file generation. Setting --create-bam=false 
      reduces the total computation time and the size of the output directory 
      (BAM file not generated). We recommend setting --create-bam=true if 
      unsure. See https://10xgen.com/create-bam for additional guidance
    inputBinding:
      position: 101
      prefix: --create-bam=
      separate: false
      valueFrom: '$(self ? "true" : "false")'
  - id: nosecondary
    type:
      - 'null'
      - boolean
    doc: Disable secondary analysis, e.g. clustering. Optional
    inputBinding:
      position: 101
      prefix: --nosecondary
  - id: r1_length
    type:
      - 'null'
      - int
    doc: Hard trim the input Read 1 to this length before analysis
    inputBinding:
      position: 101
      prefix: --r1-length
  - id: r2_length
    type:
      - 'null'
      - int
    doc: Hard trim the input Read 2 to this length before analysis
    inputBinding:
      position: 101
      prefix: --r2-length
  - id: include_introns
    type:
      - 'null'
      - boolean
    doc: Include intronic reads in count
    inputBinding:
      position: 101
      prefix: --include-introns=
      separate: false
      valueFrom: '$(self ? "true" : "false")'
  - id: chemistry
    type:
      - 'null'
      - string
    doc: "Assay configuration. NOTE: by default the assay configuration is detected
      automatically, which is the recommended mode. You usually will not need to specify
      a chemistry. Options are: 'auto' for autodetection, 'threeprime' for Single
      Cell 3', 'fiveprime' for Single Cell 5', 'SC3Pv1' or 'SC3Pv2' or 'SC3Pv3' or
      'SC3Pv4' for Single Cell 3' v1/v2/v3/v4, 'SC3Pv3HT' for Single Cell 3' v3 HT,
      'SC5P-PE' or 'SC5P-PE-v3' or 'SC5P-R2' or 'SC5P-R2-v3' for Single Cell 5', paired-end/R2-only,
      'SC-FB' for Single Cell Antibody-only 3' v2 or 5'. To analyze the GEX portion
      of multiome data, chemistry must be set to 'ARC-v1'"
    inputBinding:
      position: 101
      prefix: --chemistry
  - id: no_libraries
    type:
      - 'null'
      - boolean
    doc: Proceed with processing using a --feature-ref but no Feature Barcode 
      libraries specified with the 'libraries' flag
    inputBinding:
      position: 101
      prefix: --no-libraries
  - id: check_library_compatibility
    type:
      - 'null'
      - boolean
    doc: Whether to check for barcode compatibility between libraries.
    inputBinding:
      position: 101
      prefix: --check-library-compatibility=
      separate: false
      valueFrom: '$(self ? "true" : "false")'
  - id: tenx_cloud_token_path
    type:
      - 'null'
      - File
    doc: The path to the 10x Cloud Analysis user token used to enable cell 
      annotation. If not provided, will default to the location stored through 
      cellranger cloud auth setup
    inputBinding:
      position: 101
      prefix: --tenx-cloud-token-path
  - id: cell_annotation_model
    type:
      - 'null'
      - string
    doc: Cell annotation model to use. Valid model names can be viewed by 
      running `cellranger cloud annotation models` or on the 10x Genomics 
      Support site (https://www.10xgenomics.com/support). If "auto", uses the 
      default model for the species. If not provided, does not run cell 
      annotation
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
  - id: min_crispr_umi
    type:
      - 'null'
      - int
    doc: Minimum CRISPR UMI threshold
    inputBinding:
      position: 101
      prefix: --min-crispr-umi
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
      - |-
        ${
          if (!inputs.libraries) return [];
          var col = null;
          var lines = inputs.libraries.contents.split('\n').map(function(line) {
            var c = line.split(',');
            if (col === null) {
              if (line.trim() == '') return line;
              col = c.map(function(x) { return x.trim(); }).indexOf('fastqs');
              return line;
            }
            var v = col >= 0 && c.length > col ? c[col].trim() : '';
            if (v != '' && v.charAt(0) != '/') {
              c[col] = v == '.' ? runtime.outdir : runtime.outdir + '/' + v;
            }
            return c.join(',');
          });
          return [{"class": "File", "basename": "libraries_staged.csv",
                   "contents": lines.join('\n')}];
        }
      - '$(inputs.fastq_files ? inputs.fastq_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
