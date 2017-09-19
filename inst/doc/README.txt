This folder to accompany the utc2nwislocal R package contains the
R code used to generate the sysdata.rda file that resides in the
/R folder. The R code is in file buildSYSDATA(R).txt, which will
read the file NWIStzCodes.txt.

In turn that file originally came from the XLSX file of the same
name that is also in this directory, and again in turn, the file
was near verbatim derived from a tab-delimited file pulled
by Ron Seanor from the U.S. Geological Survey National Water
Information System (NWIS).

The primary change was the population of missing fields with "--".
The author reports challenges in one or more of the UTC offset
fields for the Newfoundland zones in which the spreadsheet
mysteriously mudged "-NN:NN" fields into numbers and not strings.
It is advised to import into a spreadsheet as text columns when
updating the sysdata.rda file.
