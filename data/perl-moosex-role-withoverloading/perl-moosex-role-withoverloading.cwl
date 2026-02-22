cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-role-withoverloading
label: perl-moosex-role-withoverloading
doc: "MooseX::Role::WithOverloading - Roles which support overloading (Note: The provided
  text contains system error messages rather than help documentation).\n\nTool homepage:
  https://github.com/moose/MooseX-Role-WithOverloading"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-moosex-role-withoverloading:0.17--pl5321h9948957_6
stdout: perl-moosex-role-withoverloading.out
