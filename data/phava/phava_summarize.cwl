cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phava
  - summarize
label: phava_summarize
doc: "Report general statistics (requires running locate/create or variation_wf beforehand)\n\nTool homepage: https://github.com/patrickwest/PhaVa"
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: work_dir
    type: Directory
    doc: Work directory with the PhaVa data, intermediate files and results
    outputBinding:
      glob: $(inputs.dir_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.dir_name)
        entry: '${ return inputs.prior_dir ? inputs.prior_dir : {"class": "Directory", "basename": inputs.dir_name, "listing": []}; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_summarize.out
