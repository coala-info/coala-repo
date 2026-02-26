# jpredapi CWL Generation Report

## jpredapi_submit

### Tool Description
jpredapi command-line interface
The JPred API allows users to submit jobs from the command-line.

### Metadata
- **Docker Image**: quay.io/biocontainers/jpredapi:1.5.6--py_0
- **Homepage**: https://github.com/MoseleyBioinformaticsLab/jpredapi
- **Package**: https://anaconda.org/channels/bioconda/packages/jpredapi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jpredapi/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MoseleyBioinformaticsLab/jpredapi
- **Stars**: N/A
### Original Help Text
```text
jpredapi command-line interface

The JPred API allows users to submit jobs from the command-line.

Usage:
    jpredapi submit (--mode=<mode> --format=<format>) (--file=<filename> | --seq=<sequence>) [--email=<name@domain.com>] [--name=<name>] [--rest=<address>] [--skipPDB] [--silent]
    jpredapi status (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi get_results (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi quota (--email=<name@domain.com>) [--rest=<address>] [--silent]
    jpredapi check_rest_version [--rest=<address>] [--silent]
    jpredapi -h | --help
    jpredapi -v | --version

Options:
    -h, --help                 Show this help message.
    -v, --version              Show jpredapi package version.
    --silent                   Do not print messages.
    --extract                  Extract results tar.gz archive.
    --skipPDB                  PDB check.
    --mode=<mode>              Submission mode, possible values: single, batch, msa.
    --format=<format>          Submission format, possible values: raw, fasta, msf, blc.
    --file=<filename>          Filename of a file with the job input (sequence(s)).
    --seq=<sequence>           Instead of passing input file, for single-sequence submission.
    --email=<name@domain.com>  E-mail address where job report will be sent (optional for all but batch submissions).
    --name=<name>              Job name.
    --jobid=<id>               Job id.
    --results=<path>           Path to directory where to save archive with results.
    --rest=<address>           REST address of server [default: http://www.compbio.dundee.ac.uk/jpred4/cgi-bin/rest].
    --jpred4=<address>         Address of Jpred4 server [default: http://www.compbio.dundee.ac.uk/jpred4].
    --wait=<interval>          Wait interval before retrying to check job status in seconds [default: 60].
    --attempts=<max>           Maximum number of attempts to check job status [default: 10].
```


## jpredapi_status

### Tool Description
The JPred API allows users to submit jobs from the command-line.

### Metadata
- **Docker Image**: quay.io/biocontainers/jpredapi:1.5.6--py_0
- **Homepage**: https://github.com/MoseleyBioinformaticsLab/jpredapi
- **Package**: https://anaconda.org/channels/bioconda/packages/jpredapi/overview
- **Validation**: PASS

### Original Help Text
```text
jpredapi command-line interface

The JPred API allows users to submit jobs from the command-line.

Usage:
    jpredapi submit (--mode=<mode> --format=<format>) (--file=<filename> | --seq=<sequence>) [--email=<name@domain.com>] [--name=<name>] [--rest=<address>] [--skipPDB] [--silent]
    jpredapi status (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi get_results (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi quota (--email=<name@domain.com>) [--rest=<address>] [--silent]
    jpredapi check_rest_version [--rest=<address>] [--silent]
    jpredapi -h | --help
    jpredapi -v | --version

Options:
    -h, --help                 Show this help message.
    -v, --version              Show jpredapi package version.
    --silent                   Do not print messages.
    --extract                  Extract results tar.gz archive.
    --skipPDB                  PDB check.
    --mode=<mode>              Submission mode, possible values: single, batch, msa.
    --format=<format>          Submission format, possible values: raw, fasta, msf, blc.
    --file=<filename>          Filename of a file with the job input (sequence(s)).
    --seq=<sequence>           Instead of passing input file, for single-sequence submission.
    --email=<name@domain.com>  E-mail address where job report will be sent (optional for all but batch submissions).
    --name=<name>              Job name.
    --jobid=<id>               Job id.
    --results=<path>           Path to directory where to save archive with results.
    --rest=<address>           REST address of server [default: http://www.compbio.dundee.ac.uk/jpred4/cgi-bin/rest].
    --jpred4=<address>         Address of Jpred4 server [default: http://www.compbio.dundee.ac.uk/jpred4].
    --wait=<interval>          Wait interval before retrying to check job status in seconds [default: 60].
    --attempts=<max>           Maximum number of attempts to check job status [default: 10].
```


## jpredapi_get_results

### Tool Description
Retrieves the results of a JPred API job.

### Metadata
- **Docker Image**: quay.io/biocontainers/jpredapi:1.5.6--py_0
- **Homepage**: https://github.com/MoseleyBioinformaticsLab/jpredapi
- **Package**: https://anaconda.org/channels/bioconda/packages/jpredapi/overview
- **Validation**: PASS

