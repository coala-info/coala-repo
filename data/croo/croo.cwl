cwlVersion: v1.2
class: CommandLineTool
baseCommand: croo
label: croo
doc: "Path, URL or URI for metadata.json for a workflow\n\nTool homepage: https://github.com/ENCODE-DCC/croo"
inputs:
  - id: metadata_json
    type: string
    doc: "Path, URL or URI for metadata.json for a workflow\n                    \
      \    Example: /scratch/sample1/metadata.json,\n                        gs://some/where/metadata.json,\n\
      \                        http://hello.com/world/metadata.json"
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Prints all logs >= DEBUG level
    inputBinding:
      position: 102
      prefix: --debug
  - id: duration_presigned_url_gcs
    type:
      - 'null'
      - int
    doc: "Duration for presigned URLs for files on gs:// in\n                    \
      \    seconds."
    inputBinding:
      position: 102
      prefix: --duration-presigned-url-gcs
  - id: duration_presigned_url_s3
    type:
      - 'null'
      - int
    doc: "Duration for presigned URLs for files on s3:// in\n                    \
      \    seconds."
    inputBinding:
      position: 102
      prefix: --duration-presigned-url-s3
  - id: gcp_private_key
    type:
      - 'null'
      - File
    doc: "Private key file (JSON/PKCS12) of a service account on\n               \
      \         Google Cloud Platform (GCP). This key will be used to\n          \
      \              make presigned URLs on files on gs://."
    inputBinding:
      position: 102
      prefix: --gcp-private-key
  - id: method
    type:
      - 'null'
      - string
    doc: "Method to localize files on output directory/bucket.\n                 \
      \       \"link\" means a soft-linking and it's for local\n                 \
      \       directory only. Original output files will be kept in\n            \
      \            Cromwell's output directory. \"copy\" makes copies of\n       \
      \                 Cromwell's original outputs"
    inputBinding:
      position: 102
      prefix: --method
  - id: no_checksum
    type:
      - 'null'
      - boolean
    doc: "Always overwrite on output directory/bucket (--out-\n                  \
      \      dir) even if md5-identical files (or soft links)\n                  \
      \      already exist there. Md5 hash/filename/filesize\n                   \
      \     checking will be skipped."
    inputBinding:
      position: 102
      prefix: --no-checksum
  - id: out_def_json
    type:
      - 'null'
      - File
    doc: "Output definition JSON file for a WDL file\n                        corresponding
      to the specified metadata.json file"
    inputBinding:
      position: 102
      prefix: --out-def-json
  - id: public_gcs
    type:
      - 'null'
      - boolean
    doc: Your GCS (gs://) bucket is public.
    inputBinding:
      position: 102
      prefix: --public-gcs
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: "LOCAL temporary cache directory. All temporary files\n                 \
      \       for auto-inter-storage transfer will be stored here.\n             \
      \           You can clean it up but will lose all cached files so\n        \
      \                that remote files will be re-downloaded."
    inputBinding:
      position: 102
      prefix: --tmp-dir
  - id: tsv_mapping_path_to_url
    type:
      - 'null'
      - File
    doc: "A 2-column TSV file with local path prefix and\n                       \
      \ corresponding URL prefix. For example, using 1-line\n                    \
      \    2-col TSV file with /var/www[TAB]http://my.server.com\n               \
      \         will replace a local path /var/www/here/a.txt to a URL\n         \
      \               http://my.server.com/here/a.txt."
    inputBinding:
      position: 102
      prefix: --tsv-mapping-path-to-url
  - id: ucsc_genome_db
    type:
      - 'null'
      - string
    doc: "UCSC genome browser's \"db=\" parameter. (e.g. hg38 for\n              \
      \          GRCh38 and mm10 for mm10)"
    inputBinding:
      position: 102
      prefix: --ucsc-genome-db
  - id: ucsc_genome_pos
    type:
      - 'null'
      - string
    doc: "UCSC genome browser's \"position=\" parameter. (e.g.\n                 \
      \       chr1:35000-40000)"
    inputBinding:
      position: 102
      prefix: --ucsc-genome-pos
  - id: use_gsutil_for_s3
    type:
      - 'null'
      - boolean
    doc: "Use gsutil for direct tranfer between GCS and S3\n                     \
      \   buckets. Make sure that you have \"gsutil\" installed\n                \
      \        and configured to have access to credentials for GCS\n            \
      \            and S3 (e.g. ~/.boto or ~/.aws/credientials)"
    inputBinding:
      position: 102
      prefix: --use-gsutil-for-s3
  - id: use_presigned_url_gcs
    type:
      - 'null'
      - boolean
    doc: "Generate presigned URLS for files on gs://. --gcp-\n                   \
      \     private-key must be provided."
    inputBinding:
      position: 102
      prefix: --use-presigned-url-gcs
  - id: use_presigned_url_s3
    type:
      - 'null'
      - boolean
    doc: Generate presigned URLS for files on s3://.
    inputBinding:
      position: 102
      prefix: --use-presigned-url-s3
outputs:
  - id: out_dir
    type:
      - 'null'
      - File
    doc: "Output directory/bucket (LOCAL OR REMOTE). This can be\n               \
      \         a local path, gs:// or s3://."
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/croo:0.6.0--pyhdfd78af_0
