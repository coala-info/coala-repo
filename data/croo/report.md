# croo CWL Generation Report

## croo

### Tool Description
Path, URL or URI for metadata.json for a workflow

### Metadata
- **Docker Image**: quay.io/biocontainers/croo:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/ENCODE-DCC/croo
- **Package**: https://anaconda.org/channels/bioconda/packages/croo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/croo/overview
- **Total Downloads**: 26.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ENCODE-DCC/croo
- **Stars**: N/A
### Original Help Text
```text
usage: croo [-h] [--out-def-json OUT_DEF_JSON] [--method {link,copy}]
            [--ucsc-genome-db UCSC_GENOME_DB]
            [--ucsc-genome-pos UCSC_GENOME_POS] [--public-gcs]
            [--use-presigned-url-s3] [--use-presigned-url-gcs]
            [--gcp-private-key GCP_PRIVATE_KEY]
            [--duration-presigned-url-s3 DURATION_PRESIGNED_URL_S3]
            [--duration-presigned-url-gcs DURATION_PRESIGNED_URL_GCS]
            [--tsv-mapping-path-to-url TSV_MAPPING_PATH_TO_URL]
            [--out-dir OUT_DIR] [--tmp-dir TMP_DIR] [--use-gsutil-for-s3]
            [--no-checksum] [-v] [-D]
            metadata_json

positional arguments:
  metadata_json         Path, URL or URI for metadata.json for a workflow
                        Example: /scratch/sample1/metadata.json,
                        gs://some/where/metadata.json,
                        http://hello.com/world/metadata.json

optional arguments:
  -h, --help            show this help message and exit
  --out-def-json OUT_DEF_JSON
                        Output definition JSON file for a WDL file
                        corresponding to the specified metadata.json file
  --method {link,copy}  Method to localize files on output directory/bucket.
                        "link" means a soft-linking and it's for local
                        directory only. Original output files will be kept in
                        Cromwell's output directory. "copy" makes copies of
                        Cromwell's original outputs
  --ucsc-genome-db UCSC_GENOME_DB
                        UCSC genome browser's "db=" parameter. (e.g. hg38 for
                        GRCh38 and mm10 for mm10)
  --ucsc-genome-pos UCSC_GENOME_POS
                        UCSC genome browser's "position=" parameter. (e.g.
                        chr1:35000-40000)
  --public-gcs          Your GCS (gs://) bucket is public.
  --use-presigned-url-s3
                        Generate presigned URLS for files on s3://.
  --use-presigned-url-gcs
                        Generate presigned URLS for files on gs://. --gcp-
                        private-key must be provided.
  --gcp-private-key GCP_PRIVATE_KEY
                        Private key file (JSON/PKCS12) of a service account on
                        Google Cloud Platform (GCP). This key will be used to
                        make presigned URLs on files on gs://.
  --duration-presigned-url-s3 DURATION_PRESIGNED_URL_S3
                        Duration for presigned URLs for files on s3:// in
                        seconds.
  --duration-presigned-url-gcs DURATION_PRESIGNED_URL_GCS
                        Duration for presigned URLs for files on gs:// in
                        seconds.
  --tsv-mapping-path-to-url TSV_MAPPING_PATH_TO_URL
                        A 2-column TSV file with local path prefix and
                        corresponding URL prefix. For example, using 1-line
                        2-col TSV file with /var/www[TAB]http://my.server.com
                        will replace a local path /var/www/here/a.txt to a URL
                        http://my.server.com/here/a.txt.
  --out-dir OUT_DIR     Output directory/bucket (LOCAL OR REMOTE). This can be
                        a local path, gs:// or s3://.
  --tmp-dir TMP_DIR     LOCAL temporary cache directory. All temporary files
                        for auto-inter-storage transfer will be stored here.
                        You can clean it up but will lose all cached files so
                        that remote files will be re-downloaded.
  --use-gsutil-for-s3   Use gsutil for direct tranfer between GCS and S3
                        buckets. Make sure that you have "gsutil" installed
                        and configured to have access to credentials for GCS
                        and S3 (e.g. ~/.boto or ~/.aws/credientials)
  --no-checksum         Always overwrite on output directory/bucket (--out-
                        dir) even if md5-identical files (or soft links)
                        already exist there. Md5 hash/filename/filesize
                        checking will be skipped.
  -v, --version         Show version
  -D, --debug           Prints all logs >= DEBUG level
```

