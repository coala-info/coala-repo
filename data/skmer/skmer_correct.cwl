cwlVersion: v1.2
class: CommandLineTool
baseCommand: skmer_correct
label: skmer_correct
doc: "Performs correction of subsampled distance matrices obtained for reference genome-skims
  or assemblies\n\nTool homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs:
  - id: main
    type: File
    doc: Distance matrix of main estimate
    inputBinding:
      position: 101
      prefix: -main
  - id: p
    type:
      - 'null'
      - int
    doc: 'Max number of processors to use [1-20]. Default for this machine: 20'
    default: 20
    inputBinding:
      position: 101
      prefix: -p
  - id: sub
    type:
      - 'null'
      - Directory
    doc: Directory of output for subsample replicates.
    default: working_directory/subsample
    inputBinding:
      position: 101
      prefix: -sub
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
stdout: skmer_correct.out
