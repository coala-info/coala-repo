cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl /usr/local/share/hymet/main.pl
label: hymet_legacy
doc: "HYMET now ships with a unified CLI (bin/hymet). For batch runs try:\n      \
  \ bin/hymet run --contigs /path/to/sample.fna --out /path/to/out --threads 8\n \
  \      bin/hymet bench --manifest bench/cami_manifest.tsv\n\nTool homepage: https://github.com/inesbmartins02/HYMET"
inputs:
  - id: input_directory
    type: Directory
    doc: Please enter the path to the input directory (containing .fna files)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
stdout: hymet_legacy.out
