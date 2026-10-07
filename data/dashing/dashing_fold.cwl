cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing
  - fold
label: dashing_fold
doc: "Compresses HLLs from a larger size to smaller sizes.\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs:
  - id: input_sketch
    type: File
    doc: HLL sketch to fold
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Write to <path> instead of stdout
    inputBinding:
      position: 102
      prefix: -o
  - id: destination_p
    type:
      - 'null'
      - int
    doc: set destination p [must be smaller than the input sketch; by default one
      less than the input p]
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: folded_sketch
    type: File
    doc: Folded HLL sketch
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_fold.out
