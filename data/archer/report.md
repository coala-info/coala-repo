# archer CWL Generation Report

## archer_launch

### Tool Description
Launch the Archer service. This will start a gRPC server running that will accept incoming Process and Watch requests. It will offer the Archer API for filtering, compressing and uploading ARTIC reads to an S3 endpoint.

### Metadata
- **Docker Image**: quay.io/biocontainers/archer:0.1.1--he881be0_0
- **Homepage**: https://github.com/will-rowe/archer
- **Package**: https://anaconda.org/channels/bioconda/packages/archer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/archer/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/will-rowe/archer
- **Stars**: N/A
### Original Help Text
```text
Launch the Archer service.
	
	This will start a gRPC server running that will
	accept incoming Process and Watch requests. It
	will offer the Archer API for filtering, compressing
	and uploading ARTIC reads to an S3 endpoint.

Usage:
  archer launch [flags]

Flags:
      --awsBucketName string   the AWS S3 bucket name for data upload (default "artic-archer-uploads-test")
      --awsRegion string       the AWS region to use (default "eu-west-2")
      --dbPath string          location to store the Archer database (default "/user/qianghu/.archer")
      --grpcAddress string     address to announce on (default "localhost")
      --grpcPort string        TCP port to listen to by the gRPC server (default "9090")
  -h, --help                   help for launch
  -l, --logFile string         where to write the server log (if unset, STDERR used)
      --manifestURL string     the ARTIC primer scheme manifest url (default "https://raw.githubusercontent.com/artic-network/primer-schemes/master/schemes_manifest.json")
  -p, --numProcessors int      number of processors to use (-1 == all) (default -1)
      --numWorkers int         number of concurrent request handlers to use (default 2)
```


## archer_process

### Tool Description
Add a sample to the processing queue. The processing request is collected via STDIN and should be in JSON. The request will be validated prior to submitting it to the Archer service.

### Metadata
- **Docker Image**: quay.io/biocontainers/archer:0.1.1--he881be0_0
- **Homepage**: https://github.com/will-rowe/archer
- **Package**: https://anaconda.org/channels/bioconda/packages/archer/overview
- **Validation**: PASS

### Original Help Text
```text
Add a sample to the processing queue.
	
	The processing request is collecting via STDIN and should be
	in JSON. The request will be validated prior to submitting it
	to the Archer service, so check the response.
	
	Example usage:

	cat sample.json | archer process

	Where sample.json contains:

	{
		"apiVersion": "1",
		"sampleID": "cvr1",
		"inputFASTQfiles": ["/path/to/sample.fastq"],
		"scheme": "scov2",
		"schemeVersion": 3
	}

	For scheme and schemeVersion, these must be available in the
	manifest provided to the server (archer launch --manifestURL ...).
	By default, the server uses the ARTIC primer scheme manifest.

Usage:
  archer process [flags]

Flags:
      --grpcAddress string   address of the server hosting the Archer service (default "localhost")
      --grpcPort string      TCP port to listen to by the gRPC server (default "9090")
  -h, --help                 help for process
```


## archer_watch

### Tool Description
Watch a running Archer service. This command will start a gRPC message stream and print samples that have completed processing. It will include sample name, amplicon coverage, S3 location and processing time.

### Metadata
- **Docker Image**: quay.io/biocontainers/archer:0.1.1--he881be0_0
- **Homepage**: https://github.com/will-rowe/archer
- **Package**: https://anaconda.org/channels/bioconda/packages/archer/overview
- **Validation**: PASS

### Original Help Text
```text
Watch a running Archer service.
	
	This command will start a gRPC message stream and 
	print samples that have completed processing. It 
	will include sample name, amplicon coverage, S3
	location and processing time.

Usage:
  archer watch [flags]

Flags:
      --grpcAddress string   address of the server hosting the Archer service (default "localhost")
      --grpcPort string      TCP port to listen to by the gRPC server (default "9090")
  -h, --help                 help for watch
```


## Metadata
- **Skill**: generated
