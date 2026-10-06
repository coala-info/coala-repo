cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bohra
  - deps
  - check
label: bohra_deps_check
doc: "Help for checking dependencies.\n\nTool homepage: https://github.com/kristyhoran/bohra"
inputs:
  - id: tool
    type:
      - 'null'
      - string
    doc: "Update only a specific set of tools from a single environment. Should really only be used for development and/or testing purposes. One of: any2fasta, meningotype, lissero, mlst, prokka, snpdists, ngmaster, assemblers, emmtyper, seqkit, fastp, kraken2, gubbins, mash, coresnpfilter, iqtree, quicktree, veryfasttree, ska, snippy, mob_suite, panaroo, ectyper, kleborate, stype, abritamr, tbtamr, sonneitype, classify-pangenome, datasmryzr, seqtk, shigapass, cluster, all. Default: all."
    inputBinding:
      position: 101
      prefix: --tool
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: Bohra log file
    outputBinding:
      glob: bohra.log
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
stdout: bohra_deps_check.out
