cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sysc
  - density_s40
label: symbiontscreener_density_s40
doc: "Calculate the paternal-only, maternal-only and shared k-mer density of each offspring read.\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs:
  - id: build_dir
    type: Directory
    doc: Output directory of build_s40 (step01.s40)
  - id: offspring
    type:
      type: array
      items: File
      inputBinding:
        prefix: --offspring
    doc: Offspring sequence file (gzip allowed if the name ends in .gz). Repeat for several files.
    inputBinding:
      position: 1
  - id: offspring_format
    type: ['null', string]
    doc: fasta or fastq (default fasta)
    inputBinding:
      position: 1
      prefix: --offspring_format
  - id: thread
    type: ['null', int]
    doc: Thread number (default 8)
    inputBinding:
      position: 1
      prefix: --thread
outputs:
  - id: step02_1_s40
    type: Directory
    doc: Density directory step02.1.s40 with trio_density.data.txt
    outputBinding:
      glob: step02.1.s40
  - id: stdout
    type: stdout
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: step01.s40
        entry: $(inputs.build_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_density_s40.stdout.txt
