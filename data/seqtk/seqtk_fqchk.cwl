cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - fqchk
label: seqtk_fqchk
doc: "Fastq quality check and distribution analysis\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_fastq
    type: File
    doc: Input fastq file
    inputBinding:
      position: 1
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Quality threshold; use -q0 to get the distribution of all quality values
    inputBinding:
      position: 102
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_fqchk.out
