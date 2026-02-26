cwlVersion: v1.2
class: CommandLineTool
baseCommand: ivar filtervariants
label: ivar_filtervariants
doc: "Filters variant TSV files across multiple replicates.\n\nTool homepage: https://andersen-lab.github.io/ivar/html/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Variant tsv files for each replicate/sample
    inputBinding:
      position: 1
  - id: min_fraction_files
    type:
      - 'null'
      - float
    doc: Minimum fraction of files required to contain the same variant. Specify
      value within [0,1].
    default: 1.0
    inputBinding:
      position: 102
      prefix: -t
  - id: prefix
    type: string
    doc: Prefix for the output filtered tsv file
    inputBinding:
      position: 102
      prefix: -p
  - id: variant_file_list
    type:
      - 'null'
      - File
    doc: A text file with one variant file per line.
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
stdout: ivar_filtervariants.out
