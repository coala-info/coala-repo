cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phava
  - cluster
label: phava_cluster
doc: "Cluster the invertons from one or many genomes\n\nTool homepage: https://github.com/patrickwest/PhaVa"
arguments:
  - position: 1000
    shellQuote: false
    valueFrom: '&& rm -rf $(inputs.dir_name)/intermediate/tmp_mmseqs $(inputs.new_dir ? inputs.new_dir : inputs.dir_name)/intermediate/tmp_mmseqs'
inputs:
  - id: dir_name
    type: string
    doc: "Name of the work directory where data and output are stored (use the same one for all PhaVa operations); created when it does not exist yet"
    inputBinding:
      position: 1
      prefix: --dir
  - id: prior_dir
    type:
      - 'null'
      - Directory
    doc: "Work directory written by an earlier PhaVa step (staged writable under the name given in dir_name)"
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 2
      prefix: --cpus
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Should the logging info be output to stdout? Otherwise it is written to PhaVa.log"
    inputBinding:
      position: 3
      prefix: --log
  - id: pident
    type:
      - 'null'
      - float
    doc: "Percent identity for the clustering"
    inputBinding:
      position: 10
      prefix: --pident
  - id: new_dir
    type:
      - 'null'
      - string
    doc: "New PhaVa directory for the clustered database (defaults to the work directory)"
    inputBinding:
      position: 11
      prefix: --new_dir
  - id: flank_size
    type:
      - 'null'
      - int
    doc: "Size flanking size to include on either side of invertable regions (in bps)"
    inputBinding:
      position: 12
      prefix: --flankSize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: work_dir
    type: Directory
    doc: Work directory with the PhaVa data, intermediate files and results
    outputBinding:
      glob: $(inputs.dir_name)
  - id: clustered_dir
    type:
      - 'null'
      - Directory
    doc: New PhaVa directory for the clustered database (when new_dir is given)
    outputBinding:
      glob: $(inputs.new_dir)
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.dir_name)
        entry: '${ return inputs.prior_dir ? inputs.prior_dir : {"class": "Directory", "basename": inputs.dir_name, "listing": []}; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_cluster.out
