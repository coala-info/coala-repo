cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sysc
  - trio_result_k21
label: symbiontscreener_trio_result_k21
doc: "Filter offspring reads by parental and shared k-mer density (trio-only result).\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs:
  - id: density_dir
    type: Directory
    doc: Output directory of density_k21 (step02.1.k21)
  - id: threshold1
    type: ['null', float]
    doc: Minimum density of parental k-mers (default 0.003)
    inputBinding:
      position: 1
      prefix: --threshold1
  - id: threshold2
    type: ['null', float]
    doc: Minimum density of shared k-mers (default 0.01)
    inputBinding:
      position: 1
      prefix: --threshold2
outputs:
  - id: step02_2_k21
    type: Directory
    doc: Trio result directory step02.2.k21
    outputBinding:
      glob: step02.2.k21
  - id: stdout
    type: stdout
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: step02.1.k21
        entry: $(inputs.density_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_trio_result_k21.stdout.txt
