cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nomadic
  - process
label: nomadic_process
doc: "(Re)Process data that was produced by MinKNOW\n\nTool homepage: https://jasonahendry.github.io/nomadic/"
inputs:
  - id: experiment_name
    type: string
    doc: Name of the experiment
    inputBinding:
      position: 1
  - id: caller
    type:
      - 'null'
      - string
    doc: Call biallelic SNPs in real-time with the indicated variant caller. If 
      this flag is omitted, no variant calling is performed.
    inputBinding:
      position: 102
      prefix: --caller
  - id: fastq_dir
    type:
      - 'null'
      - Directory
    doc: Path or glob to the fastq files. This should only be used when the full
      minknow dir can not be provided, as some features likes backup will not 
      work. Prefer using --minknow_dir. If --fastq_dir is provided, 
      --minknow_dir is ignored.
    inputBinding:
      position: 102
      prefix: --fastq_dir
  - id: metadata_csv
    type:
      - 'null'
      - File
    doc: Path to metadata CSV file containing barcode and sample information.
    inputBinding:
      position: 102
      prefix: --metadata_csv
  - id: minknow_dir
    type:
      - 'null'
      - Directory
    doc: Path to the minknow output directory. Can be either the base directory,
      e.g. /var/lib/minknow/data, or the directory of the experiment, e.g. 
      /var/lib/minknow/data/<experiment_name>.
    inputBinding:
      position: 102
      prefix: --minknow_dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output directory if it exists.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: reference_name
    type: string
    doc: Choose a reference genome to be used in real-time analysis.
    inputBinding:
      position: 102
      prefix: --reference_name
  - id: region_bed
    type: File
    doc: Path to BED file specifying genomic regions of interest or name of 
      panel, e.g. 'nomads8' or 'nomadsMVP'.
    inputBinding:
      position: 102
      prefix: --region_bed
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume processing a previous experiment if the output directory already
      exists. This is necessary to pick of processing of an experiment that was 
      aborted.
    inputBinding:
      position: 102
      prefix: --resume
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity. Helpful for debugging.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: Path of the workspace where all input/output files (beds, metadata, 
      results) are stored. The workspace directory simplifies the use of nomadic
      in that many arguments don't need to be listed as they are predefined in 
      the workspace config or can be loaded from the workspace
    inputBinding:
      position: 102
      prefix: --workspace
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory where results of this experiment will be 
      stored. Usually the default of storing it in the workspace should be 
      enough.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
