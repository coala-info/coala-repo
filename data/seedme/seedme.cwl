cwlVersion: v1.2
class: CommandLineTool
baseCommand: seedme
label: seedme
doc: "Upload content to SeedMe.org\n\nTool homepage: https://github.com/HackUCF/seedme"
inputs:
  - id: api_key
    type:
      - 'null'
      - string
    doc: Specify your apikey at SeedMe.org
    inputBinding:
      position: 101
      prefix: --apikey
  - id: auth_file_path
    type:
      - 'null'
      - File
    doc: 'Specify path to authorization file (default file at ~/seedme.txt or ~/.seedme
      is searched when this option not specified) This file must contain the following
      {"username" : "YourUserName", "apikey" : "YourApiKey"} Download this file from
      https://www.seedme.org/user'
    inputBinding:
      position: 101
      prefix: --auth_path
  - id: connect_timeout
    type:
      - 'null'
      - int
    doc: Connection timeout duration in seconds
    default: 60
    inputBinding:
      position: 101
      prefix: --connect_timeout
  - id: curl_path
    type:
      - 'null'
      - File
    doc: 'Specify absolute path to curl executible (default: environment path)'
    inputBinding:
      position: 101
      prefix: --curl_path
  - id: delete
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Delete a collection or its content Arguments: Collection_ID filenames|node_ids
      filenames: comma seperated string * wildcard allowed node_ids: comma seperated
      node_ids'
    inputBinding:
      position: 101
      prefix: --delete
  - id: description
    type:
      - 'null'
      - string
    doc: Specify description for the collection
    inputBinding:
      position: 101
      prefix: --description
  - id: download
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Download content from a collection Arguments: ID all|video|wildcard DOWNLOAD_PATH
      RETRY INTERVAL(Requires first two arguments) (default DOWNLOAD_PATH: ~/Downloads
      ) (default RETRY: 3 ) (default INTERVAL: 60)'
    inputBinding:
      position: 101
      prefix: --download
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Enable dry run execution mode to check all input except authorization
    inputBinding:
      position: 101
      prefix: --dry_run
  - id: email
    type:
      - 'null'
      - type: array
        items: string
    doc: Add emails to share a collection (can be used multiple times)
    inputBinding:
      position: 101
      prefix: --email
  - id: file_description
    type:
      - 'null'
      - string
    doc: Add file description
    inputBinding:
      position: 101
      prefix: --file_description
  - id: file_dont_encode
    type:
      - 'null'
      - boolean
    doc: Do not trigger video transcoding
    inputBinding:
      position: 101
      prefix: --file_dont_encode
  - id: file_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite file if it exists
    default: false
    inputBinding:
      position: 101
      prefix: --file_overwrite
  - id: file_path
    type:
      - 'null'
      - string
    doc: Specify FILE | PATH with * wildcard | DIR
    inputBinding:
      position: 101
      prefix: --file_path
  - id: file_poster_path
    type:
      - 'null'
      - File
    doc: Specify FILE PATH
    inputBinding:
      position: 101
      prefix: --file_poster_path
  - id: file_title
    type:
      - 'null'
      - string
    doc: Set file title
    inputBinding:
      position: 101
      prefix: --file_title
  - id: file_transcode
    type:
      - 'null'
      - boolean
    doc: Trigger video transcoding to create videos for different devices
    inputBinding:
      position: 101
      prefix: --file_transcode
  - id: insecure
    type:
      - 'null'
      - boolean
    doc: Disable SSL communication
    inputBinding:
      position: 101
      prefix: --insecure
  - id: keyvalue
    type:
      - 'null'
      - type: array
        items: string
    doc: Add key:value pairs to the collection (can be used multiple times)
    inputBinding:
      position: 101
      prefix: --keyvalue
  - id: list
    type:
      - 'null'
      - string
    doc: 'list content for a collection(default: ticker)Must be used with -query ID
      option'
    inputBinding:
      position: 101
      prefix: --list
  - id: logfile
    type:
      - 'null'
      - File
    doc: Appends output to specified log file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: notify
    type:
      - 'null'
      - boolean
    doc: 'Send email to users about a shared collection (default: False)'
    default: false
    inputBinding:
      position: 101
      prefix: --notify
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files, if any
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: post_method
    type:
      - 'null'
      - string
    doc: Overide post method
    default: requests
    inputBinding:
      position: 101
      prefix: -post
  - id: privacy
    type:
      - 'null'
      - string
    doc: 'Specify privacy to access the collection (default: private)'
    default: private
    inputBinding:
      position: 101
      prefix: --privacy
  - id: query
    type:
      - 'null'
      - string
    doc: 'Query your collections with optional ID (default: Returns a list of ID and
      Title)'
    inputBinding:
      position: 101
      prefix: --query
  - id: read_timeout
    type:
      - 'null'
      - int
    doc: Read timeout duration in seconds
    inputBinding:
      position: 101
      prefix: --read_timeout
  - id: sequence_description
    type:
      - 'null'
      - string
    doc: Add sequence description
    inputBinding:
      position: 101
      prefix: --sequence_description
  - id: sequence_encode
    type:
      - 'null'
      - boolean
    doc: Trigger video encoding to create a video from image sequence
    inputBinding:
      position: 101
      prefix: --sequence_encode
  - id: sequence_frame_rate
    type:
      - 'null'
      - float
    doc: Specify sequence frame rate for video encoding
    default: 30.0
    inputBinding:
      position: 101
      prefix: --sequence_frame_rate
  - id: sequence_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite sequence if it exists (default:False)
    default: false
    inputBinding:
      position: 101
      prefix: --sequence_overwrite
  - id: sequence_path
    type:
      - 'null'
      - string
    doc: Specify DIR | PATH with * wildcard
    inputBinding:
      position: 101
      prefix: --sequence_path
  - id: sequence_poster_path
    type:
      - 'null'
      - File
    doc: Specify FILE PATH
    inputBinding:
      position: 101
      prefix: --sequence_poster_path
  - id: sequence_title
    type:
      - 'null'
      - string
    doc: Set sequence title (Required)
    inputBinding:
      position: 101
      prefix: --sequence_title
  - id: show_auth_in_curl_commands
    type:
      - 'null'
      - boolean
    doc: Show auth in curl command line options
    inputBinding:
      position: 101
      prefix: --show_auth_in_curl_commands
  - id: show_curl_commands
    type:
      - 'null'
      - boolean
    doc: Show curl command line options
    inputBinding:
      position: 101
      prefix: --show_curl_commands
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Silence all console output including errors (Not recommended during 
      collection creation)
    inputBinding:
      position: 101
      prefix: --silent
  - id: ssl_certificate_path
    type:
      - 'null'
      - File
    doc: Set path to SSL certificate
    inputBinding:
      position: 101
      prefix: --cacert
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Add tag to the collection (can be used many times)
    inputBinding:
      position: 101
      prefix: --tag
  - id: tail
    type:
      - 'null'
      - int
    doc: Only list last n items to show. Must be used in conjunction with -list 
      option
    inputBinding:
      position: 101
      prefix: --tail
  - id: ticker
    type:
      - 'null'
      - string
    doc: Add ticker text upto 128 char to the collection
    inputBinding:
      position: 101
      prefix: --ticker
  - id: title
    type:
      - 'null'
      - string
    doc: Specify title for the collection (Required)
    inputBinding:
      position: 101
      prefix: --title
  - id: transfer_email
    type:
      - 'null'
      - string
    doc: Specify email to whom the collection ownership will be transferred
    inputBinding:
      position: 101
      prefix: --transfer
  - id: update_collection_id
    type:
      - 'null'
      - string
    doc: Specify collection id for update or query
    inputBinding:
      position: 101
      prefix: --update
  - id: url
    type:
      - 'null'
      - string
    doc: Overide default and set new webservices url
    inputBinding:
      position: 101
      prefix: --url
  - id: user_name
    type:
      - 'null'
      - string
    doc: Specify your username at SeedMe.org
    inputBinding:
      position: 101
      prefix: --user
  - id: verbose
    type:
      - 'null'
      - string
    doc: verbosity level
    default: ERROR
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seedme:1.2.4--py27_1
stdout: seedme.out
