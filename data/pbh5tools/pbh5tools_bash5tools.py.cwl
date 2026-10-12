cwlVersion: v1.2
class: CommandLineTool
baseCommand: bash5tools.py
label: pbh5tools_bash5tools.py
doc: "Tool for extracting data from .bas.h5 files\n\nTool homepage: https://github.com/zkennedy/pbh5tools"
inputs:
  - id: input_file
    type: File
    doc: input .bas.h5 filename
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: companion_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The .bax.h5 files (and optional .rgn.h5 region files) that the .bas.h5
      file refers to. They are staged next to the input file.
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Catch exceptions in debugger (requires ipdb)
    inputBinding:
      position: 102
      prefix: --debug
  - id: min_length
    type:
      - 'null'
      - int
    doc: min read length
    inputBinding:
      position: 102
      prefix: --minLength
  - id: min_passes
    type:
      - 'null'
      - int
    doc: min number of CCS passes, valid only with --readType=ccs
    inputBinding:
      position: 102
      prefix: --minPasses
  - id: min_read_score
    type:
      - 'null'
      - int
    doc: min read score, valid only with --readType={unrolled,subreads}
    inputBinding:
      position: 102
      prefix: --minReadScore
  - id: out_type
    type:
      - 'null'
      - string
    doc: output file type (fasta, fastq)
    inputBinding:
      position: 102
      prefix: --outType
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Print runtime profile at exit
    inputBinding:
      position: 102
      prefix: --profile
  - id: read_type
    type:
      - 'null'
      - string
    doc: read type (ccs, subreads, or unrolled)
    inputBinding:
      position: 102
      prefix: --readType
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set the verbosity level
    inputBinding:
      position: 102
      prefix: --verbose
  - id: out_file_prefix_path
    type: string?
    doc: output filename prefix [None]
    inputBinding:
      position: 103
      prefix: --outFilePrefix
outputs:
  - id: out_file_prefix
    type:
      - 'null'
      - type: array
        items: File
    doc: Extracted reads in fasta or fastq format
    outputBinding:
      glob: |
        ${ return inputs.out_file_prefix_path ? inputs.out_file_prefix_path + "*" : ["*.fasta", "*.fastq"]; }
  - id: stdout_output
    type: stdout
    doc: Standard output
stdout: pbh5tools_bash5tools_stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [inputs.input_file];
        if (inputs.companion_files) { l = l.concat(inputs.companion_files); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
