cwlVersion: v1.2
class: CommandLineTool
baseCommand: RapClust
label: rapclust
doc: "RapClust clusters de novo assembled transcripts using the equivalence classes
  of Salmon or Sailfish quantifications and the MCL graph clustering. The experimental
  setup (conditions, sample directories, output directory, cutoff) is given in a
  YAML configuration file.\n\nTool homepage: https://github.com/COMBINE-lab/RapClust"
inputs:
  - id: config
    type: File
    doc: Config file describing the experimental setup (YAML with the entries
      conditions, samples, outdir and optional cutoff)
    inputBinding:
      position: 101
      prefix: --config
  - id: sample_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Salmon or Sailfish quantification folders named in the config file
      (staged in the working directory so the names resolve)
  - id: outdir_name
    type: string
    doc: Name of the output folder; it must equal the outdir entry of the
      config file
    default: rapclust_out
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sample_dirs)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Output folder with the multiple alignment graph (mag.net), the filtered
      graph, the clusters (mag.clust, mag.flat.clust) and stats.json
    outputBinding:
      glob: $(inputs.outdir_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapclust:0.1.2--py35_0
stdout: rapclust.out
