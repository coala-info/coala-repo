cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcbio-rnaseq
  - compare
label: bcbio-rnaseq_compare
doc: "Compare RNA-seq experiments\n\nTool homepage: https://github.com/hbc/bcbioRNASeq"
inputs:
  - id: project_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files the project file refers to by relative path (combined.counts,
      the bcbio_system.yaml named in the project file); staged beside it
  - id: project_file
    type: File
    doc: A bcbio-nextgen project file
    inputBinding:
      position: 1
      valueFrom: $(runtime.outdir)/$(self.basename)
  - id: key
    type: string
    doc: Key in the metadata field to do pairwise comparisons
    inputBinding:
      position: 2
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores
    inputBinding:
      position: 103
      prefix: --cores
  - id: counts_only
    type:
      - 'null'
      - boolean
    doc: Only run count-based analyses
    inputBinding:
      position: 103
      prefix: --counts-only
  - id: seqc
    type:
      - 'null'
      - boolean
    doc: Data is from a SEQC alignment
    inputBinding:
      position: 103
      prefix: --seqc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: de_dir
    type: Directory
    doc: Folder 'de' with the differential expression results, R scripts and
      comparison plots, written beside the project file
    outputBinding:
      glob: de
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.project_file)
        writable: true
      - $(inputs.project_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.2_3
stdout: bcbio-rnaseq_compare.out
