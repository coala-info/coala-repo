cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./bam_depth
label: halfdeep_bam_depth.sh
doc: "Assumes we have <ref> and input.fofn in the current dir\n\nTool homepage: https://github.com/richard-burhans/HalfDeep"
inputs:
  - id: ref
    type: string
    doc: Reference file
    inputBinding:
      position: 1
  - id: number
    type:
      - 'null'
      - int
    doc: Line number in input.fofn of the file to process. If not given, 
      SLURM_ARRAY_TASK_ID is used.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_bam_depth.sh.out
