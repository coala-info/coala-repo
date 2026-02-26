cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - launch-cluster
label: toil_launch-cluster
doc: "Launch a Toil cluster with a specified provisioner and node types.\n\nTool homepage:
  https://toil.ucsc-cgl.org/"
inputs:
  - id: cluster_name
    type: string
    doc: The name that the cluster will be identifiable by. Must be lowercase 
      and may not contain the '_' character.
    inputBinding:
      position: 1
  - id: allow_fuse
    type:
      - 'null'
      - string
    doc: Enable both the leader and worker nodes to be able to run Singularity 
      with FUSE.
    default: 'True'
    inputBinding:
      position: 102
      prefix: --allowFuse
  - id: aws_ec2_extra_security_group_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Any additional security groups to attach to EC2 instances.
    inputBinding:
      position: 102
      prefix: --awsEc2ExtraSecurityGroupId
  - id: aws_ec2_profile_arn
    type:
      - 'null'
      - string
    doc: If provided, the specified ARN is used as the instance profile for EC2 
      instances.
    inputBinding:
      position: 102
      prefix: --awsEc2ProfileArn
  - id: boto
    type:
      - 'null'
      - File
    doc: The path to the boto credentials directory.
    inputBinding:
      position: 102
      prefix: --boto
  - id: cluster_type
    type:
      - 'null'
      - string
    doc: Cluster scheduler to use (mesos or kubernetes).
    inputBinding:
      position: 102
      prefix: --clusterType
  - id: force_docker_appliance
    type:
      - 'null'
      - boolean
    doc: Disables sanity checking the existence of the docker image specified by
      TOIL_APPLIANCE_SELF.
    default: false
    inputBinding:
      position: 102
      prefix: --forceDockerAppliance
  - id: key_pair_name
    type:
      - 'null'
      - string
    doc: On AWS, the name of the AWS key pair to include on the instance. On 
      Google/GCE, this is the ssh key pair.
    inputBinding:
      position: 102
      prefix: --keyPairName
  - id: leader_node_type
    type: string
    doc: Non-preemptible node type to use for the cluster leader.
    inputBinding:
      position: 102
      prefix: --leaderNodeType
  - id: leader_storage
    type:
      - 'null'
      - int
    doc: Specify the size (in gigabytes) of the root volume for the leader 
      instance.
    default: 50
    inputBinding:
      position: 102
      prefix: --leaderStorage
  - id: log_colors
    type:
      - 'null'
      - boolean
    doc: Enable or disable colored logging.
    default: true
    inputBinding:
      position: 102
      prefix: --logColors
  - id: log_critical
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Critical.
    inputBinding:
      position: 102
      prefix: --logCritical
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Debug.
    inputBinding:
      position: 102
      prefix: --logDebug
  - id: log_error
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Error.
    inputBinding:
      position: 102
      prefix: --logError
  - id: log_info
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Info.
    inputBinding:
      position: 102
      prefix: --logInfo
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the log level.
    default: INFO
    inputBinding:
      position: 102
      prefix: --logLevel
  - id: log_off
    type:
      - 'null'
      - boolean
    doc: Same as --logCRITICAL.
    inputBinding:
      position: 102
      prefix: --logOff
  - id: log_warning
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Warning.
    inputBinding:
      position: 102
      prefix: --logWarning
  - id: network
    type:
      - 'null'
      - string
    doc: GCE cloud network to use.
    inputBinding:
      position: 102
      prefix: --network
  - id: node_storage
    type:
      - 'null'
      - int
    doc: Specify the size (in gigabytes) of the root volume for any worker 
      instances created when using the -w flag.
    default: 50
    inputBinding:
      position: 102
      prefix: --nodeStorage
  - id: node_types
    type:
      - 'null'
      - string
    doc: Specifies a list of comma-separated node types.
    inputBinding:
      position: 102
      prefix: --nodeTypes
  - id: owner
    type:
      - 'null'
      - string
    doc: The owner tag for all instances.
    inputBinding:
      position: 102
      prefix: --owner
  - id: provisioner
    type:
      - 'null'
      - string
    doc: The provisioner for cluster auto-scaling (aws or gce).
    inputBinding:
      position: 102
      prefix: --provisioner
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files from getting too 
      big.
    default: false
    inputBinding:
      position: 102
      prefix: --rotatingLogging
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Tags are added to the AWS cluster for this node and all of its children.
      Tags are of the form: -t key1=value1'
    inputBinding:
      position: 102
      prefix: --tag
  - id: temp_dir_root
    type:
      - 'null'
      - Directory
    doc: Path to where temporary directory containing all temp files are 
      created.
    default: /tmp
    inputBinding:
      position: 102
      prefix: --tempDirRoot
  - id: use_private_ip
    type:
      - 'null'
      - boolean
    doc: if specified, ignore the public ip of the nodes
    default: false
    inputBinding:
      position: 102
      prefix: --use_private_ip
  - id: vpc_subnet
    type:
      - 'null'
      - string
    doc: VPC subnet ID to launch cluster leader in.
    inputBinding:
      position: 102
      prefix: --vpcSubnet
  - id: workers
    type:
      - 'null'
      - string
    doc: Comma-separated list of the ranges of numbers of workers of each node 
      type to launch.
    inputBinding:
      position: 102
      prefix: --workers
  - id: zone
    type:
      - 'null'
      - string
    doc: The availability zone of the leader.
    inputBinding:
      position: 102
      prefix: --zone
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
