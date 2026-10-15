cwlVersion: v1.2
class: CommandLineTool
baseCommand: PrimedLAMP_Cross_Reactivity_Update
label: primedlamp_PrimedLAMP_Cross_Reactivity_Update
doc: "Update cross-reactivity scores of a prior PrimedLAMP run, excluding listed sequence IDs.\n\nTool homepage: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA"
inputs:
  - id: run_id
    type: string
    doc: "Desired Run ID"
    inputBinding:
      position: 1
      prefix: --RunID
  - id: prior_oligo_sites
    type: File
    doc: "Path to Prior Generated Oligo Sites"
    inputBinding:
      position: 1
      prefix: --PriorOligoSites
  - id: prior_blastn_output
    type: Directory
    doc: "Path to Blastn_Output directory"
    inputBinding:
      position: 1
      prefix: --PriorBlastnOutput
  - id: exclusion_id_file_path
    type: File
    doc: "Path to .txt file contain sequence IDs to excluded"
    inputBinding:
      position: 1
      prefix: --ExlusionIDFilePath
  - id: threads
    type:
      - 'null'
      - int
    doc: "Default Set To 1"
    inputBinding:
      position: 1
      prefix: --Threads
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
stdout: primedlamp_PrimedLAMP_Cross_Reactivity_Update.out
