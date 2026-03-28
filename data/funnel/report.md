# funnel CWL Generation Report

## funnel_aws

### Tool Description
Development utilities for creating funnel resources on AWS

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Total Downloads**: 9.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Development utilities for creating funnel resources on AWS

Usage:
  funnel aws [command]

Available Commands:
  batch       Utilities for managing funnel resources on AWS Batch

Flags:
  -h, --help   help for aws

Use "funnel aws [command] --help" for more information about a command.
```


## funnel_completion

### Tool Description
Generate shell completion code

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
Generate shell completion code

Usage:
  funnel completion [command]

Available Commands:
  bash        Generate bash completion code

Flags:
  -h, --help   help for completion

Use "funnel completion [command] --help" for more information about a command.
```


## funnel_dashboard

### Tool Description
Start a Funnel dashboard in your terminal.

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
Start a Funnel dashboard in your terminal.

Usage:
  funnel dashboard [flags]

Flags:
  -h, --help            help for dashboard
  -S, --server string   (default "http://localhost:8000")
```


## funnel_examples

### Tool Description
A simple hello world example that demonstrates the full CWL functionality.

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
full-hello
md5sum
resource-request
pbs-template
capture-stdout-stderr
gridengine-template
log-streaming
s3
google-storage
input-content
default-config
hello-world
slurm-template
htcondor-template
```


## funnel_gce

### Tool Description
Manage GCE resources for funnel

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  funnel gce [command]

Available Commands:
  run         

Flags:
  -h, --help   help for gce

Use "funnel gce [command] --help" for more information about a command.
```


## funnel_node

### Tool Description
Funnel node subcommands.

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
Funnel node subcommands.

Usage:
  funnel node [command]

Aliases:
  node, nodes

Available Commands:
  run         Run a Funnel node.

Flags:
      --AmazonS3.Disabled                  Disable storage backend
      --AmazonS3.MaxRetries int            Maximum number of times that a request will be retried for failures
      --BoltDB.Path string                 Path to BoltDB database
      --Compute string                     Name of compute backed to use
      --Database string                    Name of database backed to use
      --Datastore.Project string           Google project for Datastore
      --DynamoDB.MaxRetries int            Maximum number of times that a request will be retried for failures
      --DynamoDB.Region string             AWS region of DynamoDB tables
      --DynamoDB.TableBasename string      Basename of DynamoDB tables
      --Elastic.IndexPrefix string         Prefix to use for Elasticsearch indices
      --Elastic.URL string                 Elasticsearch URL
      --EventWriters strings               Name of an event writer backend to use. This flag can be used multiple times
      --GoogleStorage.Disabled             Disable storage backend
      --HTTPStorage.Disabled               Disable storage backend
      --HTTPStorage.Timeout duration       Timeout in seconds for request (default 0s)
      --Kafka.Servers strings              Address of a Kafka server. This flag can be used multiple times
      --Kafka.Topic string                 Kafka topic to write events to
      --LocalStorage.AllowedDirs strings   Directories Funnel is allowed to access. This flag can be used multiple times
      --LocalStorage.Disabled              Disable storage backend
      --Logger.Formatter string            Logs formatter. One of ['text', 'json']
      --Logger.Level string                Level of logging
      --Logger.OutputFile string           File path to write logs to
      --MongoDB.Addrs strings              Address of a MongoDB seed server. This flag can be used multiple times
      --MongoDB.Database string            Database name in MongoDB
      --MongoDB.Timeout duration           Timeout in seconds for initial connection and follow up operations (default 0s)
      --Node.Resources.Cpus uint32         Cpus available to Node
      --Node.Resources.DiskGb float        Free disk (GB) available to Node
      --Node.Resources.RamGb float         Ram (GB) available to Node
      --Node.Timeout duration              Node timeout in seconds (default 0s)
      --Node.UpdateRate duration           Node update rate (default 0s)
      --RPCClient.MaxRetries uint          Maximum number of times that a request will be retried for failures
      --RPCClient.ServerAddress string     RPC server address
      --RPCClient.Timeout duration         Request timeout for RPC client connections (default 0s)
      --Server.HTTPPort string             HTTP Port
      --Server.HostName string             Host name or IP
      --Server.RPCPort string              RPC Port
      --Server.ServiceName string          Host name or IP
      --Swift.ChunkSizeBytes int           Size of chunks to use for large object creation
      --Swift.Disabled                     Disable storage backend
      --Swift.MaxRetries int               Maximum number of times that a request will be retried for failures
      --Worker.LeaveWorkDir                Leave working directory after execution
      --Worker.LogTailSize int             Max bytes to store for stdout/stderr
      --Worker.LogUpdateRate duration      How often to send stdout/stderr log updates (default 0s)
      --Worker.PollingRate duration        How often to poll for cancel signals (default 0s)
      --Worker.WorkDir string              Working directory
  -c, --config string                      Config File
  -h, --help                               help for node

Use "funnel node [command] --help" for more information about a command.
```


