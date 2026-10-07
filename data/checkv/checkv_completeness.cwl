cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkv
  - completeness
label: checkv_completeness
doc: "Estimate completeness for genome fragments\n\nTool homepage: https://bitbucket.org/berkeleylab/checkv"
inputs:
  - id: input
    type: File
    doc: Input nucleotide sequences in FASTA format (.gz, .bz2 and .xz files are
      supported)
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 2
  - id: existing_output
    type:
      - 'null'
      - Directory
    doc: Output directory written by earlier CheckV steps (contamination); it is
      staged writable under the name given by output so this step can read
      and add to it
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress logging messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reference_database_path
    type:
      - 'null'
      - Directory
    doc: Reference database path. By default the CHECKVDB environment variable 
      is used
    inputBinding:
      position: 102
      prefix: -d
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Overwrite existing intermediate files. By default CheckV continues 
      where program left off
    inputBinding:
      position: 102
      prefix: --restart
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for prodigal-gv and DIAMOND
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: out_output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: '$(inputs.output)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        if (inputs.existing_output) {
          return [{"entry": inputs.existing_output, "entryname": inputs.output, "writable": true}];
        }
        return [];
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
