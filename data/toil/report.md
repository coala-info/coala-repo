# toil CWL Generation Report

## toil_clean

### Tool Description
The location of the job store for the workflow. A job store holds persistent information about the jobs, stats, and files in a workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Total Downloads**: 145.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DataBiosphere/toil
- **Stars**: N/A
### Original Help Text
```text
usage: toil clean [-h] [--logCritical] [--logError] [--logWarning]
                  [--logDebug] [--logInfo] [--logOff]
                  [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                  [--logFile LOGFILE] [--rotatingLogging] [--logColors BOOL]
                  [--version] [--tempDirRoot TEMPDIRROOT]
                  jobStore

positional arguments:
  jobStore              The location of the job store for the workflow. A job
                        store holds persistent information about the jobs,
                        stats, and files in a workflow. If the workflow is run
                        with a distributed batch system, the job store must be
                        accessible by all worker nodes. Depending on the
                        desired job store implementation, the location should
                        be formatted according to one of the following
                        schemes: file:<path> where <path> points to a
                        directory on the file system aws:<region>:<prefix>
                        where <region> is the name of an AWS region like us-
                        west-2 and <prefix> will be prepended to the names of
                        any top-level AWS resources in use by job store, e.g.
                        S3 buckets. google:<project_id>:<prefix> TODO: explain
                        For backwards compatibility, you may also specify
                        ./foo (equivalent to file:./foo or just file:foo) or
                        /bar (equivalent to file:/bar).

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO. (default:
                        INFO)
  --logError            Turn on loglevel Error. Default: INFO. (default: INFO)
  --logWarning          Turn on loglevel Warning. Default: INFO. (default:
                        INFO)
  --logDebug            Turn on loglevel Debug. Default: INFO. (default: INFO)
  --logInfo             Turn on loglevel Info. Default: INFO. (default: INFO)
  --logOff              Same as --logCRITICAL. (default: INFO)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: INFO)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_config

### Tool Description
Generate a configuration file for Toil.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil [-h] [--logCritical] [--logError] [--logWarning] [--logDebug]
            [--logInfo] [--logOff]
            [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
            [--logFile LOGFILE] [--rotatingLogging] [--logColors BOOL]
            output

positional arguments:
  output                Filepath to write the config file too.
                        Default=config.yaml

options:
  -h, --help            show this help message and exit

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO.
  --logError            Turn on loglevel Error. Default: INFO.
  --logWarning          Turn on loglevel Warning. Default: INFO.
  --logDebug            Turn on loglevel Debug. Default: INFO.
  --logInfo             Turn on loglevel Info. Default: INFO.
  --logOff              Same as --logCRITICAL.
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
  --logFile LOGFILE     File to log in.
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big.
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_debug-file

### Tool Description
Debug and manage files within a Toil job store.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil debug-file [-h] [--logCritical] [--logError] [--logWarning]
                       [--logDebug] [--logInfo] [--logOff]
                       [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                       [--logFile LOGFILE] [--rotatingLogging]
                       [--logColors BOOL] [--version]
                       [--tempDirRoot TEMPDIRROOT]
                       [--localFilePath LOCALFILEPATH]
                       [--fetch FETCH [FETCH ...]]
                       [--listFilesInJobStore LISTFILESINJOBSTORE]
                       [--fetchEntireJobStore FETCHENTIREJOBSTORE]
                       [--useSymlinks USESYMLINKS]
                       jobStore

positional arguments:
  jobStore              The location of the job store for the workflow. A job
                        store holds persistent information about the jobs,
                        stats, and files in a workflow. If the workflow is run
                        with a distributed batch system, the job store must be
                        accessible by all worker nodes. Depending on the
                        desired job store implementation, the location should
                        be formatted according to one of the following
                        schemes: file:<path> where <path> points to a
                        directory on the file system aws:<region>:<prefix>
                        where <region> is the name of an AWS region like us-
                        west-2 and <prefix> will be prepended to the names of
                        any top-level AWS resources in use by job store, e.g.
                        S3 buckets. google:<project_id>:<prefix> TODO: explain
                        For backwards compatibility, you may also specify
                        ./foo (equivalent to file:./foo or just file:foo) or
                        /bar (equivalent to file:/bar).

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)
  --localFilePath LOCALFILEPATH
                        Location to which to copy job store files. (default:
                        None)
  --fetch FETCH [FETCH ...]
                        List of job-store files to be copied locally.Use
                        either explicit names (i.e. 'data.txt'), or specify
                        glob patterns (i.e. '*.txt') (default: None)
  --listFilesInJobStore LISTFILESINJOBSTORE
                        Prints a list of the current files in the jobStore.
                        (default: None)
  --fetchEntireJobStore FETCHENTIREJOBSTORE
                        Copy all job store files into a local directory.
                        (default: None)
  --useSymlinks USESYMLINKS
                        Creates symlink 'shortcuts' of files in the
                        localFilePath instead of hardlinking or copying, where
                        possible. If this is not possible, it will copy the
                        files (shutil.copyfile()). (default: None)

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO. (default:
                        INFO)
  --logError            Turn on loglevel Error. Default: INFO. (default: INFO)
  --logWarning          Turn on loglevel Warning. Default: INFO. (default:
                        INFO)
  --logDebug            Turn on loglevel Debug. Default: INFO. (default: INFO)
  --logInfo             Turn on loglevel Info. Default: INFO. (default: INFO)
  --logOff              Same as --logCRITICAL. (default: INFO)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: INFO)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_debug-job

### Tool Description
Debug a job within a Toil workflow by running it or retrieving its task directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil debug-job [-h] [--logCritical] [--logError] [--logWarning]
                      [--logDebug] [--logInfo] [--logOff]
                      [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                      [--logFile LOGFILE] [--rotatingLogging]
                      [--logColors BOOL] [--version]
                      [--tempDirRoot TEMPDIRROOT] [--printJobInfo]
                      [--retrieveTaskDirectory RETRIEVE_TASK_DIRECTORY]
                      jobStore job

positional arguments:
  jobStore              The location of the job store for the workflow. A job
                        store holds persistent information about the jobs,
                        stats, and files in a workflow. If the workflow is run
                        with a distributed batch system, the job store must be
                        accessible by all worker nodes. Depending on the
                        desired job store implementation, the location should
                        be formatted according to one of the following
                        schemes: file:<path> where <path> points to a
                        directory on the file system aws:<region>:<prefix>
                        where <region> is the name of an AWS region like us-
                        west-2 and <prefix> will be prepended to the names of
                        any top-level AWS resources in use by job store, e.g.
                        S3 buckets. google:<project_id>:<prefix> TODO: explain
                        For backwards compatibility, you may also specify
                        ./foo (equivalent to file:./foo or just file:foo) or
                        /bar (equivalent to file:/bar).
  job                   The job store id or job name of a job within the
                        provided jobstore

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)
  --printJobInfo        Dump debugging info about the job instead of running
                        it (default: False)
  --retrieveTaskDirectory RETRIEVE_TASK_DIRECTORY
                        Download CWL or WDL task inputs to the given directory
                        and stop. (default: None)

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: DEBUG. (default:
                        DEBUG)
  --logError            Turn on loglevel Error. Default: DEBUG. (default:
                        DEBUG)
  --logWarning          Turn on loglevel Warning. Default: DEBUG. (default:
                        DEBUG)
  --logDebug            Turn on loglevel Debug. Default: DEBUG. (default:
                        DEBUG)
  --logInfo             Turn on loglevel Info. Default: DEBUG. (default:
                        DEBUG)
  --logOff              Same as --logCRITICAL. (default: DEBUG)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: DEBUG. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: DEBUG)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_destroy-cluster

### Tool Description
Destroy a Toil cluster

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil destroy-cluster [-h] [--provisioner {aws,gce}] [-z ZONE]
                            [--logCritical] [--logError] [--logWarning]
                            [--logDebug] [--logInfo] [--logOff]
                            [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                            [--logFile LOGFILE] [--rotatingLogging]
                            [--logColors BOOL] [--version]
                            [--tempDirRoot TEMPDIRROOT]
                            clusterName

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)

Provisioner Options.:
  --provisioner {aws,gce}, -p {aws,gce}
                        The provisioner for cluster auto-scaling. This is the
                        '--provisioner' option set for Toil utils like launch-
                        cluster and destroy-cluster, which always require a
                        provisioner, and so this defaults to: aws. Choices:
                        ['aws', 'gce'].
  -z ZONE, --zone ZONE  The availability zone of the leader. This parameter
                        can also be set via the 'TOIL_X_ZONE' environment
                        variable, where X is AWS or GCE, or by the
                        ec2_region_name parameter in your .boto file, or
                        derived from the instance metadata if using this
                        utility on an existing EC2 instance. (default: None)
  clusterName           The name that the cluster will be identifiable by.
                        Must be lowercase and may not contain the '_'
                        character.

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO. (default:
                        INFO)
  --logError            Turn on loglevel Error. Default: INFO. (default: INFO)
  --logWarning          Turn on loglevel Warning. Default: INFO. (default:
                        INFO)
  --logDebug            Turn on loglevel Debug. Default: INFO. (default: INFO)
  --logInfo             Turn on loglevel Info. Default: INFO. (default: INFO)
  --logOff              Same as --logCRITICAL. (default: INFO)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: INFO)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_kill

### Tool Description
Kill a Toil workflow and its associated jobs in the job store.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil kill [-h] [--logCritical] [--logError] [--logWarning] [--logDebug]
                 [--logInfo] [--logOff]
                 [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                 [--logFile LOGFILE] [--rotatingLogging] [--logColors BOOL]
                 [--version] [--tempDirRoot TEMPDIRROOT] [--force]
                 jobStore

positional arguments:
  jobStore              The location of the job store for the workflow. A job
                        store holds persistent information about the jobs,
                        stats, and files in a workflow. If the workflow is run
                        with a distributed batch system, the job store must be
                        accessible by all worker nodes. Depending on the
                        desired job store implementation, the location should
                        be formatted according to one of the following
                        schemes: file:<path> where <path> points to a
                        directory on the file system aws:<region>:<prefix>
                        where <region> is the name of an AWS region like us-
                        west-2 and <prefix> will be prepended to the names of
                        any top-level AWS resources in use by job store, e.g.
                        S3 buckets. google:<project_id>:<prefix> TODO: explain
                        For backwards compatibility, you may also specify
                        ./foo (equivalent to file:./foo or just file:foo) or
                        /bar (equivalent to file:/bar).

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)
  --force               Send SIGKILL to the leader process if local. (default:
                        False)

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO. (default:
                        INFO)
  --logError            Turn on loglevel Error. Default: INFO. (default: INFO)
  --logWarning          Turn on loglevel Warning. Default: INFO. (default:
                        INFO)
  --logDebug            Turn on loglevel Debug. Default: INFO. (default: INFO)
  --logInfo             Turn on loglevel Info. Default: INFO. (default: INFO)
  --logOff              Same as --logCRITICAL. (default: INFO)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: INFO)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_launch-cluster

### Tool Description
Launch a Toil cluster with a specified provisioner and node types.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil launch-cluster [-h] [--provisioner {aws,gce}] [-z ZONE]
                           [--logCritical] [--logError] [--logWarning]
                           [--logDebug] [--logInfo] [--logOff]
                           [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                           [--logFile LOGFILE] [--rotatingLogging]
                           [--logColors BOOL] [--version]
                           [--tempDirRoot TEMPDIRROOT] [-T {mesos,kubernetes}]
                           --leaderNodeType LEADERNODETYPE
                           [--keyPairName KEYPAIRNAME] [--owner OWNER]
                           [--boto BOTOPATH] [-t NAME=VALUE]
                           [--network NETWORK] [--vpcSubnet VPCSUBNET]
                           [--use_private_ip] [--nodeTypes NODETYPES]
                           [-w WORKERS] [--leaderStorage LEADERSTORAGE]
                           [--nodeStorage NODESTORAGE]
                           [--forceDockerAppliance]
                           [--awsEc2ProfileArn AWSEC2PROFILEARN]
                           [--awsEc2ExtraSecurityGroupId AWSEC2EXTRASECURITYGROUPIDS]
                           [--allowFuse ALLOWFUSE]
                           clusterName

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)
  -T {mesos,kubernetes}, --clusterType {mesos,kubernetes}
                        Cluster scheduler to use. (default: None)
  --leaderNodeType LEADERNODETYPE
                        Non-preemptible node type to use for the cluster
                        leader. (default: None)
  --keyPairName KEYPAIRNAME
                        On AWS, the name of the AWS key pair to include on the
                        instance. On Google/GCE, this is the ssh key pair.
                        (default: None)
  --owner OWNER         The owner tag for all instances. If not given, the
                        value inTOIL_OWNER_TAG will be used, or else the value
                        of --keyPairName. (default: None)
  --boto BOTOPATH       The path to the boto credentials directory. This is
                        transferred to all nodes in order to access the AWS
                        jobStore from non-AWS instances. (default: None)
  -t NAME=VALUE, --tag NAME=VALUE
                        Tags are added to the AWS cluster for this node and
                        all of its children. Tags are of the form: -t
                        key1=value1 --tag key2=value2 Multiple tags are
                        allowed and each tag needs its own flag. By default
                        the cluster is tagged with { "Name": clusterName,
                        "Owner": IAM username }. (default: [])
  --network NETWORK     GCE cloud network to use. default: 'default' (default:
                        None)
  --vpcSubnet VPCSUBNET
                        VPC subnet ID to launch cluster leader in. Uses
                        default subnet if not specified. This subnet needs to
                        have auto assign IPs turned on. (default: None)
  --use_private_ip      if specified, ignore the public ip of the nodes
                        (default: False)
  --nodeTypes NODETYPES
                        Specifies a list of comma-separated node types, each
                        of which is composed of slash-separated instance
                        types, and an optional spot bid set off by a colon,
                        making the node type preemptible. Instance types may
                        appear in multiple node types, and the same node type
                        may appear as both preemptible and non-preemptible.
                        Valid argument specifying two node types:
                        c5.4xlarge/c5a.4xlarge:0.42,t2.large Node types:
                        c5.4xlarge/c5a.4xlarge:0.42 and t2.large Instance
                        types: c5.4xlarge, c5a.4xlarge, and t2.large
                        Semantics: Bid $0.42/hour for either c5.4xlarge or
                        c5a.4xlarge instances, treated interchangeably, while
                        they are available at that price, and buy t2.large
                        instances at full price Must also provide the
                        --workers argument to specify how many workers of each
                        node type to create. (default: None)
  -w WORKERS, --workers WORKERS
                        Comma-separated list of the ranges of numbers of
                        workers of each node type to launch, such as
                        '0-2,5,1-3'. If a range is given, workers will
                        automatically be launched and terminated by the
                        cluster to auto-scale to the workload. (default: None)
  --leaderStorage LEADERSTORAGE
                        Specify the size (in gigabytes) of the root volume for
                        the leader instance. This is an EBS volume. (default:
                        50)
  --nodeStorage NODESTORAGE
                        Specify the size (in gigabytes) of the root volume for
                        any worker instances created when using the -w flag.
                        This is an EBS volume. (default: 50)
  --forceDockerAppliance
                        Disables sanity checking the existence of the docker
                        image specified by TOIL_APPLIANCE_SELF, which Toil
                        uses to provision mesos for autoscaling. (default:
                        False)
  --awsEc2ProfileArn AWSEC2PROFILEARN
                        If provided, the specified ARN is used as the instance
                        profile for EC2 instances.Useful for setting custom
                        IAM profiles. If not specified, a new IAM role is
                        created by default with sufficient access to perform
                        basic cluster operations. (default: None)
  --awsEc2ExtraSecurityGroupId AWSEC2EXTRASECURITYGROUPIDS
                        Any additional security groups to attach to EC2
                        instances. Note that a security group with its name
                        equal to the cluster name will always be created, thus
                        ensure that the extra security groups do not have the
                        same name as the cluster name. (default: [])
  --allowFuse ALLOWFUSE
                        Enable both the leader and worker nodes to be able to
                        run Singularity with FUSE. For Kubernetes, this will
                        make the leader privileged and ask workers to run as
                        privileged. (default: True)

Provisioner Options.:
  --provisioner {aws,gce}, -p {aws,gce}
                        The provisioner for cluster auto-scaling. This is the
                        '--provisioner' option set for Toil utils like launch-
                        cluster and destroy-cluster, which always require a
                        provisioner, and so this defaults to: aws. Choices:
                        ['aws', 'gce'].
  -z ZONE, --zone ZONE  The availability zone of the leader. This parameter
                        can also be set via the 'TOIL_X_ZONE' environment
                        variable, where X is AWS or GCE, or by the
                        ec2_region_name parameter in your .boto file, or
                        derived from the instance metadata if using this
                        utility on an existing EC2 instance. (default: None)
  clusterName           The name that the cluster will be identifiable by.
                        Must be lowercase and may not contain the '_'
                        character.

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO. (default:
                        INFO)
  --logError            Turn on loglevel Error. Default: INFO. (default: INFO)
  --logWarning          Turn on loglevel Warning. Default: INFO. (default:
                        INFO)
  --logDebug            Turn on loglevel Debug. Default: INFO. (default: INFO)
  --logInfo             Turn on loglevel Info. Default: INFO. (default: INFO)
  --logOff              Same as --logCRITICAL. (default: INFO)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: INFO)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_rsync-cluster

### Tool Description
Rsync files to or from a Toil cluster leader node.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil rsync-cluster [-h] [--provisioner {aws,gce}] [-z ZONE]
                          [--logCritical] [--logError] [--logWarning]
                          [--logDebug] [--logInfo] [--logOff]
                          [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                          [--logFile LOGFILE] [--rotatingLogging]
                          [--logColors BOOL] [--version]
                          [--tempDirRoot TEMPDIRROOT] [--insecure]
                          clusterName ...

positional arguments:
  args                  Arguments to pass to`rsync`. Takes any arguments that
                        rsync accepts. Specify the remote with a colon. For
                        example, to upload `example.py`, specify `toil rsync-
                        cluster -p aws test-cluster example.py :`. Or, to
                        download a file from the remote:, `toil rsync-cluster
                        -p aws test-cluster :example.py .`

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)
  --insecure            Temporarily disable strict host key checking.
                        (default: False)

Provisioner Options.:
  --provisioner {aws,gce}, -p {aws,gce}
                        The provisioner for cluster auto-scaling. This is the
                        '--provisioner' option set for Toil utils like launch-
                        cluster and destroy-cluster, which always require a
                        provisioner, and so this defaults to: aws. Choices:
                        ['aws', 'gce'].
  -z ZONE, --zone ZONE  The availability zone of the leader. This parameter
                        can also be set via the 'TOIL_X_ZONE' environment
                        variable, where X is AWS or GCE, or by the
                        ec2_region_name parameter in your .boto file, or
                        derived from the instance metadata if using this
                        utility on an existing EC2 instance. (default: None)
  clusterName           The name that the cluster will be identifiable by.
                        Must be lowercase and may not contain the '_'
                        character.

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO. (default:
                        INFO)
  --logError            Turn on loglevel Error. Default: INFO. (default: INFO)
  --logWarning          Turn on loglevel Warning. Default: INFO. (default:
                        INFO)
  --logDebug            Turn on loglevel Debug. Default: INFO. (default: INFO)
  --logInfo             Turn on loglevel Info. Default: INFO. (default: INFO)
  --logOff              Same as --logCRITICAL. (default: INFO)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: INFO)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_server

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
The toil[server] extra is not installed.
```


