cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - novoloci
label: novoloci
doc: "NOVOLoci: haplotype-aware targeted de novo assembler for long reads. It reads
  all parameters from a configuration file.\n\nThe wrapper writes a copy of the
  configuration file in which `Output path` and `TMP path` are replaced by absolute
  paths in the working directory (novoloci needs absolute paths). Files named in the
  configuration (seed, reads) are staged in the working directory, so give them
  as relative names.\n\nTool homepage: https://github.com/ndierckx/NOVOLoci"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: novoloci_run_config.txt
        entry: |-
          $(inputs.config_file.contents.replace(/Output path[ \t]*=[^\n]*/, "Output path           = " + runtime.outdir + "/" + inputs.output_folder + "/").replace(/TMP path[ \t]*=[^\n]*/, "TMP path              = " + runtime.tmpdir + "/"))
      - $(inputs.supporting_files)
inputs:
  - id: config_file
    type: File
    loadContents: true
    doc: Configuration file with all assembly parameters.
  - id: output_folder
    type: string
    doc: Name of the output folder (written into the Output path line of the
      configuration file).
    default: novoloci_out
  - id: supporting_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the configuration file (seed sequence, reads), staged in
      the working directory.
arguments:
  - prefix: -c
    valueFrom: novoloci_run_config.txt
outputs:
  - id: output_dir
    type: Directory
    doc: Assembly output folder
    outputBinding:
      glob: $(inputs.output_folder)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoloci:0.5--hdfd78af_0
stdout: novoloci.out
