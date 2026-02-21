cwlVersion: v1.2
class: CommandLineTool
baseCommand: dms_MS-make-ref
label: dms_MS-make-ref
doc: "A tool for creating reference files, likely part of the Deep Mutational Scanning
  (DMS) suite.\n\nTool homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
stdout: dms_MS-make-ref.out
