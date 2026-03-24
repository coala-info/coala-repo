"""
Author: Francis Charette-Migneault <francis.charette-migneault@crim.ca>
License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

Developed in the context of Open Science Persistent Demonstrator algae use-case code (https://osf.io/aujkb).
"""
import argparse
import requests
import os


def make_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="download-band-sentinel2-stac-item",
        description="Downloads a Sentinel-2 product band from a STAC Item reference."
    )
    parser.add_argument("--stac-item-url", type=str, required=True,
                        help="HTTPS URL to a STAC ITem product reference.")
    parser.add_argument("--band", required=True, choices=[
        "B01",
        "B02",
        "B03",
        "B04",
        "B05",
        "B06",
        "B07",
        "B08",
        "B8A",
        "B09",
        "B11",
        "B12",
        "AOT",
        "SCL",
        "TCI",
        "WVP",
    ], help="Band to download.")
    return parser


def map_band_shortname(band: str) -> str:
    band_mapping = {
        "B01": "coastal",
        "B02": "blue",
        "B03": "green",
        "B04": "red",
        "B05": "rededge1",
        "B06": "rededge2",
        "B07": "rededge3",
        "B08": "nir",
        "B8A": "nir08",
        "B09": "nir09",
        "B11": "swir16",
        "B12": "swir22",
        "AOT": "aot",
        "SCL": "scl",
        "TCI": "visual",
        "WVP": "wvp",
    }
    # note:
    #  appending '-jp2' would get equivalent bands in 'image/jp2', but 's3://' endpoints are obtained
    #  instead, use the HTTPS endpoints which are publicly available
    return band_mapping[band]


def download_stac_item_band(stac_item_url: str, band: str) -> str:
    resp = requests.get(stac_item_url)
    assets = resp.json()["assets"]
    asset_band = map_band_shortname(band)
    band_url = assets[asset_band]["href"]
    band_path = os.path.join(os.getcwd(), os.path.basename(band_url))
    with requests.get(band_url, stream=True) as band_resp:
        band_resp.raise_for_status()
        with open(band_path, mode="wb") as band_fd:
            for chunk in band_resp.iter_content(chunk_size=10 * 1024):
                band_fd.write(chunk)
    return band_path


def main() -> str:
    parser = make_parser()
    ns = parser.parse_args()
    band_file = download_stac_item_band(ns.stac_item_url, ns.band)

    print(band_file)  # for packages that work using stdout capture
    return band_file  # for applications calling the function directly


if __name__ == "__main__":
    main()
