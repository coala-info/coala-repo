cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - diff
label: mykatlas_diff
doc: "Outputs novel sequence by calculating the difference between the sequence and combined graph\n\nTool homepage: http://github.com/phelimb/atlas"
inputs:
  - id: sample
    type: string
    doc: "sample id"
    inputBinding:
      position: 1
  - id: graph
    type: File
    doc: "The graph to compare new sample against"
    inputBinding:
      position: 2
  - id: kmer
    type:
      - 'null'
      - int
    doc: "kmer length (default:21)"
    inputBinding:
      position: 10
      prefix: "-k"
  - id: tmp
    type:
      - 'null'
      - string
    doc: "tmp directory (default: /tmp/)"
    inputBinding:
      position: 10
      prefix: "--tmp"
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: "Dont remove tmp files"
    inputBinding:
      position: 10
      prefix: "--keep_tmp"
  - id: skeleton_dir
    type: string
    default: skeletons
    doc: "directory for skeleton binaries; it must be writable, so the CWL creates a folder with this name in the working directory"
    inputBinding:
      position: 10
      prefix: --skeleton_dir
  - id: mccortex31_path
    type:
      - 'null'
      - string
    doc: "Path to mccortex31. Default mccortex31"
    inputBinding:
      position: 10
      prefix: "--mccortex31_path"
  - id: threads
    type:
      - 'null'
      - int
    doc: "threads"
    inputBinding:
      position: 10
      prefix: "--threads"
  - id: memory
    type:
      - 'null'
      - string
    doc: "memory for graph constuction"
    inputBinding:
      position: 10
      prefix: "--memory"
  - id: expected_depth
    type:
      - 'null'
      - int
    doc: "expected depth"
    inputBinding:
      position: 10
      prefix: "--expected_depth"
  - id: seq
    type:
      - 'null'
      - type: array
        items: File
    doc: "sequence files (fasta,fastq,bam)"
    inputBinding:
      position: 10
      prefix: "-1"
  - id: ctx
    type:
      - 'null'
      - File
    doc: "cortex graph binary"
    inputBinding:
      position: 10
      prefix: "--ctx"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "do not output warnings to stderr"
    inputBinding:
      position: 10
      prefix: "--quiet"
  - id: add
    type:
      - 'null'
      - boolean
    doc: "after comparing, add the new sample to the graph"
    inputBinding:
      position: 10
      prefix: "--add"
outputs:
  - id: stdout
    type: stdout
    doc: "Novel sequence"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.skeleton_dir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykatlas:0.6.1--py39h6a678da_6
stdout: mykatlas_diff.out
