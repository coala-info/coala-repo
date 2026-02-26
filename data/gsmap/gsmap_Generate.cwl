cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsmap
label: gsmap_Generate
doc: "gsMap: error: argument subcommand: invalid choice: 'Generate' (choose from quick_mode,
  run_find_latent_representations, run_latent_to_gene, run_generate_ldscore, run_spatial_ldsc,
  run_cauchy_combination, run_report, format_sumstats, create_slice_mean)\n\nTool
  homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands: quick_mode, run_find_latent_representations,
      run_latent_to_gene, run_generate_ldscore, run_spatial_ldsc, run_cauchy_combination,
      run_report, format_sumstats, create_slice_mean'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
stdout: gsmap_Generate.out
