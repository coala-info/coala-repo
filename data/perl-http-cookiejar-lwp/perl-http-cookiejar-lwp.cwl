cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-http-cookiejar-lwp
label: perl-http-cookiejar-lwp
doc: "A Perl module providing an LWP adapter for HTTP::CookieJar. (Note: The provided
  text is a system error log regarding container image retrieval and does not contain
  CLI help documentation or argument definitions.)\n\nTool homepage: https://github.com/dagolden/HTTP-CookieJar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-http-cookiejar-lwp:0.014--pl5321hdfd78af_0
stdout: perl-http-cookiejar-lwp.out
