cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, abundance]
label: treesapp_abundance
doc: "Calculate query sequence abundances from read coverage.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: treesapp_output
    type: Directory
    doc: "Path to the directory containing TreeSAPP outputs (staged writable; abundance values are added there)."
    inputBinding:
      position: 101
      prefix: --treesapp_output
      valueFrom: $(inputs.treesapp_output.basename)
  - id: metric
    type:
      - 'null'
      - string
    doc: "Normalization metric to use: fpkm or tpm. [ DEFAULT = tpm ]"
    inputBinding:
      position: 101
      prefix: --metric
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTQ file(s) to be aligned to predicted genes using BWA MEM"
    inputBinding:
      position: 101
      prefix: --reads
  - id: reverse
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTQ file(s) with reverse mate-pair reads to be aligned using BWA MEM"
    inputBinding:
      position: 101
      prefix: --reverse
  - id: pairing
    type:
      - 'null'
      - string
    doc: "Whether the reads are paired-end (pe) or single-end (se). [ DEFAULT = pe ]"
    inputBinding:
      position: 101
      prefix: --pairing
  - id: refpkg_dir
    type:
      - 'null'
      - Directory
    doc: "Path to the directory containing reference package pickle (.pkl) files. [ DEFAULT = treesapp/data/ ]"
    inputBinding:
      position: 101
      prefix: --refpkg_dir
  - id: report
    type:
      - 'null'
      - string
    doc: "What to do with the abundance values: update, append or nothing. [ DEFAULT = append ]"
    inputBinding:
      position: 101
      prefix: --report
  - id: stage
    type:
      - 'null'
      - string
    doc: "The stage(s) to execute: continue, align_map, sam_sum or summarise. [DEFAULT = continue]"
    inputBinding:
      position: 101
      prefix: --stage
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrites previously written output files and directories"
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints a more verbose runtime log"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: num_procs
    type:
      - 'null'
      - int
    doc: "The number of CPU threads or parallel processes to use in various pipeline steps [ DEFAULT = 2 ]"
    inputBinding:
      position: 101
      prefix: --num_procs
  - id: delete
    type:
      - 'null'
      - boolean
    doc: "Delete all intermediate files to save disk space."
    inputBinding:
      position: 101
      prefix: --delete
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "TreeSAPP output directory with abundance values"
    outputBinding:
      glob: $(inputs.treesapp_output.basename)
stdout: treesapp_abundance.out
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.treesapp_output)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