## toil_ssh-cluster

### Tool Description
SSH into a Toil managed cluster

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil ssh-cluster [-h] [--provisioner {aws,gce}] [-z ZONE]
                        [--logCritical] [--logError] [--logWarning]
                        [--logDebug] [--logInfo] [--logOff]
                        [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                        [--logFile LOGFILE] [--rotatingLogging]
                        [--logColors BOOL] [--version]
                        [--tempDirRoot TEMPDIRROOT] [--insecure]
                        [--sshOption SSHOPTIONS] [--grafana_port GRAFANA_PORT]
                        clusterName ...

positional arguments:
  args

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)
  --insecure            Temporarily disable strict host key checking.
                        (default: False)
  --sshOption SSHOPTIONS
                        Pass an additional option to the SSH command.
                        (default: [])
  --grafana_port GRAFANA_PORT
                        Assign a local port to be used for the Grafana
                        dashboard. (default: 3000)

Provisioner Options.:
  --provisioner {aws,gce}, -p {aws,gce}
                        The provisioner for cluster auto-scaling. This is the
                        '--provisioner' option set for Toil utils like launch-
                        cluster and destroy-cluster, which always require a
                        provisioner, and so this defaults to: aws. Choices:
                        ['aws', 'gce'].
  -z ZONE, --zone ZONE  The availability zone of the leader. This parameter
                        can also be set via the 'TOIL_X_ZONE' environment
                        variable, where X is AWS or GCE, or by the
                        ec2_region_name parameter in your .boto file, or
                        derived from the instance metadata if using this
                        utility on an existing EC2 instance. (default: None)
  clusterName           The name that the cluster will be identifiable by.
                        Must be lowercase and may not contain the '_'
                        character.

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO. (default:
                        INFO)
  --logError            Turn on loglevel Error. Default: INFO. (default: INFO)
  --logWarning          Turn on loglevel Warning. Default: INFO. (default:
                        INFO)
  --logDebug            Turn on loglevel Debug. Default: INFO. (default: INFO)
  --logInfo             Turn on loglevel Info. Default: INFO. (default: INFO)
  --logOff              Same as --logCRITICAL. (default: INFO)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: INFO)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_stats

