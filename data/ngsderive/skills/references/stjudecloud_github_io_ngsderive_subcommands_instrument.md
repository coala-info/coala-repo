[ngsderive](../..)

* [Home](../..)
* Subcommands
  + [strandedness](../strandedness/)
  + [instrument](./)
  + [readlen](../readlen/)
  + [encoding](../encoding/)
  + [junction-annotation](../junction_annotation/)

* Search
* [Previous](../strandedness/)
* [Next](../readlen/)
* [Edit on GitHub](https://github.com/stjudecloud/ngsderive/edit/master/docs/subcommands/instrument.md)

* [instrument](#instrument)
  + [Limitations](#limitations)

# instrument

The `instrument` subcommand will attempt to backward compute the machine that generated a NGS file using (1) the instrument id(s) and (2) the flowcell id(s).

## Limitations

* This command may not comprehensively detect the correct machines as there is no published catalog of Illumina serial numbers. As we encounter more serial numbers in practice, we update this code.

---

© 2020 St. Jude Children's Research Hospital

Documentation built with [MkDocs](https://www.mkdocs.org/).

#### Search

×Close

From here you can search these documents. Enter your search terms below.

#### Keyboard Shortcuts

×Close

| Keys | Action |
| --- | --- |
| `?` | Open this help |
| `n` | Next page |
| `p` | Previous page |
| `s` | Search |