## funnel_run

### Tool Description
Run a task.

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
Run a task.

Usage:
  funnel run 'CMD' [flags]

General flags:
  -S, --server      Address of Funnel server. Default: http://localhost:8000
  -c, --container   Containter the command runs in. Default: alpine
      --sh          Command to be run. This command will be run with the shell: 'sh -c "<sh>"'.
                    This is the default execution mode for commands passed as args. 
      --exec        Command to be run. This command will not be evaulated by 'sh'.
  -p, --print       Print the task without running it.
      --scatter     Scatter multiple tasks, one per row of the given file.
      --wait        Wait for the task to finish before exiting.
      --wait-for    Wait for the given task IDs before running the task.

Input/output file flags:
  -i, --in          Input file e.g. varname=/path/to/input.txt
  -I, --in-dir      Input directory e.g. varname=/path/to/dir
  -o, --out         Output file e.g. varname=/path/to/output.txt
  -O, --out-dir     Output directory e.g. varname=/path/to/dir
  -C, --content     Include input file content from a file e.g. varname=/path/to/in.txt
      --stdin       File to write to stdin to the command.
      --stdout      File to write to stdout of the command.
      --stderr      File to write to stderr of the command.

Resource request flags:
      --cpu         Number of CPUs to request.
      --ram         Amount of RAM to request, in GB.
      --disk        Amount of disk space to request, in GB.
      --zone        Require task be scheduled in certain zones.
      --preemptible Allow task to be scheduled on preemptible workers.

Other flags:
  -n, --name         Task name.
      --description  Task description.
      --tag          Arbitrary key-value tags, e.g. tagname=tagvalue
  -e, --env          Environment variables, e.g. envvar=foo
  -w, --workdir      Containter working directory.
      --vol          Define a volume on the container.

Examples:
  # Simple md5sum of a file and save the stdout.
  funnel run 'md5sum $in' -i in=input.txt --stdout output.txt

  # Use a different container.
  funnel run 'echo hello world' -c ubuntu

  # Print the task JSON instead of running it.
  funnel run 'echo $in" -i in=input.txt --print

  # md5sum all files in a directory.
  funnel run 'md5sum $d' -I d=./inputs --stdout output.txt

  # Sleep for 5 seconds, and wait for the sleep to finish.
  funnel run 'sleep 5' --wait

  # Set environment variables
  funnel run 'echo $MSG' -e MSG=Hello

  # When writing lots of arguments, Bash heredoc can be helpful.
  funnel run 'myprog -a $argA -b $argB -i $file1 -d $dir1' <<ARGS
    --container myorg/mycontainer
    --name 'MyProg test'
    --description 'Funnel run example of writing many arguments.'
    --tag meta=val
    --in file1=input.txt
    --in-dir dir1=inputs
    --stdout /path/to/stdout.txt
    --stderr /path/to/stderr.txt
    --env argA=1
    --env argB=2
    --vol /tmp 
    --vol /opt
    --cpu 8
    --ram 32
    --disk 100
    --preemptible
    --zone us-west1-a
  ARGS
