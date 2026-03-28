[![AlphaFill logo](/images/alphafill-logo.svg)](/)

[NKI Research](http://www.nki.nl) |
[Perrakis
group](http://www.nki.nl/divisions/biochemistry/perrakis-a-group/)

* [Home](/)
* [Structures](/structures)
* [Compounds](/compounds)
* [Model](/model)
* [About](/about)
* [Download](/download)
* [Manual](/manual/)

An individual AlphaFill entry can be downloaded via the REST interface. Structure files in mmCIF format are
available at

> `https://alphafill.eu/v1/aff/${entryid}`.

JSON files with the meta data for the transplants are available at

> `https://alphafill.eu/v1/aff/${entryid}/json`

The complete AlphaFill databank can be downloaded by means of rsync through

`rsync -av rsync://rsync.alphafill.eu/alphafill/ alphafill/`

The JSON-schema providing details on the metadata can be found [here](alphafill.json.schema)

[Here](/license) you can find the data usage license.

Maarten L. Hekkelman, Ida de Vries, Robbie P. Joosten & Anastassis Perrakis
Department of Biochemistry, B8
Plesmanlaan 121, 1066CX Amsterdam