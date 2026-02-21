The hwriter package

Gregoire Pau

April 8, 2022

1 Description

The package hwriter is an easy-to-use package able to format and output R
(from the R-project) objects in HTML format. It supports advanced format-
ting, tables, CSS styling, images and provides a convenient mapping between
R tables and HTML tables.
The project page is http://www.ebi.ac.uk/~gpau/hwriter.
The package provides the following functions (but most of the job is carried
out by hwrite):

• hwrite outputs an R object in HTML format.

• hwriteImage writes an image.

• openPage, closePage handles HTML page/document creation.

• hmakeTag is a low-level HTML tag formatting function.

All the functions are documented in the manual pages. Please check them
for reference.

2 Example

It is not easy to render what an HTML writing package could do in a PDF
document. The following example produces a local web page named example-
hwriter.html which contains many documented examples, all with R sources
and resulting HTML outputs.

1

> library('hwriter')
> example('hwriter')

hwriter:::showExample()

hwritr>
Building the example webpage /tmp/RtmprMhygU/example-hwriter.html ...
Opening a web browser on /tmp/RtmprMhygU/example-hwriter.html ...
OK. A web page showing all the examples should have been opened.

2

