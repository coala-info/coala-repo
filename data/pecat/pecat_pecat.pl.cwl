cwlVersion: v1.2
class: CommandLineTool
baseCommand: pecat.pl
label: pecat_pecat.pl
doc: "A pipeline for long-read processing including correction, assembly, and unzipping.\n
  \nTool homepage: https://github.com/lemene/PECAT"
inputs:
  - id: command
    type: string
    doc: 'The command to execute: correct (correct rawreads), assemble (generate haplotype-collapsed
      assembly), unzip (generate diploid assembly), or config (generate default config
      file)'
    inputBinding:
      position: 1
  - id: cfg_fname
    type: File
    doc: Path to the configuration file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pecat:0.0.3--hdb21b49_2
stdout: pecat_pecat.pl.out
