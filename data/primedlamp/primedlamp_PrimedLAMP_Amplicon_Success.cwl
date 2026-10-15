cwlVersion: v1.2
class: CommandLineTool
baseCommand: PrimedLAMP_Amplicon_Success
label: primedlamp_PrimedLAMP_Amplicon_Success
doc: "Assess the amplicon success (mismatches against target sequences) of LAMP oligo sets from a prior PrimedLAMP run.\n\nTool homepage: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA"
inputs:
  - id: run_id
    type: string
    doc: "Desired Run ID"
    inputBinding:
      position: 1
      prefix: --RunID
  - id: input_file
    type: File
    doc: "Path <RunID>_Oligo_Analysis.csv"
    inputBinding:
      position: 1
      prefix: --InputFile
  - id: input_fasta
    type: File
    doc: "Path to target sequence in fasta format. This needs to be the same file used in the prior PrimedLAMP or PrimedLAMP_Custom Run"
    inputBinding:
      position: 1
      prefix: --InputFasta
  - id: threads
    type:
      - 'null'
      - int
    doc: "Default Set To 1"
    inputBinding:
      position: 1
      prefix: --Threads
  - id: non_critical_threshold
    type:
      - 'null'
      - int
    doc: "Number of mismatches tolerated in non-critical region"
    inputBinding:
      position: 1
      prefix: --NonCriticalThreshold
  - id: critical_region_len
    type:
      - 'null'
      - int
    doc: "Number of nucleotides in from either the 5' or 3' terminus"
    inputBinding:
      position: 1
      prefix: --CriticalRegionLen
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result tables written with the run ID as prefix
    outputBinding:
      glob: $(inputs.run_id)_*.csv
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primedlamp:1.0.1--py_0
stdout: primedlamp_PrimedLAMP_Amplicon_Success.out
