cwlVersion: v1.2
class: CommandLineTool
baseCommand: athena-meta
label: athena_meta_athena-meta
doc: "Athena Meta: A pipeline for assembling metagenomes\n\nTool homepage: https://github.com/abishara/athena_meta/"
inputs:
  - id: check_prereqs
    type:
      - 'null'
      - boolean
    doc: test if external deps visible in environment
    inputBinding:
      position: 101
      prefix: --check_prereqs
  - id: config
    type:
      - 'null'
      - File
    doc: 'input JSON config file for run, NOTE: dirname(config.json) specifies root
      output directory'
    inputBinding:
      position: 101
      prefix: --config
  - id: force_reads
    type:
      - 'null'
      - boolean
    doc: proceed with subassembly even if input *bam and *fastq do not pass QC
    inputBinding:
      position: 101
      prefix: --force_reads
  - id: test
    type:
      - 'null'
      - boolean
    doc: run tiny assembly test to check setup and prereqs
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: number of multiprocessing threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/athena_meta:1.3--py27_0
stdout: athena_meta_athena-meta.out