### Tool Description
The location of the job store for the workflow. A job store holds persistent information about the jobs, stats, and files in a workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil stats [-h] [--logCritical] [--logError] [--logWarning]
                  [--logDebug] [--logInfo] [--logOff]
                  [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                  [--logFile LOGFILE] [--rotatingLogging] [--logColors BOOL]
                  [--version] [--tempDirRoot TEMPDIRROOT]
                  [--outputFile OUTPUTFILE] [--raw] [--pretty]
                  [--sort {ascending,decending}] [--categories CATEGORIES]
                  [--sortCategory {time,clock,wait,memory,disk,alpha,count}]
                  [--sortField {min,med,ave,max,total}]
                  jobStore

positional arguments:
  jobStore              The location of the job store for the workflow. A job
                        store holds persistent information about the jobs,
                        stats, and files in a workflow. If the workflow is run
                        with a distributed batch system, the job store must be
                        accessible by all worker nodes. Depending on the
                        desired job store implementation, the location should
                        be formatted according to one of the following
                        schemes: file:<path> where <path> points to a
                        directory on the file system aws:<region>:<prefix>
                        where <region> is the name of an AWS region like us-
                        west-2 and <prefix> will be prepended to the names of
                        any top-level AWS resources in use by job store, e.g.
                        S3 buckets. google:<project_id>:<prefix> TODO: explain
                        For backwards compatibility, you may also specify
                        ./foo (equivalent to file:./foo or just file:foo) or
                        /bar (equivalent to file:/bar).

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)
  --outputFile OUTPUTFILE
                        File in which to write results. (default: None)
  --raw                 Return raw json data. (default: False)
  --pretty, --human     if not raw, prettify the numbers to be human readable.
                        (default: False)
  --sort {ascending,decending}
                        Sort direction. (default: decending)
  --categories CATEGORIES
                        Comma separated list of any of the following: ['time',
                        'clock', 'wait', 'memory', 'disk']. (default:
                        time,clock,wait,memory,disk)
  --sortCategory {time,clock,wait,memory,disk,alpha,count}
                        How to sort job categories. (default: time)
  --sortField {min,med,ave,max,total}
                        How to sort job fields. (default: med)

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO. (default:
                        INFO)
  --logError            Turn on loglevel Error. Default: INFO. (default: INFO)
  --logWarning          Turn on loglevel Warning. Default: INFO. (default:
                        INFO)
  --logDebug            Turn on loglevel Debug. Default: INFO. (default: INFO)
  --logInfo             Turn on loglevel Info. Default: INFO. (default: INFO)
  --logOff              Same as --logCRITICAL. (default: INFO)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: INFO)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```


## toil_status

### Tool Description
Report the status of a Toil workflow and its jobs.

### Metadata
- **Docker Image**: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
- **Homepage**: https://toil.ucsc-cgl.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/toil/overview
- **Validation**: PASS

### Original Help Text
```text
usage: toil status [-h] [--logCritical] [--logError] [--logWarning]
                   [--logDebug] [--logInfo] [--logOff]
                   [--logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}]
                   [--logFile LOGFILE] [--rotatingLogging] [--logColors BOOL]
                   [--version] [--tempDirRoot TEMPDIRROOT]
                   [--failIfNotComplete] [--noAggStats] [--dot]
                   [--jobs JOBS [JOBS ...]] [--perJob] [--logs] [--children]
                   [--status] [--failed]
                   jobStore

