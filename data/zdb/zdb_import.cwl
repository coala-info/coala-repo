cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - zdb
  - import
label: zdb_import
doc: "Unpack an archive that was prepared by the export command\nYou can alternatively
  manually unpack it.\n\nTool homepage: https://github.com/metagenlab/zDB/"
inputs:
  - id: archive
    type: File
    doc: specify the archive to be unpacked
    inputBinding:
      position: 101
      prefix: --archive=
      separate: false
  - id: outdir
    type: string
    default: zdb_import_out
    doc: specify where the archive will be unpacked
    inputBinding:
      position: 101
      prefix: --outdir=
      separate: false
outputs:
  - id: unpacked_dir
    type: Directory
    doc: directory where the archive was unpacked
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zdb:1.3.11--hdfd78af_0
stdout: zdb_import.out
