"""
Author: Francis Charette-Migneault <francis.charette-migneault@crim.ca>
License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

Extracted from Open Science Persistent Demonstrator algae use-case code (https://osf.io/aujkb).
Added utilities to parse parameters from a command-line interface (CLI).
Added capabilities to filter and parse catalog results to obtain specific products.
"""
import sys

import argparse
import datetime
import requests
import json
from dateutil.parser import parse as dt_parse
from shapely.geometry import shape


def make_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="select-products-sentinel2",
        description=(
            "Searches a catalog for Sentinel-2 products using filtering parameters and returns all matched locations. "
            "Returned matches will be either S3 Product SAFE or HTTPS STAC Item references depending on the catalog."
        )
    )
    date_grp = parser.add_mutually_exclusive_group(required=True)
    date_grp.add_argument("--toi", type=str, nargs=2,
                          help="Time of interest as date-time strings for start and end dates.")
    date_grp.add_argument("--date", type=str,
                          help="Central date inside the days-delta to use for collection selection.")
    parser.add_argument("--delta", type=int, default=4,
                        help="Days delta ± around the specified date (default: %(default)s)")
    parser.add_argument("--aoi", type=argparse.FileType(mode="r", encoding="utf-8"), required=True,
                        help="Area of interest as GeoJSON polygon to find intersection of products.")
    parser.add_argument("--collection", type=str, required=True,
                        help="Name of the collection to search for imagery selection.")
    parser.add_argument("--product-level", choices=["L1C", "L2A"], required=False, default=None,
                        help="Level of the product to limit search results.")
    parser.add_argument("--catalog", choices=["copernicus", "earth-search"],
                        help="Catalog to employ for search of relevant image products.")
    parser.add_argument("--cloud-cover", required=False, default=None, type=float,
                        help="Maximum cloud coverage permitted for search.")
    return parser


def parse_date_time_range(ns: argparse.Namespace) -> tuple[str, str]:
    if ns.date:
        central_date = dt_parse(ns.date)
        start_date = central_date - datetime.timedelta(days=ns.delta)
        end_date = central_date + datetime.timedelta(days=ns.delta)
    elif ns.toi and len(ns.toi) == 2:
        start_date = dt_parse(ns.toi[0])
        end_date = dt_parse(ns.toi[1])
    else:
        raise ValueError("Could not parse date range from 'date/delta' or 'toi' arguments.")
    start_date = start_date.astimezone(datetime.timezone.utc).isoformat().split("+", 1)[0] + "Z"
    end_date = end_date.astimezone(datetime.timezone.utc).isoformat().split("+", 1)[0] + "Z"
    return start_date, end_date


def make_copernicus_product_url(ns: argparse.Namespace) -> list[str]:
    """
    Retrieve an URL for the SAFE product from Copernicus catalog.

    Copernicus supports STAC, but does not handle ``filter`` or ``query`` parameters as of 2014-02-22.
    Filtering is required for ``eo:cloud_cover`` property.
    Instead, use OData endpoint that provides support for a corresponding property.

    Copernicus does not provide direct URLs to product bands.
    Instead, retrieve the SAFE Manifest of the product, and parse it to retrieve band URLs.
    """
    start_date, end_date = parse_date_time_range(ns)
    aoi_polygon_geojson = json.load(ns.aoi)
    aoi_polygon_wkt = shape(aoi_polygon_geojson).wkt
    aoi = f"OData.CSC.Intersects(area=geography'SRID=4326;{aoi_polygon_wkt}')"
    date_interval = f"ContentDate/Start gt {start_date} and ContentDate/Start lt {end_date}"
    url = f"https://catalogue.dataspace.copernicus.eu/odata/v1/Products"
    col = f"Collection/Name eq '{ns.collection}'"
    request_url = f"{url}?$filter={aoi} and {date_interval} and {col}"
    if ns.product_level:
        request_url += f" and contains(Name,'{ns.product_level}')"
    if ns.cloud_cover is not None:
        cloud_cover = (
            " and Attributes/OData.CSC.DoubleAttribute/any(att:att/Name eq 'cloudCover' "
            f"and att/OData.CSC.DoubleAttribute/Value le {ns.cloud_cover})"
        )
        request_url += cloud_cover

    # using stderr to avoid interfering with processes
    # using 'stdout' to collect the resulting JSON array of S3 URLs
    print("Copernicus Product Search Request:\n", request_url, file=sys.stderr)

    data = requests.get(request_url, headers={"Accept": "application/json"}).json()
    s3_paths = [f"s3://{item['S3Path']}" for item in data["value"]]
    return s3_paths


def make_earth_search_product_url(ns: argparse.Namespace) -> list[str]:
    """
    Obtain the URLs of Sentinel-2 band products in GeoTiff from Earth Search catalog through STAC API request.
    """
    start_date, end_date = parse_date_time_range(ns)
    aoi_polygon_geojson = json.load(ns.aoi)
    aoi_polygon_bbox = shape(aoi_polygon_geojson)
    url = "https://earth-search.aws.element84.com/v1/search"
    body = {
        "collections": [ns.collection],
        "bbox": list(aoi_polygon_bbox.bounds),
        "datetime": f"{start_date}/{end_date}"
    }
    if ns.cloud_cover is not None:
        body["query"] = {"eo:cloud_cover": {"lt": ns.cloud_cover, "gt": 0}}

    resp = requests.post(url, json=body)
    urls = []
    for item in resp.json()["features"]:
        for link in item["links"]:
            if link["rel"] == "self":
                urls.append(link["href"])
                break
    return urls


def main() -> list[str]:
    parser = make_parser()
    ns = parser.parse_args()
    if ns.catalog == "copernicus":
        urls = make_copernicus_product_url(ns)
    elif ns.catalog == "earth-search":
        urls = make_earth_search_product_url(ns)

    print(json.dumps(urls))  # for packages that work using stdout capture
    return urls              # for applications calling the function directly


if __name__ == "__main__":
    main()
