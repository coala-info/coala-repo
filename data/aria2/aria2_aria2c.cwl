cwlVersion: v1.2
class: CommandLineTool
baseCommand: aria2c
label: aria2_aria2c
doc: "A multi-protocol & multi-source command-line download utility\n\nTool homepage:
  https://aria2.github.io/"
inputs:
  - id: uris
    type:
      - 'null'
      - type: array
        items: string
    doc: HTTP(S)/FTP/BitTorrent Magnet URIs, or paths to local torrent/metalink files
    inputBinding:
      position: 1
  - id: check_integrity
    type:
      - 'null'
      - boolean
    doc: Check file integrity by validating piece hashes or a hash of entire file.
    default: false
    inputBinding:
      position: 102
      prefix: --check-integrity
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Continue downloading a partially downloaded file.
    default: false
    inputBinding:
      position: 102
      prefix: --continue
  - id: dht_listen_addr6
    type:
      - 'null'
      - string
    doc: Specify address to bind socket for IPv6 DHT. It should be a global unicast
      IPv6 address of the host.
    inputBinding:
      position: 102
      prefix: --dht-listen-addr6
  - id: dht_listen_port
    type:
      - 'null'
      - type: array
        items: string
    doc: Set UDP listening port used by DHT(IPv4, IPv6) and UDP tracker.
    default: 6881-6999
    inputBinding:
      position: 102
      prefix: --dht-listen-port
  - id: dir
    type:
      - 'null'
      - Directory
    doc: The directory to store the downloaded file.
    inputBinding:
      position: 102
      prefix: --dir
  - id: enable_dht
    type:
      - 'null'
      - boolean
    doc: Enable IPv4 DHT functionality. It also enables UDP tracker support.
    default: true
    inputBinding:
      position: 102
      prefix: --enable-dht
  - id: enable_dht6
    type:
      - 'null'
      - boolean
    doc: Enable IPv6 DHT functionality.
    default: false
    inputBinding:
      position: 102
      prefix: --enable-dht6
  - id: file_allocation
    type:
      - 'null'
      - string
    doc: Specify file allocation method (none, prealloc, trunc, falloc).
    default: prealloc
    inputBinding:
      position: 102
      prefix: --file-allocation
  - id: force_sequential
    type:
      - 'null'
      - boolean
    doc: Fetch URIs in the command-line sequentially and download each URI in a separate
      session.
    default: false
    inputBinding:
      position: 102
      prefix: --force-sequential
  - id: ftp_passwd
    type:
      - 'null'
      - string
    doc: Set FTP password. This affects all URLs.
    inputBinding:
      position: 102
      prefix: --ftp-passwd
  - id: ftp_user
    type:
      - 'null'
      - string
    doc: Set FTP user. This affects all URLs.
    inputBinding:
      position: 102
      prefix: --ftp-user
  - id: http_passwd
    type:
      - 'null'
      - string
    doc: Set HTTP password. This affects all URLs.
    inputBinding:
      position: 102
      prefix: --http-passwd
  - id: http_user
    type:
      - 'null'
      - string
    doc: Set HTTP user. This affects all URLs.
    inputBinding:
      position: 102
      prefix: --http-user
  - id: input_file
    type:
      - 'null'
      - File
    doc: Downloads URIs found in FILE.
    inputBinding:
      position: 102
      prefix: --input-file
  - id: listen_port
    type:
      - 'null'
      - type: array
        items: string
    doc: Set TCP port number for BitTorrent downloads. Multiple ports can be specified
      by using ',' or '-'.
    default: 6881-6999
    inputBinding:
      position: 102
      prefix: --listen-port
  - id: load_cookies
    type:
      - 'null'
      - File
    doc: Load Cookies from FILE using the Firefox3 format and Mozilla/Firefox/Netscape
      format.
    inputBinding:
      position: 102
      prefix: --load-cookies
  - id: log
    type:
      - 'null'
      - File
    doc: The file name of the log file. If '-' is specified, log is written to stdout.
    inputBinding:
      position: 102
      prefix: --log
  - id: max_concurrent_downloads
    type:
      - 'null'
      - int
    doc: Set maximum number of parallel downloads for every static (HTTP/FTP) URL,
      torrent and metalink.
    default: 5
    inputBinding:
      position: 102
      prefix: --max-concurrent-downloads
  - id: max_connection_per_server
    type:
      - 'null'
      - int
    doc: The maximum number of connections to one server for each download.
    default: 1
    inputBinding:
      position: 102
      prefix: --max-connection-per-server
  - id: max_overall_upload_limit
    type:
      - 'null'
      - string
    doc: Set max overall upload speed in bytes/sec. 0 means unrestricted. You can
      append K or M.
    default: '0'
    inputBinding:
      position: 102
      prefix: --max-overall-upload-limit
  - id: max_upload_limit
    type:
      - 'null'
      - string
    doc: Set max upload speed per each torrent in bytes/sec. 0 means unrestricted.
      You can append K or M.
    default: '0'
    inputBinding:
      position: 102
      prefix: --max-upload-limit
  - id: metalink_file
    type:
      - 'null'
      - File
    doc: The file path to the .meta4 and .metalink file.
    inputBinding:
      position: 102
      prefix: --metalink-file
  - id: min_split_size
    type:
      - 'null'
      - string
    doc: aria2 does not split less than 2*SIZE byte range. You can append K or M.
    default: 20M
    inputBinding:
      position: 102
      prefix: --min-split-size
  - id: show_files
    type:
      - 'null'
      - boolean
    doc: Print file listing of .torrent, .meta4 and .metalink file and exit.
    default: false
    inputBinding:
      position: 102
      prefix: --show-files
  - id: split
    type:
      - 'null'
      - int
    doc: Download a file using N connections.
    default: 5
    inputBinding:
      position: 102
      prefix: --split
  - id: torrent_file
    type:
      - 'null'
      - File
    doc: The path to the .torrent file.
    inputBinding:
      position: 102
      prefix: --torrent-file
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: The file name of the downloaded file. It is always relative to the directory
      given in -d option.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aria2:1.36.0