positional arguments:
  jobStore              The location of the job store for the workflow. A job
                        store holds persistent information about the jobs,
                        stats, and files in a workflow. If the workflow is run
                        with a distributed batch system, the job store must be
                        accessible by all worker nodes. Depending on the
                        desired job store implementation, the location should
                        be formatted according to one of the following
                        schemes: file:<path> where <path> points to a
                        directory on the file system aws:<region>:<prefix>
                        where <region> is the name of an AWS region like us-
                        west-2 and <prefix> will be prepended to the names of
                        any top-level AWS resources in use by job store, e.g.
                        S3 buckets. google:<project_id>:<prefix> TODO: explain
                        For backwards compatibility, you may also specify
                        ./foo (equivalent to file:./foo or just file:foo) or
                        /bar (equivalent to file:/bar).

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --tempDirRoot TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default generates a fresh tmp
                        dir with 'tempfile.gettempdir()'. (default: /tmp)
  --failIfNotComplete   Return exit value of 1 if toil jobs not all completed.
                        default=False
  --noAggStats          Do not print overall, aggregate status of workflow.
                        (default: True)
  --dot, --printDot     Print dot formatted description of the graph. If using
                        --jobs will restrict to subgraph including only those
                        jobs. default=False
  --jobs JOBS [JOBS ...]
                        Restrict reporting to the following jobs (allows
                        subsetting of the report). (default: None)
  --perJob, --printPerJobStats
                        Print info about each job. default=False
  --logs, --printLogs   Print the log files of jobs (if they exist).
                        default=False
  --children, --printChildren
                        Print children of each job. default=False
  --status, --printStatus
                        Determine which jobs are currently running and the
                        associated batch system ID (default: False)
  --failed, --printFailed
                        List jobs which seem to have failed to run (default:
                        False)

Logging Options:
  --logCritical         Turn on loglevel Critical. Default: INFO. (default:
                        INFO)
  --logError            Turn on loglevel Error. Default: INFO. (default: INFO)
  --logWarning          Turn on loglevel Warning. Default: INFO. (default:
                        INFO)
  --logDebug            Turn on loglevel Debug. Default: INFO. (default: INFO)
  --logInfo             Turn on loglevel Info. Default: INFO. (default: INFO)
  --logOff              Same as --logCRITICAL. (default: INFO)
  --logLevel {Critical,Error,Warning,Debug,Info,critical,error,warning,debug,info,CRITICAL,ERROR,WARNING,DEBUG,INFO}
                        Set the log level. Default: INFO. Options:
                        ['Critical', 'Error', 'Warning', 'Debug', 'Info',
                        'critical', 'error', 'warning', 'debug', 'info',
                        'CRITICAL', 'ERROR', 'WARNING', 'DEBUG', 'INFO'].
                        (default: INFO)
  --logFile LOGFILE     File to log in. (default: None)
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        from getting too big. (default: False)
  --logColors BOOL      Enable or disable colored logging. Default: True
```

