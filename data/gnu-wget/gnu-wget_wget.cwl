cwlVersion: v1.2
class: CommandLineTool
baseCommand: wget
label: gnu-wget_wget
doc: "GNU Wget 1.18, a non-interactive network retriever.\n\nTool homepage: https://github.com/darnir/wget"
inputs:
  - id: urls
    type:
      type: array
      items: string
    doc: URLs to download
    inputBinding:
      position: 1
  - id: accept
    type:
      - 'null'
      - string
    doc: comma-separated list of accepted extensions
    inputBinding:
      position: 102
      prefix: --accept
  - id: accept_regex
    type:
      - 'null'
      - string
    doc: regex matching accepted URLs
    inputBinding:
      position: 102
      prefix: --accept-regex
  - id: adjust_extension
    type:
      - 'null'
      - boolean
    doc: save HTML/CSS documents with proper extensions
    inputBinding:
      position: 102
      prefix: --adjust-extension
  - id: append_output
    type:
      - 'null'
      - File
    doc: append messages to FILE
    inputBinding:
      position: 102
      prefix: --append-output
  - id: ask_password
    type:
      - 'null'
      - boolean
    doc: prompt for passwords
    inputBinding:
      position: 102
      prefix: --ask-password
  - id: auth_no_challenge
    type:
      - 'null'
      - boolean
    doc: send Basic HTTP authentication information without first waiting for 
      the server's challenge
    inputBinding:
      position: 102
      prefix: --auth-no-challenge
  - id: background
    type:
      - 'null'
      - boolean
    doc: go to background after startup
    inputBinding:
      position: 102
      prefix: --background
  - id: backup_converted
    type:
      - 'null'
      - boolean
    doc: before converting file X, back up as X.orig
    inputBinding:
      position: 102
      prefix: --backup-converted
  - id: backups
    type:
      - 'null'
      - int
    doc: before writing file X, rotate up to N backup files
    inputBinding:
      position: 102
      prefix: --backups
  - id: base
    type:
      - 'null'
      - string
    doc: resolves HTML input-file links (-i -F) relative to URL
    inputBinding:
      position: 102
      prefix: --base
  - id: bind_address
    type:
      - 'null'
      - string
    doc: bind to ADDRESS (hostname or IP) on local host
    inputBinding:
      position: 102
      prefix: --bind-address
  - id: body_data
    type:
      - 'null'
      - string
    doc: send STRING as data. --method MUST be set
    inputBinding:
      position: 102
      prefix: --body-data
  - id: body_file
    type:
      - 'null'
      - File
    doc: send contents of FILE. --method MUST be set
    inputBinding:
      position: 102
      prefix: --body-file
  - id: ca_certificate
    type:
      - 'null'
      - File
    doc: file with the bundle of CAs
    inputBinding:
      position: 102
      prefix: --ca-certificate
  - id: ca_directory
    type:
      - 'null'
      - Directory
    doc: directory where hash list of CAs is stored
    inputBinding:
      position: 102
      prefix: --ca-directory
  - id: certificate
    type:
      - 'null'
      - File
    doc: client certificate file
    inputBinding:
      position: 102
      prefix: --certificate
  - id: certificate_type
    type:
      - 'null'
      - string
    doc: client certificate type, PEM or DER
    inputBinding:
      position: 102
      prefix: --certificate-type
  - id: config
    type:
      - 'null'
      - File
    doc: specify config file to use
    inputBinding:
      position: 102
      prefix: --config
  - id: connect_timeout
    type:
      - 'null'
      - int
    doc: set the connect timeout to SECS
    inputBinding:
      position: 102
      prefix: --connect-timeout
  - id: content_disposition
    type:
      - 'null'
      - boolean
    doc: honor the Content-Disposition header when choosing local file names 
      (EXPERIMENTAL)
    inputBinding:
      position: 102
      prefix: --content-disposition
  - id: content_on_error
    type:
      - 'null'
      - boolean
    doc: output the received content on server errors
    inputBinding:
      position: 102
      prefix: --content-on-error
  - id: continue
    type:
      - 'null'
      - boolean
    doc: resume getting a partially-downloaded file
    inputBinding:
      position: 102
      prefix: --continue
  - id: convert_file_only
    type:
      - 'null'
      - boolean
    doc: convert the file part of the URLs only (usually known as the basename)
    inputBinding:
      position: 102
      prefix: --convert-file-only
  - id: convert_links
    type:
      - 'null'
      - boolean
    doc: make links in downloaded HTML or CSS point to local files
    inputBinding:
      position: 102
      prefix: --convert-links
  - id: crl_file
    type:
      - 'null'
      - File
    doc: file with bundle of CRLs
    inputBinding:
      position: 102
      prefix: --crl-file
  - id: cut_dirs
    type:
      - 'null'
      - int
    doc: ignore NUMBER remote directory components
    inputBinding:
      position: 102
      prefix: --cut-dirs
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print lots of debugging information
    inputBinding:
      position: 102
      prefix: --debug
  - id: default_page
    type:
      - 'null'
      - string
    doc: change the default page name (normally this is 'index.html'.)
    inputBinding:
      position: 102
      prefix: --default-page
  - id: delete_after
    type:
      - 'null'
      - boolean
    doc: delete files locally after downloading them
    inputBinding:
      position: 102
      prefix: --delete-after
  - id: directory_prefix
    type:
      - 'null'
      - Directory
    doc: save files to PREFIX/..
    inputBinding:
      position: 102
      prefix: --directory-prefix
  - id: dns_timeout
    type:
      - 'null'
      - int
    doc: set the DNS lookup timeout to SECS
    inputBinding:
      position: 102
      prefix: --dns-timeout
  - id: domains
    type:
      - 'null'
      - string
    doc: comma-separated list of accepted domains
    inputBinding:
      position: 102
      prefix: --domains
  - id: egd_file
    type:
      - 'null'
      - File
    doc: file naming the EGD socket with random data
    inputBinding:
      position: 102
      prefix: --egd-file
  - id: exclude_directories
    type:
      - 'null'
      - string
    doc: list of excluded directories
    inputBinding:
      position: 102
      prefix: --exclude-directories
  - id: exclude_domains
    type:
      - 'null'
      - string
    doc: comma-separated list of rejected domains
    inputBinding:
      position: 102
      prefix: --exclude-domains
  - id: execute
    type:
      - 'null'
      - string
    doc: execute a `.wgetrc'-style command
    inputBinding:
      position: 102
      prefix: --execute
  - id: follow_ftp
    type:
      - 'null'
      - boolean
    doc: follow FTP links from HTML documents
    inputBinding:
      position: 102
      prefix: --follow-ftp
  - id: follow_tags
    type:
      - 'null'
      - string
    doc: comma-separated list of followed HTML tags
    inputBinding:
      position: 102
      prefix: --follow-tags
  - id: force_directories
    type:
      - 'null'
      - boolean
    doc: force creation of directories
    inputBinding:
      position: 102
      prefix: --force-directories
  - id: force_html
    type:
      - 'null'
      - boolean
    doc: treat input file as HTML
    inputBinding:
      position: 102
      prefix: --force-html
  - id: ftp_password
    type:
      - 'null'
      - string
    doc: set ftp password to PASS
    inputBinding:
      position: 102
      prefix: --ftp-password
  - id: ftp_user
    type:
      - 'null'
      - string
    doc: set ftp user to USER
    inputBinding:
      position: 102
      prefix: --ftp-user
  - id: ftps_clear_data_connection
    type:
      - 'null'
      - boolean
    doc: cipher the control channel only; all the data will be in plaintext
    inputBinding:
      position: 102
      prefix: --ftps-clear-data-connection
  - id: ftps_fallback_to_ftp
    type:
      - 'null'
      - boolean
    doc: fall back to FTP if FTPS is not supported in the target server
    inputBinding:
      position: 102
      prefix: --ftps-fallback-to-ftp
  - id: ftps_implicit
    type:
      - 'null'
      - boolean
    doc: use implicit FTPS (default port is 990)
    inputBinding:
      position: 102
      prefix: --ftps-implicit
  - id: ftps_resume_ssl
    type:
      - 'null'
      - boolean
    doc: resume the SSL/TLS session started in the control connection when 
      opening a data connection
    inputBinding:
      position: 102
      prefix: --ftps-resume-ssl
  - id: header
    type:
      - 'null'
      - string
    doc: insert STRING among the headers
    inputBinding:
      position: 102
      prefix: --header
  - id: hsts_file
    type:
      - 'null'
      - File
    doc: path of HSTS database (will override default)
    inputBinding:
      position: 102
      prefix: --hsts-file
  - id: http_password
    type:
      - 'null'
      - string
    doc: set http password to PASS
    inputBinding:
      position: 102
      prefix: --http-password
  - id: http_user
    type:
      - 'null'
      - string
    doc: set http user to USER
    inputBinding:
      position: 102
      prefix: --http-user
  - id: https_only
    type:
      - 'null'
      - boolean
    doc: only follow secure HTTPS links
    inputBinding:
      position: 102
      prefix: --https-only
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore case when matching files/directories
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: ignore_length
    type:
      - 'null'
      - boolean
    doc: ignore 'Content-Length' header field
    inputBinding:
      position: 102
      prefix: --ignore-length
  - id: ignore_tags
    type:
      - 'null'
      - string
    doc: comma-separated list of ignored HTML tags
    inputBinding:
      position: 102
      prefix: --ignore-tags
  - id: include_directories
    type:
      - 'null'
      - string
    doc: list of allowed directories
    inputBinding:
      position: 102
      prefix: --include-directories
  - id: inet4_only
    type:
      - 'null'
      - boolean
    doc: connect only to IPv4 addresses
    inputBinding:
      position: 102
      prefix: --inet4-only
  - id: inet6_only
    type:
      - 'null'
      - boolean
    doc: connect only to IPv6 addresses
    inputBinding:
      position: 102
      prefix: --inet6-only
  - id: input_file
    type:
      - 'null'
      - File
    doc: download URLs found in local or external FILE
    inputBinding:
      position: 102
      prefix: --input-file
  - id: keep_session_cookies
    type:
      - 'null'
      - boolean
    doc: load and save session (non-permanent) cookies
    inputBinding:
      position: 102
      prefix: --keep-session-cookies
  - id: level
    type:
      - 'null'
      - int
    doc: maximum recursion depth (inf or 0 for infinite)
    inputBinding:
      position: 102
      prefix: --level
  - id: limit_rate
    type:
      - 'null'
      - string
    doc: limit download rate to RATE
    inputBinding:
      position: 102
      prefix: --limit-rate
  - id: load_cookies
    type:
      - 'null'
      - File
    doc: load cookies from FILE before session
    inputBinding:
      position: 102
      prefix: --load-cookies
  - id: local_encoding
    type:
      - 'null'
      - string
    doc: use ENC as the local encoding for IRIs
    inputBinding:
      position: 102
      prefix: --local-encoding
  - id: max_redirect
    type:
      - 'null'
      - int
    doc: maximum redirections allowed per page
    inputBinding:
      position: 102
      prefix: --max-redirect
  - id: method
    type:
      - 'null'
      - string
    doc: use method "HTTPMethod" in the request
    inputBinding:
      position: 102
      prefix: --method
  - id: mirror
    type:
      - 'null'
      - boolean
    doc: shortcut for -N -r -l inf --no-remove-listing
    inputBinding:
      position: 102
      prefix: --mirror
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: disallow server-cached data
    inputBinding:
      position: 102
      prefix: --no-cache
  - id: no_check_certificate
    type:
      - 'null'
      - boolean
    doc: don't validate the server's certificate
    inputBinding:
      position: 102
      prefix: --no-check-certificate
  - id: no_clobber
    type:
      - 'null'
      - boolean
    doc: skip downloads that would download to existing files (overwriting them)
    inputBinding:
      position: 102
      prefix: --no-clobber
  - id: no_config
    type:
      - 'null'
      - boolean
    doc: do not read any config file
    inputBinding:
      position: 102
      prefix: --no-config
  - id: no_cookies
    type:
      - 'null'
      - boolean
    doc: don't use cookies
    inputBinding:
      position: 102
      prefix: --no-cookies
  - id: no_directories
    type:
      - 'null'
      - boolean
    doc: don't create directories
    inputBinding:
      position: 102
      prefix: --no-directories
  - id: no_dns_cache
    type:
      - 'null'
      - boolean
    doc: disable caching DNS lookups
    inputBinding:
      position: 102
      prefix: --no-dns-cache
  - id: no_glob
    type:
      - 'null'
      - boolean
    doc: turn off FTP file name globbing
    inputBinding:
      position: 102
      prefix: --no-glob
  - id: no_host_directories
    type:
      - 'null'
      - boolean
    doc: don't create host directories
    inputBinding:
      position: 102
      prefix: --no-host-directories
  - id: no_hsts
    type:
      - 'null'
      - boolean
    doc: disable HSTS
    inputBinding:
      position: 102
      prefix: --no-hsts
  - id: no_http_keep_alive
    type:
      - 'null'
      - boolean
    doc: disable HTTP keep-alive (persistent connections)
    inputBinding:
      position: 102
      prefix: --no-http-keep-alive
  - id: no_if_modified_since
    type:
      - 'null'
      - boolean
    doc: don't use conditional if-modified-since get requests in timestamping 
      mode
    inputBinding:
      position: 102
      prefix: --no-if-modified-since
  - id: no_iri
    type:
      - 'null'
      - boolean
    doc: turn off IRI support
    inputBinding:
      position: 102
      prefix: --no-iri
  - id: no_parent
    type:
      - 'null'
      - boolean
    doc: don't ascend to the parent directory
    inputBinding:
      position: 102
      prefix: --no-parent
  - id: no_passive_ftp
    type:
      - 'null'
      - boolean
    doc: disable the "passive" transfer mode
    inputBinding:
      position: 102
      prefix: --no-passive-ftp
  - id: no_proxy
    type:
      - 'null'
      - boolean
    doc: explicitly turn off proxy
    inputBinding:
      position: 102
      prefix: --no-proxy
  - id: no_remove_listing
    type:
      - 'null'
      - boolean
    doc: don't remove '.listing' files
    inputBinding:
      position: 102
      prefix: --no-remove-listing
  - id: no_use_server_timestamps
    type:
      - 'null'
      - boolean
    doc: don't set the local file's timestamp by the one on the server
    inputBinding:
      position: 102
      prefix: --no-use-server-timestamps
  - id: no_verbose
    type:
      - 'null'
      - boolean
    doc: turn off verboseness, without being quiet
    inputBinding:
      position: 102
      prefix: --no-verbose
  - id: no_warc_compression
    type:
      - 'null'
      - boolean
    doc: do not compress WARC files with GZIP
    inputBinding:
      position: 102
      prefix: --no-warc-compression
  - id: no_warc_digests
    type:
      - 'null'
      - boolean
    doc: do not calculate SHA1 digests
    inputBinding:
      position: 102
      prefix: --no-warc-digests
  - id: no_warc_keep_log
    type:
      - 'null'
      - boolean
    doc: do not store the log file in a WARC record
    inputBinding:
      position: 102
      prefix: --no-warc-keep-log
  - id: output_file
    type:
      - 'null'
      - File
    doc: log messages to FILE
    inputBinding:
      position: 102
      prefix: --output-file
  - id: page_requisites
    type:
      - 'null'
      - boolean
    doc: get all images, etc. needed to display HTML page
    inputBinding:
      position: 102
      prefix: --page-requisites
  - id: password
    type:
      - 'null'
      - string
    doc: set both ftp and http password to PASS
    inputBinding:
      position: 102
      prefix: --password
  - id: pinnedpubkey
    type:
      - 'null'
      - string
    doc: Public key (PEM/DER) file, or any number of base64 encoded sha256 
      hashes preceded by 'sha256//' and seperated by ';', to verify peer against
    inputBinding:
      position: 102
      prefix: --pinnedpubkey
  - id: post_data
    type:
      - 'null'
      - string
    doc: use the POST method; send STRING as the data
    inputBinding:
      position: 102
      prefix: --post-data
  - id: post_file
    type:
      - 'null'
      - File
    doc: use the POST method; send contents of FILE
    inputBinding:
      position: 102
      prefix: --post-file
  - id: prefer_family
    type:
      - 'null'
      - string
    doc: connect first to addresses of specified family, one of IPv6, IPv4, or 
      none
    inputBinding:
      position: 102
      prefix: --prefer-family
  - id: preserve_permissions
    type:
      - 'null'
      - boolean
    doc: preserve remote file permissions
    inputBinding:
      position: 102
      prefix: --preserve-permissions
  - id: private_key
    type:
      - 'null'
      - File
    doc: private key file
    inputBinding:
      position: 102
      prefix: --private-key
  - id: private_key_type
    type:
      - 'null'
      - string
    doc: private key type, PEM or DER
    inputBinding:
      position: 102
      prefix: --private-key-type
  - id: progress
    type:
      - 'null'
      - string
    doc: select progress gauge type
    inputBinding:
      position: 102
      prefix: --progress
  - id: protocol_directories
    type:
      - 'null'
      - boolean
    doc: use protocol name in directories
    inputBinding:
      position: 102
      prefix: --protocol-directories
  - id: proxy_password
    type:
      - 'null'
      - string
    doc: set PASS as proxy password
    inputBinding:
      position: 102
      prefix: --proxy-password
  - id: proxy_user
    type:
      - 'null'
      - string
    doc: set USER as proxy username
    inputBinding:
      position: 102
      prefix: --proxy-user
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet (no output)
    inputBinding:
      position: 102
      prefix: --quiet
  - id: quota
    type:
      - 'null'
      - int
    doc: set retrieval quota to NUMBER
    inputBinding:
      position: 102
      prefix: --quota
  - id: random_file
    type:
      - 'null'
      - File
    doc: file with random data for seeding the SSL PRNG
    inputBinding:
      position: 102
      prefix: --random-file
  - id: random_wait
    type:
      - 'null'
      - boolean
    doc: wait from 0.5*WAIT...1.5*WAIT secs between retrievals
    inputBinding:
      position: 102
      prefix: --random-wait
  - id: read_timeout
    type:
      - 'null'
      - int
    doc: set the read timeout to SECS
    inputBinding:
      position: 102
      prefix: --read-timeout
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: specify recursive download
    inputBinding:
      position: 102
      prefix: --recursive
  - id: referer
    type:
      - 'null'
      - string
    doc: "include 'Referer: URL' header in HTTP request"
    inputBinding:
      position: 102
      prefix: --referer
  - id: regex_type
    type:
      - 'null'
      - string
    doc: regex type (posix)
    inputBinding:
      position: 102
      prefix: --regex-type
  - id: reject
    type:
      - 'null'
      - string
    doc: comma-separated list of rejected extensions
    inputBinding:
      position: 102
      prefix: --reject
  - id: reject_regex
    type:
      - 'null'
      - string
    doc: regex matching rejected URLs
    inputBinding:
      position: 102
      prefix: --reject-regex
  - id: rejected_log
    type:
      - 'null'
      - File
    doc: log reasons for URL rejection to FILE
    inputBinding:
      position: 102
      prefix: --rejected-log
  - id: relative
    type:
      - 'null'
      - boolean
    doc: follow relative links only
    inputBinding:
      position: 102
      prefix: --relative
  - id: remote_encoding
    type:
      - 'null'
      - string
    doc: use ENC as the default remote encoding
    inputBinding:
      position: 102
      prefix: --remote-encoding
  - id: report_speed
    type:
      - 'null'
      - string
    doc: output bandwidth as TYPE. TYPE can be bits
    inputBinding:
      position: 102
      prefix: --report-speed
  - id: restrict_file_names
    type:
      - 'null'
      - string
    doc: restrict chars in file names to ones OS allows
    inputBinding:
      position: 102
      prefix: --restrict-file-names
  - id: retr_symlinks
    type:
      - 'null'
      - boolean
    doc: when recursing, get linked-to files (not dir)
    inputBinding:
      position: 102
      prefix: --retr-symlinks
  - id: retry_connrefused
    type:
      - 'null'
      - boolean
    doc: retry even if connection is refused
    inputBinding:
      position: 102
      prefix: --retry-connrefused
  - id: save_headers
    type:
      - 'null'
      - boolean
    doc: save the HTTP headers to file
    inputBinding:
      position: 102
      prefix: --save-headers
  - id: secure_protocol
    type:
      - 'null'
      - string
    doc: choose secure protocol, one of auto, SSLv2, SSLv3, TLSv1 and PFS
    inputBinding:
      position: 102
      prefix: --secure-protocol
  - id: server_response
    type:
      - 'null'
      - boolean
    doc: print server response
    inputBinding:
      position: 102
      prefix: --server-response
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: display the progress bar in any verbosity mode
    inputBinding:
      position: 102
      prefix: --show-progress
  - id: span_hosts
    type:
      - 'null'
      - boolean
    doc: go to foreign hosts when recursive
    inputBinding:
      position: 102
      prefix: --span-hosts
  - id: spider
    type:
      - 'null'
      - boolean
    doc: don't download anything
    inputBinding:
      position: 102
      prefix: --spider
  - id: start_pos
    type:
      - 'null'
      - int
    doc: start downloading from zero-based position OFFSET
    inputBinding:
      position: 102
      prefix: --start-pos
  - id: strict_comments
    type:
      - 'null'
      - boolean
    doc: turn on strict (SGML) handling of HTML comments
    inputBinding:
      position: 102
      prefix: --strict-comments
  - id: timeout
    type:
      - 'null'
      - int
    doc: set all timeout values to SECONDS
    inputBinding:
      position: 102
      prefix: --timeout
  - id: timestamping
    type:
      - 'null'
      - boolean
    doc: don't re-retrieve files unless newer than local
    inputBinding:
      position: 102
      prefix: --timestamping
  - id: tries
    type:
      - 'null'
      - int
    doc: set number of retries to NUMBER (0 unlimits)
    inputBinding:
      position: 102
      prefix: --tries
  - id: trust_server_names
    type:
      - 'null'
      - boolean
    doc: use the name specified by the redirection URL's last component
    inputBinding:
      position: 102
      prefix: --trust-server-names
  - id: unlink
    type:
      - 'null'
      - boolean
    doc: remove file before clobber
    inputBinding:
      position: 102
      prefix: --unlink
  - id: user
    type:
      - 'null'
      - string
    doc: set both ftp and http user to USER
    inputBinding:
      position: 102
      prefix: --user
  - id: user_agent
    type:
      - 'null'
      - string
    doc: identify as AGENT instead of Wget/VERSION
    inputBinding:
      position: 102
      prefix: --user-agent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose (this is the default)
    inputBinding:
      position: 102
      prefix: --verbose
  - id: wait
    type:
      - 'null'
      - int
    doc: wait SECONDS between retrievals
    inputBinding:
      position: 102
      prefix: --wait
  - id: waitretry
    type:
      - 'null'
      - int
    doc: wait 1..SECONDS between retries of a retrieval
    inputBinding:
      position: 102
      prefix: --waitretry
  - id: warc_cdx
    type:
      - 'null'
      - boolean
    doc: write CDX index files
    inputBinding:
      position: 102
      prefix: --warc-cdx
  - id: warc_dedup
    type:
      - 'null'
      - File
    doc: do not store records listed in this CDX file
    inputBinding:
      position: 102
      prefix: --warc-dedup
  - id: warc_header
    type:
      - 'null'
      - string
    doc: insert STRING into the warcinfo record
    inputBinding:
      position: 102
      prefix: --warc-header
  - id: warc_max_size
    type:
      - 'null'
      - int
    doc: set maximum size of WARC files to NUMBER
    inputBinding:
      position: 102
      prefix: --warc-max-size
  - id: warc_tempdir
    type:
      - 'null'
      - Directory
    doc: location for temporary files created by the WARC writer
    inputBinding:
      position: 102
      prefix: --warc-tempdir
outputs:
  - id: output_document
    type:
      - 'null'
      - File
    doc: write documents to FILE
    outputBinding:
      glob: $(inputs.output_document)
  - id: save_cookies
    type:
      - 'null'
      - File
    doc: save cookies to FILE after session
    outputBinding:
      glob: $(inputs.save_cookies)
  - id: warc_file
    type:
      - 'null'
      - File
    doc: save request/response data to a .warc.gz file
    outputBinding:
      glob: $(inputs.warc_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnu-wget:1.18--hb829ee6_10
