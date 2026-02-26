# ucsc-htmlcheck CWL Generation Report

## ucsc-htmlcheck_htmlCheck

### Tool Description
Do a little reading and verification of html file

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-htmlcheck:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-htmlcheck/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-htmlcheck/overview
- **Total Downloads**: 17.9K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
htmlCheck - Do a little reading and verification of html file
usage:
   htmlCheck how url
where how is:
   ok - just check for 200 return.  Print error message and exit -1 if no 200
   getAll - read the url (header and html) and print to stdout
   getHeader - read the header and print to stdout
   getCookies - print list of cookies
   getHtml - print the html, but not the header to stdout
   getForms - print the form structure to stdout
   getVars - print the form variables to stdout
   getLinks - print links
   getTags - print out just the tags
   checkLinks - check links in page
   checkLinks2 - check links in page and all subpages in same host
             (Just one level of recursion)
   checkLocalLinks - check local links in page
   checkLocalLinks2 - check local links in page and connected local pages
             (Just one level of recursion)
   submit - submit first form in page if any using 'GET' method
   validate - do some basic validations including TABLE/TR/TD nesting
   strictTagNestCheck - check tags are correctly nested
options:
   cookies=cookie.txt - Cookies is a two column file
           containing <cookieName><space><value><newLine>
   withSrc - causes the get and checkLinks commands to also include SRC= links.
note: url will need to be in quotes if it contains an ampersand or question mark.
```

