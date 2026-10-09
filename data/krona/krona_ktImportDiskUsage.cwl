cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportDiskUsage
label: krona_ktImportDiskUsage
doc: 'Creates a Krona chart of disk usage of files and folders in the specified directory.
  Symbolic links and mount points within the directory are not followed. Small files
  or folders (that are less than 0.1% of the total size) will be grouped. The chart
  can be colored by log[10] of the number of days since each file or folder was modified.


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: directory
    type: Directory
    doc: Directory to report the disk usage of.
    inputBinding:
      position: 1
  - id: krona_resources_url
    type:
      - 'null'
      - string
    doc: URL of Krona resources to use instead of bundling them with the chart (e.g.
      "http://krona.sourceforge.net"). Reduces size of charts and allows updates,
      though charts will not work without access to this URL.
    inputBinding:
      position: 102
      prefix: -u
  - id: output_file_path
    type: string
    default: du.krona.html
    doc: Output file name
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
