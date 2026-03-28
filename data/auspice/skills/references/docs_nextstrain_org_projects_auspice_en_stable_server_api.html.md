[![Logo](../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Auspice](../index.html)

Introduction

* [Install Auspice](../introduction/install.html)
* [How to Run Auspice](../introduction/how-to-run.html)

Functionality

* [Displaying multiple trees](../advanced-functionality/second-trees.html)
* [View Settings](../advanced-functionality/view-settings.html)
* [Adding extra metadata via CSV/TSV/XLSX](../advanced-functionality/drag-drop-csv-tsv.html)
* [Streamtrees](../advanced-functionality/streamtrees.html)
* [Miscellaneous](../advanced-functionality/misc.html)

Customising Auspice

* [Overview (Client)](../customise-client/overview.html)
* [Client Customisation API](../customise-client/api.html)
* [Requests Made from the Client](../customise-client/requests.html)

Auspice servers

* [Overview (Server)](overview.html)
* Server API
* [Authentication](authentication.html)

Releases

* [Releases](../releases/index.html)
  + [Changelog](../releases/changelog.html)
  + [Auspice Version 2.0](../releases/v2.html)

* [Stuck? Ask us on the discussion board. We're happy to help!](https://discussion.nextstrain.org/)

[Auspice](../index.html)

* [Home](https://docs.nextstrain.org)
* [Auspice](../index.html)
* [View page source](../_sources/server/api.rst.txt)

---

# Server API[](#server-api "Link to this heading")

## Auspice client requests[](#auspice-client-requests "Link to this heading")

The Auspice server handles requests to 3 API endpoints made by the Auspice client:

* `/charon/getAvailable` (returns a list of available datasets and narratives)
* `/charon/getDataset` (returns the requested dataset)
* `/charon/getNarrative` (returns the requested narrative)

### `/charon/getAvailable`[](#server-api-charon-getavailable "Link to this heading")

**URL query arguments:**

* `prefix` (optional) - the pathname of the requesting page in Auspice. The `getAvailable` handler can use this to respond according appropriately. Unused by the default Auspice handler.

**JSON Response (on success):**

```
{
  "datasets": [
    {
      "request": "[required] The pathname of a valid dataset. \
          Will become the prefix of the getDataset request.",
      "buildUrl": "[optional] A URL to display in the sidebar representing \
          the build used to generate this analysis.",
      "secondTreeOptions": "[optional] A list of requests which should \
          appear as potential second-trees in the sidebar dropdown"
    },
    // ...
  ],
  "narratives": [
    {"request": "URL of a narrative. Will become the prefix in a getNarrative request"},
    // ...
  ]
}
```

Failure to return a valid JSON will result in a warning notification shown in Auspice.

### `/charon/getDataset`[](#charon-getdataset "Link to this heading")

**URL query arguments:**

* `prefix` (required) - the pathname of the requesting page in Auspice. Use this to determine which dataset to return.
* `type` (optional) – if specified, then the request is for an additional file (e.g. “tip-frequencies”), not the main dataset.

**JSON Response (on success):**

The JSON response depends on the file-type being requested.

If the type is not specified, i.e. we’re requesting the “main” dataset JSON then [see this JSON schema](https://github.com/nextstrain/augur/blob/master/augur/data/schema-export-v2.json). Note that the Auspice client *cannot* process v1 (meta / tree) JSONs – [see below](#server-api-importing-code-from-auspice) for how to convert these.

Alternative file type reponses are to be documented.

**Alternative responses:**

A `204` reponse will cause Auspice to show its splash page listing the available datasets & narratives. Any other non-200 reponse behaves similarly but also displays a large “error” message indicating that the dataset was not valid.

### `/charon/getNarrative`[](#server-api-charon-getnarrative "Link to this heading")

**URL query arguments:**

* `prefix` (required) - the pathname of the requesting page in Auspice. Use this to determine which narrative to return.
* `type` (optional) - the format of the data returned (see below for more information). Current valid values are “json” and “md”. If no type is specified the server will use “json” as a default (for backwards compatibility reasons). Requests to this API from the Auspice client are made with `type=md`.

**Response (on success):**

The response depends on the `type` specified in the query.

If a markdown format is requested, then the narrative file is sent to the client unmodified to be parsed on the client.

If a JSON is requested then the narrative file is parsed into JSON format by the server. For Auspice versions prior to v2.18 this was the only expected behavior. The transformation from markdown (i.e. the narrative file itself) to JSON is via the `parseNarrativeFile()` function (see below for how this is exported from Auspice for use in other servers). Here, roughly, is the code we use in the auspice server for this transformation:

```
const fileContents = fs.readFileSync(pathName, 'utf8');
if (type === "json") {
  const blocks = parseNarrative(fileContents);
  res.send(JSON.stringify(blocks).replace(/</g, '\\u003c'));
}
```

Note

While the Auspice client (from v2.18 onwards) always requests the `type=md`, it will attempt to parse the response as JSON if markdown parsing fails, in an effort to remain backwards compatible with servers which may be using an earlier API.

---

## Supplying custom handlers to the Auspice server[](#server-api-supplying-custom-handlers "Link to this heading")

The provided Auspice servers – i.e. `auspice view` and `auspice develop` both have a `--handlers <JS>` option which allows you to define your own handlers. The provided JavaScript file must export three functions, each of which handles one of the GET requests described above and must respond accordingly (see above for details).

| function name | arguments | API endpoint |
| --- | --- | --- |
| getAvailable | req, res | /charon/getAvailable |
| getDataset | req, res | /charon/getDataset |
| getNarrative | req, res | /charon/getNarrative |

For information about the `req` and `res` arguments see the express documentation for the [request object](https://expressjs.com/en/api.html#req) and [response object](https://expressjs.com/en/api.html#res), respectively.

You can see [nextstrain.org](https://nextstrain.org)’s implementation of these handlers [here](https://github.com/nextstrain/nextstrain.org/tree/HEAD/src/app.js).

Here’s a pseudocode example of an implementation for the `getAvailable` handler which may help understanding:

```
const getAvailable = (req, res) => {
  try {
    /* collect available data */
    res.json(data);
  } catch (err) {
    const errorMessage = `error message to display in client`;
    console.log(errorMessage); /* printed by the server, not the client */
    return res.status(500).type("text/plain").send(errorMessage);
  }
};
```

---

## Importing code from Auspice[](#server-api-importing-code-from-auspice "Link to this heading")

The servers included in Auspice contain lots of useful code which you may want to use to either write your own handlers or entire servers. For instance, the code to convert v1 dataset JSONs to v2 JSONs (which the client requires) can be imported into your code so you don’t have to reinvent the wheel!

Currently

```
const auspice = require("auspice");
```

returns an object with two properties:

### `convertFromV1`[](#server-api-convertfromv1 "Link to this heading")

**Signature:**

```
const v2json = convertFromV1({tree, meta})
```

where `tree` is the v1 tree JSON, and `meta` the v1 meta JSON.

**Returns:**

An object representing the v2 JSON [defined by this schema](https://github.com/nextstrain/augur/blob/master/augur/data/schema-export-v2.json).

### `parseNarrativeFile`[](#parsenarrativefile "Link to this heading")

Warning

This function is deprecated as of vXXX. You can now send the untransformed contents of the narrative file (markdown) for client-side parsing. See [above](#server-api-charon-getnarrative) for more details.

**Signature:**

```
const blocks = parseNarrativeFile(fileContents);
```

where `fileContents` is a string representation of the narrative Markdown file.

**Returns:**

An array of objects, each entry representing a different narrative “block” or “page”. Each object has properties

* `__html` – the HTML to render in the sidebar to form the narrative
* `dataset` – the dataset associated with this block
* `query` – the query associated with this block

[Previous](overview.html "Overview (Server)")
[Next](authentication.html "Authentication")

---

Hadfield *et al.,*
[Nextstrain: real-time tracking of pathogen evolution](https://doi.org/10.1093/bioinformatics/bty407)
*, Bioinformatics* (2018)

The core Nextstrain team is

[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/trevor-bedford.jpg)
Trevor Bedford](http://bedford.io/team/trevor-bedford/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/richard-neher.jpg)
Richard Neher](https://neherlab.org/richard-neher.html)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/ivan-aksamentov.jpg)
Ivan Aksamentov](https://neherlab.org/ivan-aksamentov.html)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/kim-andrews.jpg)
Kim Andrews](https://bedford.io/team/kim-andrews/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/jennifer-chang.jpg)
Jennifer Chang](https://bedford.io/team/jennifer-chang/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/james-hadfield.jpg)
James Hadfield](http://bedford.io/team/james-hadfield/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/emma-hodcroft.jpg)
Emma Hodcroft](http://emmahodcroft.com/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/john-huddleston.jpg)
John Huddleston](http://bedford.io/team/john-huddleston/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/jover-lee.jpg)
Jover Lee](http://bedford.io/team/jover-lee/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/victor-lin.png)
Victor Lin](https://bedford.io/team/victor-lin/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/cornelius-roemer.jpg)
Cornelius Roemer](https://neherlab.org/cornelius-roemer.html)

Please see the [team page](https://nextstrain.org/team) for more details.

All [source code for Nextstrain](https://github.com/nextstrain) is freely available under the terms of an [open-source license](https://opensource.org/osd), typically [AGPL-3.0](https://opensource.org/licenses/AGPL-3.0) or [MIT](https://opensource.org/licenses/MIT).
Refer to specific projects for details.
Screenshots may be used under a [CC-BY-4.0 license](https://creativecommons.org/licenses/by/4.0/) and attribution to nextstrain.org must be provided.

This work is made possible by the open sharing of genetic data by research groups from all over the world.
We gratefully acknowledge their contributions.
Special thanks to Kristian Andersen, Josh Batson, David Blazes, Jesse Bloom, Peter Bogner, Anderson Brito, Matt Cotten, Ana Crisan, Tulio de Oliveira, Gytis Dudas, Vivien Dugan, Karl Erlandson, Nuno Faria, Jennifer Gardy, Nate Grubaugh, Becky Kondor, Dylan George, Ian Goodfellow, Betz Halloran, Christian Happi, Jeff Joy, Paul Kellam, Philippe Lemey, Nick Loman, Duncan MacCannell, Erick Matsen, Sebastian Maurer-Stroh, Placide Mbala, Danny Park, Oliver Pybus, Andrew Rambaut, Colin Russell, Pardis Sabeti, Katherine Siddle, Kristof Theys, Dave Wentworth, Shirlee Wohl and Cecile Viboud for comments, suggestions and data sharing.

---

[![Logo of the Fred Hutch](../_static/logos/fred-hutch-logo-small.png)](http://www.fredhutch.org/)
[![Logo of the Swiss Institute of Bioinformatics](../_static/logos/sib-logo.png)](http://www.sib.swiss/)
[![Logo of the National Institutes of Health](../_static/logos/nih-logo.jpg)](https://www.nih.gov/)
[![Logo of Mapbox](../_static/logos/mapbox-logo-black.svg)](https://www.mapbox.com)
[![Logo of the University of Basel](../_static/logos/unibas-logo.svg)](https://unibas.ch/)
[![Logo of the Open Science Prize](../_static/logos/osp-logo-small.png)](https://www.nih.gov/news-events/news-releases/open-science-prize-announces-epidemic-tracking-tool-grand-prize-winner)
[![Logo of the Biozentrum](../_static/logos/bz_logo.png)](http://biozentrum.org/)

© Copyright 2020, James Hadfield, Trevor Bedford and Richard Neher

Built with [Sphinx](https://www.sphinx-doc.org/)
using [our customised version](https://github.com/nextstrain/sphinx-theme) of a
[base theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by
[Read the Docs](https://readthedocs.org).