# perl-json-xs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-json-xs | PASS | cbor output fails because the optional CBOR::XS module is not in the image; json and dumper work |

## perl-json-xs

### Tool Description
The provided text is a Docker error message indicating a failure to pull the image due to lack of disk space. No help text or usage information was found in the input. Below is the standard structure for the 'json_xs' utility typically associated with this package.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-json-xs:4.04--pl5321h9948957_0
- **Homepage**: https://metacpan.org/pod/JSON::XS
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-json-xs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-json-xs/overview
- **Total Downloads**: 1.6M
- **Last updated**: 2025-09-08
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/perl-json-xs:4.04--pl5321h9948957_0' locally
4.04--pl5321h9948957_0: Pulling from biocontainers/perl-json-xs
0cacab098358: Already exists
bd9ddc54bea9: Already exists
7ab2963f8f36: Pulling fs layer
docker: write /var/lib/docker/tmp/GetImageBlob1124173874: no space left on device

Run 'docker run --help' for more information
```

