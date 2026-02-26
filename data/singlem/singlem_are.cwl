cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem
label: singlem_are
doc: "singlem: error: argument subparser_name: invalid choice: 'are' (choose from
  data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction,
  renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms,
  supplement)\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: subparser_name
    type: string
    doc: 'The subcommand to run. Available options: data, pipe, appraise, seqs, makedb,
      query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree,
      regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
stdout: singlem_are.out
