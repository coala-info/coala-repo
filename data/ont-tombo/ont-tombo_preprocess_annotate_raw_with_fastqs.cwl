cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - preprocess
  - annotate_raw_with_fastqs
label: ont-tombo_preprocess_annotate_raw_with_fastqs
doc: "Add basecalled sequence from FASTQs to raw FAST5s.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5_basedir
    type: Directory
    doc: "Directory containing fast5 files."
    inputBinding:
      position: 101
      prefix: "--fast5-basedir"
      valueFrom: "$(self.basename)"
  - id: fastq_filenames
    type: File[]
    doc: "FASTQ filenames containing basecalls to be added to raw FAST5 files."
    inputBinding:
      position: 101
      prefix: "--fastq-filenames"
  - id: basecall_group
    type:
      - 'null'
      - string
    doc: "FAST5 group obtain original basecalls (under Analyses group). Default: Basecall_1D_000"
    inputBinding:
      position: 101
      prefix: "--basecall-group"
  - id: basecall_subgroup
    type:
      - 'null'
      - string
    doc: "FAST5 subgroup (under /Analyses/[--basecall-group]/) under which to store basecalls from FASTQs. Default: BaseCalled_template"
    inputBinding:
      position: 101
      prefix: "--basecall-subgroup"
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite previous corrected group in FAST5 files. Note: only effects --corrected-group or --new- corrected-group."
    inputBinding:
      position: 101
      prefix: "--overwrite"
  - id: sequencing_summary_filenames
    type:
      - 'null'
      - File[]
    doc: "Sequencing summary filenames produced by albacore. These can make annotation of raw FAST5 files with FASTQ sequence much faster."
    inputBinding:
      position: 101
      prefix: "--sequencing-summary-filenames"
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes. Default: 1"
    inputBinding:
      position: 101
      prefix: "--processes"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Don't print status information."
    inputBinding:
      position: 101
      prefix: "--quiet"
outputs:
  - id: annotated_fast5_dir
    type:
      type: array
      items: Directory
    doc: "FAST5 directory annotated with basecalls"
    outputBinding:
      glob: "$(inputs.fast5_basedir.basename)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
