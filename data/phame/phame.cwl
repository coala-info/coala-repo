cwlVersion: v1.2
class: CommandLineTool
baseCommand: phame
label: phame
doc: "PhaME (version 1.0.2)\n\nTool homepage: https://github.com/LANL-Bioinformatics/PhaME"
inputs:
  - id: control_file
    type: File
    doc: control file
    inputBinding:
      position: 1
  - id: vcheck
    type:
      - 'null'
      - boolean
    doc: checks if all depenencies are correct and in path.
    inputBinding:
      position: 102
      prefix: --vcheck
  - id: reference_dir
    type:
      - 'null'
      - Directory
    doc: Directory named as refdir in the control file (reference and genome
      files); staged in the working directory under its own name
  - id: reads_dir
    type:
      - 'null'
      - Directory
    doc: Optional extra input directory (reads or contigs) named in the control
      file; staged in the working directory under its own name
  - id: work_dir
    type: string
    doc: Name of the working directory given as workdir in the control file;
      it is created before the run and collected afterwards
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: work_dir_out
    type: Directory
    doc: Working directory with the results (alignments, trees, statistics)
    outputBinding:
      glob: $(inputs.work_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.work_dir)
        entry: '$({"class": "Directory", "basename": inputs.work_dir, "listing": []})'
        writable: true
      - '${ return inputs.reference_dir ? [{"entry": inputs.reference_dir, "writable": true}] : []; }'
      - '${ return inputs.reads_dir ? [{"entry": inputs.reads_dir, "writable": true}] : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phame:1.0.3--pl5321hdfd78af_3
stdout: phame.out
