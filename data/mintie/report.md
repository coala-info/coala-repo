# mintie CWL Generation Report

## mintie_run

### Tool Description
bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Oshlack/MINTIE
- **Stars**: N/A
### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_test

### Tool Description
Manage and execute bpipe pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_debug

### Tool Description
bpipe is a build and automation tool for bioinformatics pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_touch

### Tool Description
Manage and execute pipelines

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_execute

### Tool Description
Manage and execute Bpipe pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_retry

### Tool Description
bpipe is a build and deployment tool for bioinformatics pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_remake

### Tool Description
Remake files

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_resume

### Tool Description
Manage and execute pipelines

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_stop

### Tool Description
bpipe is a build and deployment tool for bioinformatics pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_history

### Tool Description
Manage and execute pipelines

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_log

### Tool Description
bpipe is a build and automation tool for bioinformatics pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_jobs

### Tool Description
Manage and execute pipelines

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_checks

### Tool Description
bpipe is a build and deployment tool for bioinformatics pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_override

### Tool Description
Manage and execute Bpipe pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_status

### Tool Description
Manage and execute pipelines

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_cleanup

### Tool Description
Cleanup internal files

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_query

### Tool Description
bpipe is a build and automation tool for bioinformatics pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_preallocate

### Tool Description
Manage and execute Bpipe pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_archive

### Tool Description
bpipe is a build and deployment tool for complex software projects.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_autoarchive

### Tool Description
Manage and execute pipelines

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_preserve

### Tool Description
Manage and execute pipelines

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_register

### Tool Description
bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_diagram

### Tool Description
bpipe is a build and automation tool for bioinformatics pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## mintie_diagrameditor

### Tool Description
Diagram editor for a bpipe pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command @ or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## Metadata
- **Skill**: generated
