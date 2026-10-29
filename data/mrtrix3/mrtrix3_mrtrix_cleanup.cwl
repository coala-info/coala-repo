cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrtrix_cleanup]
label: mrtrix3_mrtrix_cleanup
doc: |-
  Clean up residual temporary files & scratch directories from MRtrix3 commands

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: SchemaDefRequirement
    types:
      - name: mrtrix_cleanup_continue_rec
        type: record
        fields:
          - name: ScratchDir
            type: string
            doc: <ScratchDir>
            inputBinding:
              position: 1
          - name: LastFile
            type: string
            doc: <LastFile>
            inputBinding:
              position: 2
inputs:
  - id: target_dir
    type: Directory
    doc: Path from which to commence filesystem search
    inputBinding:
      position: 1
  - id: test
    type: ['null', boolean]
    doc: 'Run script in test mode: will list identified files / directories, but not attempt to delete
      them'
    inputBinding:
      prefix: -test
  - id: failed
    type: ['null', string]
    doc: Write list of items that the script failed to delete to a text file
    inputBinding:
      prefix: -failed
  - id: nocleanup
    type: ['null', boolean]
    doc: do not delete intermediate files during script execution, and do not delete scratch directory
      at script completion.
    inputBinding:
      prefix: -nocleanup
  - id: scratch
    type: ['null', string]
    doc: manually specify the path in which to generate the scratch directory.
    inputBinding:
      prefix: -scratch
  - id: continue
    type: ['null', mrtrix_cleanup_continue_rec]
    doc: continue the script from a previous execution; must provide the scratch directory path, and the
      name of the last successfully-generated file.
    inputBinding:
      prefix: -continue
  - id: info
    type: ['null', boolean]
    doc: display information messages.
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: do not display information messages or progress status. Alternatively, this can be achieved by
      setting the MRTRIX_QUIET environment variable to a non-empty string.
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: display debugging messages.
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: force overwrite of output files.
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: use this number of threads in multi-threaded applications (set to 0 to disable multi-threading).
    inputBinding:
      prefix: -nthreads
outputs:
  - id: stderr_out
    type: stderr
    doc: Messages printed by the script (the list of items found, or deleted).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stderr: mrtrix_cleanup_stderr.txt
