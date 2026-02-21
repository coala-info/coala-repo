cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-task-weaken
label: perl-task-weaken
doc: "Task::Weaken - ensure that Scalar::Util's weaken is available\n\nTool homepage:
  http://metacpan.org/pod/Task-Weaken"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-task-weaken:1.06--pl526_0
stdout: perl-task-weaken.out
