cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAcode
label: rnacode_RNAcode
doc: "RNAcode 0.3.1\n\nTool homepage: https://github.com/ViennaRNA/RNAcode"
inputs:
  - id: input_file
    type:
      - 'null'
      - string
    doc: Input file
    inputBinding:
      position: 1
  - id: best_only
    type:
      - 'null'
      - boolean
    doc: Show only best hit
    inputBinding:
      position: 102
      prefix: -b
  - id: best_region
    type:
      - 'null'
      - boolean
    doc: Show only best non-overlapping hits
    inputBinding:
      position: 102
      prefix: -r
  - id: cutoff
    type:
      - 'null'
      - float
    doc: p-value cutoff
    default: 1.0
    inputBinding:
      position: 102
      prefix: -p
  - id: eps
    type:
      - 'null'
      - boolean
    doc: Create colored plots in EPS format
    inputBinding:
      position: 102
      prefix: -e
  - id: eps_cutoff
    type:
      - 'null'
      - float
    doc: Create plots only if p better than this cutoff
    default: 0.05
    inputBinding:
      position: 102
      prefix: -i
  - id: eps_dir
    type:
      - 'null'
      - Directory
    doc: Directory to put eps-files
    default: eps
    inputBinding:
      position: 102
      prefix: -d
  - id: gtf
    type:
      - 'null'
      - boolean
    doc: Format output as GTF
    inputBinding:
      position: 102
      prefix: -g
  - id: num_samples
    type:
      - 'null'
      - int
    doc: Number of samples to calculate p-value
    default: 100
    inputBinding:
      position: 102
      prefix: -n
  - id: outfile
    type:
      - 'null'
      - string
    doc: Output file
    default: stdout
    inputBinding:
      position: 102
      prefix: -o
  - id: pars
    type:
      - 'null'
      - string
    doc: Parameters as comma separated string (see README for details)
    inputBinding:
      position: 102
      prefix: -c
  - id: stop_early
    type:
      - 'null'
      - boolean
    doc: Don't calculate p-values for hits likely to be above cutoff
    inputBinding:
      position: 102
      prefix: -s
  - id: tabular
    type:
      - 'null'
      - boolean
    doc: Format output as tab delimited fields
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnacode:0.3.1--h7b50bb2_0
stdout: rnacode_RNAcode.out
