# [chemfp](https://chemfp.com/index.html)

* [Features](https://chemfp.com/features/)
* [Download](https://chemfp.com/download/)
* [Datasets](https://chemfp.com/datasets/)
* [License](https://chemfp.com/license/)
* [News](https://chemfp.com/news/)
* [Contact](https://chemfp.com/contact/)

* [High Performance Search](/performance/)
* [FPS Format](/fps_format/)
* [FPB Format](/fpb_format/)
* [FPC Format](/fpc_format/)
* [• Datasets](/datasets/)
* [Multiple Toolkit Support](/toolkits/)
* [Documentation:](/docs/)
* [• Command-line Tools](/docs/tools.html)
* [• Python API](/docs/chemfp_api.html)
* [• Example Programs](https://hg.sr.ht/~dalke/chemfp_examples)

## Supported toolkits

Chemfp is a fingerprint toolkit with an extensive [Python
API](/docs/chemfp_api.html). It
depends on a third-party chemistry toolkit to generate fingerprints
from a chemical structure. The currently supported toolkits are
OEChem/OEGraphSim, RDKit, Open Babel, and CDK.

The latest versions of each toolkit are supported, as well as the
previous several releases.

## Command-line support for different toolkits

The toolkit integration occurs at multiple levels.

At the command-line level you can use
[oe2fps](/docs/oe2fps_command.html),
[rdkit2fps](/docs/rdkit2fps_command.html),
[ob2fps](/docs/ob2fps_command.html),
and
[cdk2fps](/docs/cdk2fps_command.html),
to generate toolkit-specific fingerprints from SMILES file, SDF, or
other chemistry structure format, and save the result to chemfp's FPS
or FPB formats. (The FPB format is only supported in the commercial
version of chemfp.)

## Cross-toolkit API

These tools are built using a [common cross-platform
API](/docs/toolkit.html), which is
part of the public chemfp API. If you are a Python programmer, you can
use it for your own tools.

The toolkit wrappers provide a consistent API for reading and writing
structure files, parsing and creating structure records, and for
[fingerprint
generation](/docs/fingerprint_types.html). This
might not be that important if you only deal with one toolkit, but
it's very handy if you want to handle or switch between multiple
toolkits in your software.

Take a look for yourself at the wrapper APIs for
[CDK](/docs/chemfp_cdk_toolkit.html)
[OpenEye's OEChem](/docs/chemfp_openeye_toolkit.html)
[Open Babel](/docs/chemfp_openbabel_toolkit.html)
and
[RDKit](/docs/chemfp_rdkit_toolkit.html)

## Example fingerprint search web service

The [Toolkit API
examples](/docs/toolkit.html)
section of the documentation contains many examples of how to use the
toolkit API.

For an example to get you started, here's a small program named
"fpsearch.py" which uses the [flask](https://flask.palletsprojects.com/)
microframework to implement a web service that finds the nearest 10
ChEMBL matches to a query SMILES. It uses only the chemfp APIs, which
means it will work with any of the supported fingerprint types and
toolkits.

```
# Save this as "fpsearch.py"
from flask import Flask, request, abort, Response

import chemfp

# Load the database, and use the 'type' metadata to figure out which
# toolkit and which fingerprint parameters to use.
db = chemfp.load_fingerprints("chembl_34.fpb")
fptype = db.get_fingerprint_type()
T = fptype.toolkit

app = Flask(__name__)

@app.route("/search")
def search():
    # Get the 'q' query parameter and try to process it as a SMILES string.
    smiles = request.args.get("q", None)
    if smiles is None:
        abort(Response("Missing 'q' parameter"))

    # Temporarily disable toolkit logging messages
    with T.suppress_log_output():
        fp = fptype.from_smistring(smiles, errors="ignore")

    if fp is None:
        abort(Response("Cannot parse 'q' parameter as a SMILES"))

    # Search the database and report the 10 nearest hits.
    result = db.knearest_tanimoto_search_fp(fp, k=10, threshold=0.0)
    ids_and_scores = result.get_ids_and_scores()
    response = "".join(f"{score:.3f},{id}\n" for (id, score) in ids_and_scores)
    return Response(response, content_type="text/plain")
```

To make it work:

1. Install the flask framework with `pip install flask`
2. Download and uncompress the
   [pre-generated fingerprints for ChEMBL 34](https://chemfp.com/datasets/chembl_34.fpb.gz),
   for example, with the following:

   * curl -O https://chemfp.com/datasets/chembl\_34.fpb.gz
   * gunzip chembl\_34.fpb.gz
3. Save the above program as `fpsearch.py`.
4. set the environment variable FLASK\_APP to "fpsearch.py", eg,

   * `export FLASK_APP=fpsearch.py`
5. In the directory containing `fpsearch.py`, run the command "`flask
   run`" to start the server.
6. With your web browser, go to: <http://127.0.0.1:5000/search?q=c1ccccc1N>

You should see output like:

```
1.000,CHEMBL538
0.917,CHEMBL3182415
0.625,CHEMBL44201
0.588,CHEMBL3185160
0.583,CHEMBL403741
0.579,CHEMBL3392014
0.538,CHEMBL3561416
0.533,CHEMBL1595914
0.526,CHEMBL572203
0.526,CHEMBL69011
```

The file "chemfp\_34.fpb" derives from the
[FPS files](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/releases/chembl_34/chembl_34.fps.gz)
distributed as part of
[ChEMBL 34](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/releases/chembl_34). They
are RDKit Morgan fingerprints with the fingerprint type
`RDKit-Morgan/1 radius=2 fpSize=2048 useFeatures=0 useChirality=0
useBondTypes=1`.

In addition, I embedded a
[special database license key](https://chemfp.com/datasets/) in the
FPB file that unlocks chemfp functionality that otherwise requires a
chemfp license key.

What makes the chemfp API useful is that I could replace the FPB file
with, say, the OpenEye circular fingerprints, restart the server, and
the search service will switch from using RDKit to OEChem and
OEGraphSim - with no other changes to the code.

Copyright © 2012-2025 Andrew Dalke Scientific AB