cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MetaCHIP
  - PI
label: metachip_PI
doc: "Prepare input files (gene prediction, all-vs-all blastn, grouping) for MetaCHIP
  horizontal gene transfer detection.\n\nTool homepage: https://github.com/songweizhi/MetaCHIP"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: genome_dir
    type: Directory
    doc: input genome folder
    inputBinding:
      prefix: -i
  - id: taxon
    type: ['null', File]
    doc: taxonomic classification of input genomes
    inputBinding:
      prefix: -taxon
  - id: output_folder
    type: ['null', string]
    doc: 'output folder (default: current working directory)'
    inputBinding:
      prefix: -o
  - id: prefix
    type: string
    doc: output prefix
    inputBinding:
      prefix: -p
  - id: rank
    type: ['null', string]
    doc: grouping rank, choose from p, c, o, f and g or any combination of them
    inputBinding:
      prefix: -r
  - id: grouping
    type: ['null', File]
    doc: grouping file
    inputBinding:
      prefix: -g
  - id: extension
    type: ['null', string]
    doc: file extension
    inputBinding:
      prefix: -x
  - id: nonmeta
    type: ['null', boolean]
    doc: provide if input genomes are NOT metagenome-assembled genomes
    inputBinding:
      prefix: -nonmeta
  - id: threads
    type: ['null', int]
    doc: 'number of threads, default: 1'
    inputBinding:
      prefix: -t
  - id: quiet
    type: ['null', boolean]
    doc: not report progress
    inputBinding:
      prefix: -quiet
  - id: force
    type: ['null', boolean]
    doc: force overwrite existing results
    inputBinding:
      prefix: -force
  - id: noblast
    type: ['null', boolean]
    doc: skip running all-vs-all blastn, provide if you have other ways (e.g. with
      job scripts) to speed up the blastn step
    inputBinding:
      prefix: -noblast
outputs:
  - id: working_dir
    type: Directory
    doc: MetaCHIP working directory holding prodigal output, blast results and the
      grouping file
    outputBinding:
      glob: "$(inputs.output_folder ? inputs.output_folder + '/' : '')$(inputs.prefix)_MetaCHIP_wd"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
