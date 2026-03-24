#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import pytest

from download_band_sentinel2_product_safe import extract_band_location

CUR_DIR = os.path.dirname(__file__)


@pytest.mark.parametrize(
    ["manifest_file", "band", "resolution", "expect"],
    [
        (
            "S2A_MSIL1C_20190701T110621_N0207_R137_T29SPC_20190701T113552.SAFE/manifest.xml",
            "B03",
            "10m",
            "/tmp/GRANULE/L1C_T29SPC_A021012_20190701T111753/IMG_DATA/T29SPC_20190701T110621_B03.jp2",
        ),
        (
            "S2A_MSIL2A_20190701T110621_N0212_R137_T29SPC_20190701T120906.SAFE/manifest.xml",
            "B02",
            "10m",
            "/tmp/GRANULE/L2A_T29SPC_A021012_20190701T111753/IMG_DATA/R10m/T29SPC_20190701T110621_B02_10m.jp2",
        ),
        (
            "S2A_MSIL2A_20190701T110621_N0212_R137_T29SPC_20190701T120906.SAFE/manifest.xml",
            "B03",
            "10m",
            "/tmp/GRANULE/L2A_T29SPC_A021012_20190701T111753/IMG_DATA/R10m/T29SPC_20190701T110621_B03_10m.jp2",
        ),
        (
            "S2A_MSIL2A_20190701T110621_N0212_R137_T29SPC_20190701T120906.SAFE/manifest.xml",
            "B03",
            "60m",
            "/tmp/GRANULE/L2A_T29SPC_A021012_20190701T111753/IMG_DATA/R60m/T29SPC_20190701T110621_B03_60m.jp2",
        ),
        (
            "S2B_MSIL1C_20190629T112119_N0207_R037_T29SPC_20190629T123210.SAFE/manifest.xml",
            "B01",
            "60m",
            "/tmp/GRANULE/L1C_T29SPC_A012075_20190629T112256/IMG_DATA/T29SPC_20190629T112119_B01.jp2",
        ),
        (
            "S2B_MSIL1C_20190629T112119_N0207_R037_T29SPC_20190629T123210.SAFE/manifest.xml",
            "B09",
            "60m",
            "/tmp/GRANULE/L1C_T29SPC_A012075_20190629T112256/IMG_DATA/T29SPC_20190629T112119_B09.jp2",
        ),
        (
            "S2B_MSIL2A_20190629T112119_N0212_R037_T29SPC_20190629T132135.SAFE/manifest.xml",
            "B03",
            "10m",
            "/tmp/GRANULE/L2A_T29SPC_A012075_20190629T112256/IMG_DATA/R10m/T29SPC_20190629T112119_B03_10m.jp2",
        ),
        (
            "S2B_MSIL2A_20190629T112119_N0212_R037_T29SPC_20190629T132135.SAFE/manifest.xml",
            "B03",
            "20m",
            "/tmp/GRANULE/L2A_T29SPC_A012075_20190629T112256/IMG_DATA/R20m/T29SPC_20190629T112119_B03_20m.jp2",
        ),
        (
            "S2B_MSIL2A_20190629T112119_N0212_R037_T29SPC_20190629T132135.SAFE/manifest.xml",
            "B03",
            "60m",
            "/tmp/GRANULE/L2A_T29SPC_A012075_20190629T112256/IMG_DATA/R60m/T29SPC_20190629T112119_B03_60m.jp2",
        ),
    ]
)
def test_extract_band_locations(manifest_file, band, resolution, expect):
    manifest_path = os.path.join(CUR_DIR, manifest_file)
    result = extract_band_location(band, resolution, "/tmp", manifest_path)
    assert result == expect