### Original Help Text
```text
jpredapi command-line interface

The JPred API allows users to submit jobs from the command-line.

Usage:
    jpredapi submit (--mode=<mode> --format=<format>) (--file=<filename> | --seq=<sequence>) [--email=<name@domain.com>] [--name=<name>] [--rest=<address>] [--skipPDB] [--silent]
    jpredapi status (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi get_results (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi quota (--email=<name@domain.com>) [--rest=<address>] [--silent]
    jpredapi check_rest_version [--rest=<address>] [--silent]
    jpredapi -h | --help
    jpredapi -v | --version

Options:
    -h, --help                 Show this help message.
    -v, --version              Show jpredapi package version.
    --silent                   Do not print messages.
    --extract                  Extract results tar.gz archive.
    --skipPDB                  PDB check.
    --mode=<mode>              Submission mode, possible values: single, batch, msa.
    --format=<format>          Submission format, possible values: raw, fasta, msf, blc.
    --file=<filename>          Filename of a file with the job input (sequence(s)).
    --seq=<sequence>           Instead of passing input file, for single-sequence submission.
    --email=<name@domain.com>  E-mail address where job report will be sent (optional for all but batch submissions).
    --name=<name>              Job name.
    --jobid=<id>               Job id.
    --results=<path>           Path to directory where to save archive with results.
    --rest=<address>           REST address of server [default: http://www.compbio.dundee.ac.uk/jpred4/cgi-bin/rest].
    --jpred4=<address>         Address of Jpred4 server [default: http://www.compbio.dundee.ac.uk/jpred4].
    --wait=<interval>          Wait interval before retrying to check job status in seconds [default: 60].
    --attempts=<max>           Maximum number of attempts to check job status [default: 10].
```


## jpredapi_quota

### Tool Description
Check your JPred API quota

### Metadata
- **Docker Image**: quay.io/biocontainers/jpredapi:1.5.6--py_0
- **Homepage**: https://github.com/MoseleyBioinformaticsLab/jpredapi
- **Package**: https://anaconda.org/channels/bioconda/packages/jpredapi/overview
- **Validation**: PASS

### Original Help Text
```text
jpredapi command-line interface

The JPred API allows users to submit jobs from the command-line.

Usage:
    jpredapi submit (--mode=<mode> --format=<format>) (--file=<filename> | --seq=<sequence>) [--email=<name@domain.com>] [--name=<name>] [--rest=<address>] [--skipPDB] [--silent]
    jpredapi status (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi get_results (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi quota (--email=<name@domain.com>) [--rest=<address>] [--silent]
    jpredapi check_rest_version [--rest=<address>] [--silent]
    jpredapi -h | --help
    jpredapi -v | --version

Options:
    -h, --help                 Show this help message.
    -v, --version              Show jpredapi package version.
    --silent                   Do not print messages.
    --extract                  Extract results tar.gz archive.
    --skipPDB                  PDB check.
    --mode=<mode>              Submission mode, possible values: single, batch, msa.
    --format=<format>          Submission format, possible values: raw, fasta, msf, blc.
    --file=<filename>          Filename of a file with the job input (sequence(s)).
    --seq=<sequence>           Instead of passing input file, for single-sequence submission.
    --email=<name@domain.com>  E-mail address where job report will be sent (optional for all but batch submissions).
    --name=<name>              Job name.
    --jobid=<id>               Job id.
    --results=<path>           Path to directory where to save archive with results.
    --rest=<address>           REST address of server [default: http://www.compbio.dundee.ac.uk/jpred4/cgi-bin/rest].
    --jpred4=<address>         Address of Jpred4 server [default: http://www.compbio.dundee.ac.uk/jpred4].
    --wait=<interval>          Wait interval before retrying to check job status in seconds [default: 60].
    --attempts=<max>           Maximum number of attempts to check job status [default: 10].
```


## jpredapi_check_rest_version

### Tool Description
Check the version of the REST API.

### Metadata
- **Docker Image**: quay.io/biocontainers/jpredapi:1.5.6--py_0
- **Homepage**: https://github.com/MoseleyBioinformaticsLab/jpredapi
- **Package**: https://anaconda.org/channels/bioconda/packages/jpredapi/overview
- **Validation**: PASS

### Original Help Text
```text
jpredapi command-line interface

The JPred API allows users to submit jobs from the command-line.

Usage:
    jpredapi submit (--mode=<mode> --format=<format>) (--file=<filename> | --seq=<sequence>) [--email=<name@domain.com>] [--name=<name>] [--rest=<address>] [--skipPDB] [--silent]
    jpredapi status (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi get_results (--jobid=<id>) [--results=<path>] [--wait=<interval>] [--attempts=<max>] [--rest=<address>] [--jpred4=<address>] [--extract] [--silent]
    jpredapi quota (--email=<name@domain.com>) [--rest=<address>] [--silent]
    jpredapi check_rest_version [--rest=<address>] [--silent]
    jpredapi -h | --help
    jpredapi -v | --version

Options:
    -h, --help                 Show this help message.
    -v, --version              Show jpredapi package version.
    --silent                   Do not print messages.
    --extract                  Extract results tar.gz archive.
    --skipPDB                  PDB check.
    --mode=<mode>              Submission mode, possible values: single, batch, msa.
    --format=<format>          Submission format, possible values: raw, fasta, msf, blc.
    --file=<filename>          Filename of a file with the job input (sequence(s)).
    --seq=<sequence>           Instead of passing input file, for single-sequence submission.
    --email=<name@domain.com>  E-mail address where job report will be sent (optional for all but batch submissions).
    --name=<name>              Job name.
    --jobid=<id>               Job id.
    --results=<path>           Path to directory where to save archive with results.
    --rest=<address>           REST address of server [default: http://www.compbio.dundee.ac.uk/jpred4/cgi-bin/rest].
    --jpred4=<address>         Address of Jpred4 server [default: http://www.compbio.dundee.ac.uk/jpred4].
    --wait=<interval>          Wait interval before retrying to check job status in seconds [default: 60].
    --attempts=<max>           Maximum number of attempts to check job status [default: 10].
```


## Metadata
- **Skill**: generated
