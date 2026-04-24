cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner run_stringtie
label: isorefiner_run_stringtie
doc: "Run StringTie to assemble transcripts\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Mapped reads files (BAM, mandatory)
    inputBinding:
      position: 1
  - id: ref_gtf
    type: File
    doc: Reference genome annotation (GTF, mandatory)
    inputBinding:
      position: 2
  - id: genome
    type:
      - 'null'
      - File
    doc: Reference genome (FASTA)
    inputBinding:
      position: 103
      prefix: --genome
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: tool_option
    type:
      - 'null'
      - string
    doc: Option for StringTie (quoted string)
    inputBinding:
      position: 103
      prefix: --tool_option
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Working directory containing intermediate and log files
    inputBinding:
      position: 103
      prefix: --work_dir
outputs:
  - id: out_gtf
    type:
      - 'null'
      - File
    doc: Final output file name (GTF)
    outputBinding:
      glob: $(inputs.out_gtf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
