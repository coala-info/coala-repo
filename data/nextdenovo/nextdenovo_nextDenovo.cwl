cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextDenovo]
label: nextdenovo_nextDenovo
doc: "Fast and accurate de novo assembler for long reads. All parameters are given in
  the configuration file (run.cfg). The files named in it (the input.fofn list and the
  read files) are staged in the working directory, so use relative names such as
  ./input.fofn in the config.\n\nTool homepage: https://github.com/Nextomics/NextDenovo"
inputs:
  - id: config_file
    type: File
    doc: Configuration file for NextDenovo.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the configuration file (input.fofn and the read files). They are staged in the working directory beside the config file.
  - id: log_file
    type:
      - 'null'
      - string
    doc: Log file (default pidXXX.log.info).
    inputBinding:
      position: 102
      prefix: --log
  - id: workdir
    type: string
    doc: Name of the work directory set as workdir in the configuration file; it is collected as output.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: assembly_dir
    type: Directory
    doc: The NextDenovo work directory with the corrected reads and the assembly.
    outputBinding:
      glob: $(inputs.workdir)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file, when log_file is given.
    outputBinding:
      glob: |-
        ${ return inputs.log_file ? inputs.log_file : null; }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.config_file)
      - $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextdenovo:2.5.2--py310h0ceaa1d_6
stdout: nextdenovo_nextDenovo.out