```


## funnel_server

### Tool Description
Funnel server commands.

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
Funnel server commands.

Usage:
  funnel server [command]

Available Commands:
  run         Runs a Funnel server.

Flags:
      --AWSBatch.JobDefinition string        AWS Batch job definition name or ARN
      --AWSBatch.JobQueue string             AWS Batch job queue name or ARN
      --AWSBatch.MaxRetries int              Maximum number of times that a request will be retried for failures
      --AWSBatch.Region string               AWS region of Batch resources
      --AmazonS3.Disabled                    Disable storage backend
      --AmazonS3.MaxRetries int              Maximum number of times that a request will be retried for failures
      --BoltDB.Path string                   Path to BoltDB database
      --Compute string                       Name of compute backed to use
      --Database string                      Name of database backed to use
      --Datastore.Project string             Google project for Datastore
      --DynamoDB.MaxRetries int              Maximum number of times that a request will be retried for failures
      --DynamoDB.Region string               AWS region of DynamoDB tables
      --DynamoDB.TableBasename string        Basename of DynamoDB tables
      --Elastic.IndexPrefix string           Prefix to use for Elasticsearch indices
      --Elastic.URL string                   Elasticsearch URL
      --EventWriters strings                 Name of an event writer backend to use. This flag can be used multiple times
      --GoogleStorage.Disabled               Disable storage backend
      --GridEngine.Template string           Path to submit template file
      --HTCondor.Template string             Path to submit template file
      --HTTPStorage.Disabled                 Disable storage backend
      --HTTPStorage.Timeout duration         Timeout in seconds for request (default 0s)
      --Kafka.Servers strings                Address of a Kafka server. This flag can be used multiple times
      --Kafka.Topic string                   Kafka topic to write events to
      --LocalStorage.AllowedDirs strings     Directories Funnel is allowed to access. This flag can be used multiple times
      --LocalStorage.Disabled                Disable storage backend
      --Logger.Formatter string              Logs formatter. One of ['text', 'json']
      --Logger.Level string                  Level of logging
      --Logger.OutputFile string             File path to write logs to
      --MongoDB.Addrs strings                Address of a MongoDB seed server. This flag can be used multiple times
      --MongoDB.Database string              Database name in MongoDB
      --MongoDB.Timeout duration             Timeout in seconds for initial connection and follow up operations (default 0s)
      --Node.Resources.Cpus uint32           Cpus available to Node
      --Node.Resources.DiskGb float          Free disk (GB) available to Node
      --Node.Resources.RamGb float           Ram (GB) available to Node
      --Node.Timeout duration                Node timeout in seconds (default 0s)
      --Node.UpdateRate duration             Node update rate (default 0s)
      --PBS.Template string                  Path to submit template file
      --RPCClient.MaxRetries uint            Maximum number of times that a request will be retried for failures
      --RPCClient.ServerAddress string       RPC server address
      --RPCClient.Timeout duration           Request timeout for RPC client connections (default 0s)
      --Scheduler.NodeDeadTimeout duration   How long to wait before deleting a dead node from the DB (default 0s)
      --Scheduler.NodeInitTimeout duration   How long to wait for node initialization before marking it dead (default 0s)
      --Scheduler.NodePingTimeout duration   How long to wait for a node ping before marking it as dead (default 0s)
      --Scheduler.ScheduleChunk int          How many tasks to schedule in one iteration
      --Scheduler.ScheduleRate duration      How often to run a scheduler iteration (default 0s)
      --Server.HTTPPort string               HTTP Port
      --Server.HostName string               Host name or IP
      --Server.RPCPort string                RPC Port
      --Server.ServiceName string            Host name or IP
      --Slurm.Template string                Path to submit template file
      --Swift.ChunkSizeBytes int             Size of chunks to use for large object creation
      --Swift.Disabled                       Disable storage backend
      --Swift.MaxRetries int                 Maximum number of times that a request will be retried for failures
      --Worker.LeaveWorkDir                  Leave working directory after execution
      --Worker.LogTailSize int               Max bytes to store for stdout/stderr
      --Worker.LogUpdateRate duration        How often to send stdout/stderr log updates (default 0s)
      --Worker.PollingRate duration          How often to poll for cancel signals (default 0s)
      --Worker.WorkDir string                Working directory
  -c, --config string                        Config File
  -h, --help                                 help for server

Use "funnel server [command] --help" for more information about a command.
```


## funnel_storage

### Tool Description
Access storage via Funnel's client libraries.

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
Access storage via Funnel's client libraries.

Usage:
  funnel storage [command]

Available Commands:
  get         Get the object at the given URL.
  list        List objects at the given URL.
  put         Put the local file to the given URL.
  stat        Returns information about the object at the given URL.
  stat-task   Returns information about inputs/outputs of the task.

Flags:
  -c, --config string   Config File
  -h, --help            help for storage

