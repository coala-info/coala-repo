cwlVersion: v1.2
class: CommandLineTool
baseCommand: geofetch
label: geofetch
doc: "Automatic GEO and SRA data downloader\n\nTool homepage: https://github.com/pepkit/geofetch/"
inputs:
  - id: acc_anno
    type:
      - 'null'
      - boolean
    doc: "Optional: Produce annotation sheets for each accession. Project combined
      PEP for the whole project won't be produced."
    inputBinding:
      position: 101
      prefix: --acc-anno
  - id: add_convert_modifier
    type:
      - 'null'
      - boolean
    doc: Add looper SRA convert modifier to config file.
    inputBinding:
      position: 101
      prefix: --add-convert-modifier
  - id: add_dotfile
    type:
      - 'null'
      - boolean
    doc: 'Optional: Add .pep.yaml file that points .yaml PEP file'
    inputBinding:
      position: 101
      prefix: --add-dotfile
  - id: attr_limit_truncate
    type:
      - 'null'
      - int
    doc: 'Optional: Limit of the number of sample characters.Any attribute with more
      than X characters will truncate to the first X, where X is a number of characters'
    inputBinding:
      position: 101
      prefix: --attr-limit-truncate
  - id: bam_folder
    type:
      - 'null'
      - Directory
    doc: 'Optional: Specify folder of bam files. Geofetch will not download sra files
      when corresponding bam files already exist.'
    inputBinding:
      position: 101
      prefix: --bam-folder
  - id: config_template
    type:
      - 'null'
      - File
    doc: Project config yaml file template.
    inputBinding:
      position: 101
      prefix: --config-template
  - id: const_limit_discard
    type:
      - 'null'
      - int
    doc: 'Optional: Limit of the number of the constant sample characters that should
      not be discarded'
    inputBinding:
      position: 101
      prefix: --const-limit-discard
  - id: const_limit_project
    type:
      - 'null'
      - int
    doc: 'Optional: Limit of the number of the constant sample characters that should
      not be in project yaml.'
    inputBinding:
      position: 101
      prefix: --const-limit-project
  - id: data_source
    type:
      - 'null'
      - string
    doc: "Optional: Specifies the source of data on the GEO record to retrieve processed
      data, which may be attached to the collective series entity, or to individual
      samples. Allowable values are: samples, series or both (all). Ignored unless
      'processed' flag is set."
    inputBinding:
      position: 101
      prefix: --data-source
  - id: disable_progressbar
    type:
      - 'null'
      - boolean
    doc: 'Optional: Disable progressbar'
    inputBinding:
      position: 101
      prefix: --disable-progressbar
  - id: discard_soft
    type:
      - 'null'
      - boolean
    doc: 'Optional: After creation of PEP files, all .soft files will be deleted'
    inputBinding:
      position: 101
      prefix: --discard-soft
  - id: filter
    type:
      - 'null'
      - string
    doc: "Optional: Filter regex for processed filenames. Ignored unless 'processed'
      flag is set."
    inputBinding:
      position: 101
      prefix: --filter
  - id: filter_size
    type:
      - 'null'
      - string
    doc: "Optional: Filter size for processed files that are stored as sample repository.
      Works only for sample data. Supported input formats : 12B, 12KB, 12MB, 12GB.
      Ignored unless 'processed' flag is set."
    inputBinding:
      position: 101
      prefix: --filter-size
  - id: fq_folder
    type:
      - 'null'
      - Directory
    doc: 'Optional: Specify folder of fastq files. Geofetch will not download sra
      files when corresponding fastq files already exist.'
    inputBinding:
      position: 101
      prefix: --fq-folder
  - id: geo_folder
    type:
      - 'null'
      - Directory
    doc: "Optional: Specify a location to store processed GEO files. Ignored unless
      'processed' flag is set."
    inputBinding:
      position: 101
      prefix: --geo-folder
  - id: input
    type: string
    doc: a GEO (GSE) accession, or a file with a list of GSE numbers
    inputBinding:
      position: 101
      prefix: --input
  - id: just_metadata
    type:
      - 'null'
      - boolean
    doc: If set, don't actually run downloads, just create metadata
    inputBinding:
      position: 101
      prefix: --just-metadata
  - id: logdev
    type:
      - 'null'
      - boolean
    doc: Expand content of logging message format.
    inputBinding:
      position: 101
      prefix: --logdev
  - id: max_prefetch_size
    type:
      - 'null'
      - string
    doc: "Argument to pass to prefetch program's --max-size option, if prefetch will
      be used in this run of geofetch; for reference: https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump#check-the-maximum-size-limit-of-the-prefetch-tool"
    inputBinding:
      position: 101
      prefix: --max-prefetch-size
  - id: max_soft_size
    type:
      - 'null'
      - string
    doc: 'Optional: Max size of soft file. Supported input formats : 12B, 12KB, 12MB,
      12GB.'
    inputBinding:
      position: 101
      prefix: --max-soft-size
  - id: metadata_folder
    type:
      - 'null'
      - Directory
    doc: Specify an absolute folder location to store metadata. No subfolder 
      will be added. Overrides value of --metadata-root.
    inputBinding:
      position: 101
      prefix: --metadata-folder
  - id: metadata_root
    type:
      - 'null'
      - Directory
    doc: Specify a parent folder location to store metadata. The project name 
      will be added as a subfolder
    inputBinding:
      position: 101
      prefix: --metadata-root
  - id: name
    type:
      - 'null'
      - string
    doc: Specify a project name. Defaults to GSE number
    inputBinding:
      position: 101
      prefix: --name
  - id: pipeline_project
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Optional: Specify one or more filepaths to PROJECT pipeline interface yaml
      files. These will be added to the project config file to make it immediately
      compatible with looper.'
    inputBinding:
      position: 101
      prefix: --pipeline-project
  - id: pipeline_samples
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Optional: Specify one or more filepaths to SAMPLES pipeline interface yaml
      files. These will be added to the project config file to make it immediately
      compatible with looper.'
    inputBinding:
      position: 101
      prefix: --pipeline-samples
  - id: processed
    type:
      - 'null'
      - boolean
    doc: 'Download processed data [Default: download raw data].'
    inputBinding:
      position: 101
      prefix: --processed
  - id: refresh_metadata
    type:
      - 'null'
      - boolean
    doc: If set, re-download metadata even if it exists.
    inputBinding:
      position: 101
      prefix: --refresh-metadata
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Silence logging. Overrides verbosity.
    inputBinding:
      position: 101
      prefix: --silent
  - id: skip
    type:
      - 'null'
      - string
    doc: Skip some accessions.
    inputBinding:
      position: 101
      prefix: --skip
  - id: split_experiments
    type:
      - 'null'
      - boolean
    doc: Split SRR runs into individual samples. By default, SRX experiments 
      with multiple SRR Runs will have a single entry in the annotation table, 
      with each run as a separate row in the subannotation table. This setting 
      instead treats each run as a separate sample
    inputBinding:
      position: 101
      prefix: --split-experiments
  - id: use_key_subset
    type:
      - 'null'
      - boolean
    doc: Use just the keys defined in this module when writing out metadata.
    inputBinding:
      position: 101
      prefix: --use-key-subset
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Set logging level (1-5 or logging module level name)
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geofetch:0.12.10--pyhdfd78af_0
stdout: geofetch.out
