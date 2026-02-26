cwlVersion: v1.2
class: CommandLineTool
baseCommand: htmlCheck
label: ucsc-htmlcheck_htmlCheck
doc: "Do a little reading and verification of html file\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: how
    type: string
    doc: "how is: ok - just check for 200 return. Print error message and exit -1
      if no 200; getAll - read the url (header and html) and print to stdout; getHeader
      - read the header and print to stdout; getCookies - print list of cookies; getHtml
      - print the html, but not the header to stdout; getForms - print the form structure
      to stdout; getVars - print the form variables to stdout; getLinks - print links;
      getTags - print out just the tags; checkLinks - check links in page; checkLinks2
      - check links in page and all subpages in same host (Just one level of recursion);
      checkLocalLinks - check local links in page; checkLocalLinks2 - check local
      links in page and connected local pages (Just one level of recursion); submit
      - submit first form in page if any using 'GET' method; validate - do some basic
      validations including TABLE/TR/TD nesting; strictTagNestCheck - check tags are
      correctly nested"
    inputBinding:
      position: 1
  - id: url
    type: string
    doc: url will need to be in quotes if it contains an ampersand or question 
      mark.
    inputBinding:
      position: 2
  - id: cookies
    type:
      - 'null'
      - File
    doc: Cookies is a two column file containing 
      <cookieName><space><value><newLine>
    inputBinding:
      position: 103
  - id: with_src
    type:
      - 'null'
      - boolean
    doc: causes the get and checkLinks commands to also include SRC= links.
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-htmlcheck:482--h0b57e2e_0
stdout: ucsc-htmlcheck_htmlCheck.out
