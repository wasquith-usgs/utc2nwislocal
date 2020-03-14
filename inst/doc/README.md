# README (./utc2niwslocal/inst/doc/README.md)

#### Author:           William H. Asquith
#### Point of contact: William H. Asquith (wasquith@usgs.gov)

***
***

# DISCUSSION

This folder to accompany the **utc2nwislocal** _R_ package contains the _R_ code (R Development Core Team, 2020) used to generate the `sysdata.rda` file that resides in the `./utc2nwislocal/R` directory. The _R_ code is contained in file `buildSYSDATA(R).txt`, which will read the plain-text pipe-delimited file `NWIStzCodes.txt` of 53 time zones that is provided in this (`./utc2nwislocal/inst/doc/`) directory.

The `NWIStzCodes.txt` file originally came from the `.xlsx` spreadsheet file of the same name that is also in this directory, and again in turn, the file was near verbatim derived from a tab-delimited file acquired from the U.S. Geological Survey National Water Information System (NWIS) (U.S. Geological Survey, 2019) time zone table through **utc2nwislocal** package co-author Ronald C. Seanor as a USGS database administrator in July, 2017 (https://help.waterdata.usgs.gov/code/tz_query?fmt=html) [accessed October 22, 2019] (https://help.waterdata.usgs.gov/code/water_level_dtacy_cd_query?fmt=html) [accessed October 22, 2019].

The primary modification by the author to create the `NWIStzCodes.txt` was the population of missing fields with the character string "--". The author reports challenges in one or more of the Coordinated Universal Time (UTC) offset fields for the Newfoundland time zones in which the spreadsheet mysteriously muddled "-NN:NN" fields into numbers and not strings. It is advised to import into a spreadsheet that data as text columns when, if ever needed, updating the `./utc2nwislocal/R/sysdata.rda` file.

# REFERENCES

R Development Core Team, 2020, R---A language and environment for statistical computing, R Foundation for Statistical Computing, Vienna, Austria, version 3.6.3, accessed on March 10, 2020, at https://www.R-project.org.

U.S. Geological Survey, 2019, USGS water data for the Nation: U.S. Geological Survey National Water Information System database, accessed August 9, 2019, at https://doi.org/10.5066/F7P55KJN.
