cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_bwa_align
label: phyluce_phyluce_snp_bwa_align
doc: "Call SNPs\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: config
    type: File
    doc: "A configuration file containing"
    inputBinding:
      position: 1
      prefix: --config
  - id: staged_dirs
    type:
      - type: array
        items: Directory
    doc: "Directories that the configuration file refers to (the reference folder and the read folders of each sample). They are copied into the working directory under their own names, so the paths in the configuration file must be relative to the working directory, for example ref/reference.fasta and sample-folder. The reference folder must contain the FASTA file and its BWA index files (.amb, .ann, .bwt, .pac, .sa), because the program cannot create the index when the reference path is relative."
  - id: output
    type: string
    doc: "The directory in which to store the SNPs files"
    inputBinding:
      position: 2
      prefix: --output
  - id: subfolder
    type:
      - 'null'
      - string
    doc: "A subdirectory, below the level of the group, containing the reads"
    inputBinding:
      position: 3
      prefix: --subfolder
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of compute cores/threads to use"
    inputBinding:
      position: 4
      prefix: --cores
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use. One of INFO, WARN, CRITICAL."
    inputBinding:
      position: 5
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory is created in the working directory before the run."
    inputBinding:
      position: 6
      prefix: --log-path
  - id: no_remove_duplicates
    type:
      - 'null'
      - boolean
    doc: "Do not remove duplicate reads."
    inputBinding:
      position: 7
      prefix: --no-remove-duplicates
  - id: mem
    type:
      - 'null'
      - boolean
    doc: "Use bwa mem."
    inputBinding:
      position: 8
      prefix: --mem
outputs:
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: "The directory that holds the logs."
    outputBinding:
      glob: "$(inputs.log_path)"
  - id: output_dir
    type: Directory
    doc: "The output directory with one folder per sample holding the BAM file (<sample>-CL-RG-MD.bam), logs and Picard metrics."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.log_path ? {"class": "Directory", "basename": inputs.log_path, "listing": []} : null)'
        writable: true
      - '$(inputs.staged_dirs.map(function(d) { return {"entry": d, "entryname": d.basename, "writable": true}; }))'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
