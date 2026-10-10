cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -Xmx2048m
  - -jar
  - /usr/local/bin/MetFragCLI.jar
label: metfrag-cli-batch_MetFragCLI
doc: "MetFrag command line tool: in silico fragmentation of candidate structures to annotate MS/MS spectra, driven by a parameter file.\n\nTool homepage: http://c-ruttkies.github.io/MetFrag/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.support_files || [])
inputs:
  - id: parameter_file
    type: File
    doc: "MetFrag parameter file (key=value lines such as PeakListString, MetFragDatabaseType, LocalDatabasePath, ResultsFile). Relative file names in it resolve against the working directory."
    inputBinding:
      position: 1
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the parameter file (local candidate database, peak list), staged in the working directory so relative names resolve."
  - id: results_file
    type: string
    doc: "Name of the results file; must equal ResultsFile in the parameter file."
outputs:
  - id: results
    type: File
    doc: "Candidate result table written by MetFrag (ResultsFile)."
    outputBinding:
      glob: $(inputs.results_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metfrag-cli-batch:v2.4.3_cv0.6
stdout: metfrag-cli-batch_MetFragCLI.out
