cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hubward
  - upload
label: hubward_upload
doc: "Creates a track hub and uploads to configured host. Track hub files include
  hub.txt, genomes.txt, and trackDb.txt files. If --hub-only has been specified, only
  these files will be uploaded to the host configured in the group config file. Otherwise,
  these files and all of the configured data files (bigBed, bigWig, BAM, and VCF files)
  from individual studies are uploaded via rsync to their respective configured locations
  on the remote host.\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: filename
    type: File
    doc: Group config file
    inputBinding:
      position: 1
  - id: host
    type:
      - 'null'
      - string
    doc: Host to upload to. Overrides [server][host] in the group config file.
    inputBinding:
      position: 102
      prefix: --host
  - id: hub_only
    type:
      - 'null'
      - boolean
    doc: Just update the hub text files, not data files
    default: false
    inputBinding:
      position: 102
      prefix: --hub-only
  - id: hub_remote
    type:
      - 'null'
      - File
    doc: Remote filename for the top-level hub file. Overrides 
      [server][hub_remote] in the config file.
    inputBinding:
      position: 102
      prefix: --hub_remote
  - id: rsync_options
    type:
      - 'null'
      - string
    doc: Options for rsync.
    default: "'-avrL --progress'"
    inputBinding:
      position: 102
      prefix: --rsync_options
  - id: user
    type:
      - 'null'
      - string
    doc: User for host. Overrides [server][user] in the group config file.
    inputBinding:
      position: 102
      prefix: --user
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward:0.2.2--py27_1
stdout: hubward_upload.out