Use "funnel storage [command] --help" for more information about a command.
```


## funnel_task

### Tool Description
Make API calls to a TES server.

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
Make API calls to a TES server.

Usage:
  funnel task [command]

Aliases:
  task, tasks

Available Commands:
  cancel      Cancel one or more tasks by ID.
  create      Create one or more tasks to run on the server.
  get         Get one or more tasks by ID.
  list        List all tasks.
  wait        Wait for one or more tasks to complete.


Flags:
  -h, --help            help for task
  -S, --server string   (default "http://localhost:8000")

Use "funnel task [command] --help" for more information about a command.
```


## funnel_worker

### Tool Description
Funnel worker commands.

### Metadata
- **Docker Image**: quay.io/biocontainers/funnel:0.9.0--0
- **Homepage**: https://ohsu-comp-bio.github.io/funnel/
- **Package**: https://anaconda.org/channels/bioconda/packages/funnel/overview
- **Validation**: PASS

### Original Help Text
```text
Funnel worker commands.

Usage:
  funnel worker [command]

Available Commands:
  run         Run a task directly, bypassing the server.

Flags:
      --AmazonS3.Disabled                  Disable storage backend
      --AmazonS3.MaxRetries int            Maximum number of times that a request will be retried for failures
      --BoltDB.Path string                 Path to BoltDB database
      --Compute string                     Name of compute backed to use
      --Database string                    Name of database backed to use
      --Datastore.Project string           Google project for Datastore
      --DynamoDB.MaxRetries int            Maximum number of times that a request will be retried for failures
      --DynamoDB.Region string             AWS region of DynamoDB tables
      --DynamoDB.TableBasename string      Basename of DynamoDB tables
      --Elastic.IndexPrefix string         Prefix to use for Elasticsearch indices
      --Elastic.URL string                 Elasticsearch URL
      --EventWriters strings               Name of an event writer backend to use. This flag can be used multiple times
      --GoogleStorage.Disabled             Disable storage backend
      --HTTPStorage.Disabled               Disable storage backend
      --HTTPStorage.Timeout duration       Timeout in seconds for request (default 0s)
      --Kafka.Servers strings              Address of a Kafka server. This flag can be used multiple times
      --Kafka.Topic string                 Kafka topic to write events to
      --LocalStorage.AllowedDirs strings   Directories Funnel is allowed to access. This flag can be used multiple times
      --LocalStorage.Disabled              Disable storage backend
      --Logger.Formatter string            Logs formatter. One of ['text', 'json']
      --Logger.Level string                Level of logging
      --Logger.OutputFile string           File path to write logs to
      --MongoDB.Addrs strings              Address of a MongoDB seed server. This flag can be used multiple times
      --MongoDB.Database string            Database name in MongoDB
      --MongoDB.Timeout duration           Timeout in seconds for initial connection and follow up operations (default 0s)
      --Node.Resources.Cpus uint32         Cpus available to Node
      --Node.Resources.DiskGb float        Free disk (GB) available to Node
      --Node.Resources.RamGb float         Ram (GB) available to Node
      --Node.Timeout duration              Node timeout in seconds (default 0s)
      --Node.UpdateRate duration           Node update rate (default 0s)
      --RPCClient.MaxRetries uint          Maximum number of times that a request will be retried for failures
      --RPCClient.ServerAddress string     RPC server address
      --RPCClient.Timeout duration         Request timeout for RPC client connections (default 0s)
      --Server.HTTPPort string             HTTP Port
      --Server.HostName string             Host name or IP
      --Server.RPCPort string              RPC Port
      --Server.ServiceName string          Host name or IP
      --Swift.ChunkSizeBytes int           Size of chunks to use for large object creation
      --Swift.Disabled                     Disable storage backend
      --Swift.MaxRetries int               Maximum number of times that a request will be retried for failures
      --Worker.LeaveWorkDir                Leave working directory after execution
      --Worker.LogTailSize int             Max bytes to store for stdout/stderr
      --Worker.LogUpdateRate duration      How often to send stdout/stderr log updates (default 0s)
      --Worker.PollingRate duration        How often to poll for cancel signals (default 0s)
      --Worker.WorkDir string              Working directory
  -c, --config string                      Config File
  -h, --help                               help for worker

Use "funnel worker [command] --help" for more information about a command.
```


## Metadata
- **Skill**: generated
