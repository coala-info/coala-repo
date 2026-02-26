cwlVersion: v1.2
class: CommandLineTool
baseCommand: yame pairwise
label: yame_pairwise
doc: "Compute a per-site differential-methylation set between two format-3 (M/U) samples,
  and output it as a single format-6 track (set + universe).\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: mu1_cx
    type: File
    doc: Format-3 input (M/U counts). The first record is used as sample 1.
    inputBinding:
      position: 1
  - id: mu2_cx
    type:
      - 'null'
      - File
    doc: Optional second format-3 input. If omitted, sample 2 is read as the 
      SECOND record from MU1.cx (i.e., the top 2 samples in the same file).
    inputBinding:
      position: 2
  - id: delta
    type:
      - 'null'
      - float
    doc: 'Minimum absolute beta difference required to call a site differential (default:
      0).'
    default: 0
    inputBinding:
      position: 103
      prefix: -d
  - id: direction_mode
    type:
      - 'null'
      - int
    doc: "Direction mode (default: 1):\n              1  beta1 > beta2  (hypermethylated
      in sample 1)\n              2  beta1 < beta2  (hypomethylated  in sample 1)\n\
      \              3  beta1 != beta2 (any difference; with -d uses |beta1-beta2|>delta)"
    default: 1
    inputBinding:
      position: 103
      prefix: -H
  - id: min_cov
    type:
      - 'null'
      - int
    doc: 'Minimum coverage (M+U) in BOTH samples to include site in universe (default:
      1).'
    default: 1
    inputBinding:
      position: 103
      prefix: -c
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Write output to file (default: stdout).'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
