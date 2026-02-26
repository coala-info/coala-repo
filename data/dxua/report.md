# dxua CWL Generation Report

## dxua

### Tool Description
Upload files to the platform.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxua:1.5.31--0
- **Homepage**: https://documentation.dnanexus.com/user/objects/uploading-and-downloading-files/batch/upload-agent
- **Package**: https://anaconda.org/channels/bioconda/packages/dxua/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxua/overview
- **Total Downloads**: 15.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Error processing arguments: unrecognised option '-help'

Usage: dxua [options] <file> [...]

Available options:
  -h [ --help ]                      Produce a help message
  --version                          Print the version
  -e [ --env ]                       Print environment information
  -a [ --auth-token ] arg            Specify the authentication token
  -p [ --project ] arg               Name or ID of the destination project
  -f [ --folder ] arg (=/)           Name of the destination folder
  -n [ --name ] arg                  Name of the remote file (Note: Extension 
                                     ".gz" will be appended if the file is 
                                     compressed before uploading)
  --visibility arg (=visible)        Use "--visibility hidden" to set the 
                                     file's visibility as hidden.
  --property arg                     Key-value pair to add as a property; 
                                     repeat as necessary, e.g. "--property 
                                     key1=val1 --property key2=val2"
  --type arg                         Type of the data object; repeat as 
                                     necessary, e.g. "--type type1 --type 
                                     type2"
  --tag arg                          Tag of the data object; repeat as 
                                     necessary, e.g. "--tag tag1 --tag tag2"
  --details arg                      JSON to store as details
  --recursive                        Recursively upload the directories
  --read-threads arg (=2)            Number of parallel disk read threads
  -c [ --compress-threads ] arg (=8) Number of parallel compression threads
  -u [ --upload-threads ] arg (=8)   Number of parallel upload threads
  -s [ --chunk-size ] arg (=75M)     Size of chunks in which the file should be
                                     uploaded. Specify an integer size in bytes
                                     or append optional units (B, K, M, G). 
                                     E.g., '50M' sets chunk size to 50 
                                     megabytes.
  --throttle arg                     Limit maximum upload speed. Specify an 
                                     integer to set speed in bytes/second or 
                                     append optional units (B, K, M, G). E.g., 
                                     '3M' limits upload speed to 3 
                                     megabytes/second. If not set, uploads are 
                                     not throttled.
  -r [ --tries ] arg (=3)            Number of tries to upload each chunk
  --do-not-compress                  Do not compress file(s) before upload
  -g [ --progress ]                  Report upload progress
  -v [ --verbose ]                   Verbose logging
  --wait-on-close                    Wait for file objects to be closed before 
                                     exiting
  --do-not-resume                    Do not attempt to resume any incomplete 
                                     uploads
  --test                             Test upload agent settings
  -i [ --read-from-stdin ]           Read file content from stdin
```

