# utc2nwislocal—UTC Date-Times to NWIS Local Time Zones using UTC Offsets
<img src='inst/www/standard_time_zones_of_the_world.jpg' height='300' align="right" />

#### Author:           William H. Asquith, Ronald C. Seanor
#### Point of contact: William H. Asquith (wasquith@usgs.gov)
#### Repository Type:  Formal _R_ language package
#### Year of Origin:   2020 (original publication)
#### Year of Version:  2020
#### Version:          [1.0.1](https://code.usgs.gov/water/utc2nwislocal/-/tags/v1.0.1)
#### Digital Object Identifier (DOI): https://doi.org/10.5066/P9UMT1O2
#### USGS Information Product Data System (IPDS) no.: IP–113254 (internal agency tracking)

***

_Suggested Citation:_

Asquith, W.H., and Seanor, R.C., 2020, utc2nwislocal—UTC date-times to NWIS local time zones using UTC offsets: R package, U.S. Geological Survey software release, Reston, Va., https://doi.org/10.5066/P9UMT1O2.
[https://code.usgs.gov/water/utc2nwislocal]

_Authors' [ORCID](https://orcid.org) nos.:_
William H. Asquith, [0000-0002-7400-1861](https://orcid.org/0000-0002-7400-1861);
Ronald C. Seanor, [0000-0001-5735-5580](https://orcid.org/0000-0001-5735-5580).

***
***

# DESCRIPTION

The **utc2nwislocal** package in the _R_ language (R Development Core Team, 2020) provides a light-weight, dependency-free utility for converting Coordinated Universal Time (UTC) `base::as.POSIXct()` date-time values into character-string representations for time zones. The package is approved as an official USGS software release (see `./inst/USGSapproval20200321.pdf`).

The UTC offsets for individual time zones are determined from the time-zone codes recognized by the U.S. Geological Survey National Water Information System (NWIS) (U.S. Geological Survey, 2019). The time zones are tracked in a separate database slot than the UTC date-time. Sometimes it can be difficult to force the _R_ language to work with time zones in ways that some developers might desire. This package can help users working with some NWIS data sets.

The justification for this package is that the time-zone codes are not standard to the `base::OlsonNames()` within base _R_, but the NWIS names are an ANSI SQL/92 time-zone offset string. American National Standards Institute (ANSI) SQL/92 was the third revision of the Structured Query Language (SQL) database query language. NWIS stores date-times exclusively in UTC, and certain data retrievals can be (purposefully) kept in UTC, though commonly NWIS switches to the users local or the USGS data collection site local time zone in output.

The package resides on the link shown in the _Suggested Citation_. Please consult this README along with other files (`CONTRIBUTING.md`, `DISCLAIMER.md`, `LICENSE.md`).

## Example of Use

One of the primary interfaces is the `utc2nwislocal()` function. In the following example, UTC is transformed to Pacific Daylight Time (PDT):
```{r}
  utc2nwislocal(as.POSIXct("2016-07-14 15:30:00"), tz="PDT", "m", secpad=FALSE)
  # [1] "2016-07-14 08:30 PDT"
```

United States Pacific Daylight Time (PDT) is -07:00 hours behind UTC. Pacific Daylight Time (PDT) replaces Pacific Standard Time during summer when daylight savings comes into effect. Pacific Standard Time is a UTC -8:00 time-zone offset, which means that the Pacific Standard Time is -8:00 hours ahead of UTC.

Two other interfaces are acquiring the hour and second offsets from UTC. The first example is for Australia Eastern Standard Time that is +11:00 hours ahead of UTC. The second example is for United States Central Daylight Time (CDT) and Central Standard Time (CST) and shows that the functions are vectorized.
```{r}
  nwislocal2utc_offset_hours("AESST")          # 11:00 hours
  nwislocal2utc_offset_seconds(c("CDT","CST")) # -18000, -21600 seconds
  nwislocal2utc_offset_seconds("Asquith")      # NA, There is no Asquith time zone.
```

# PACKAGE INSTALLATION

To get release updates, the package can be reinstalled using one of those example commands. The install commands below require the **remotes** package to be installed (`install.packages(“remotes”)`):

```{r}
  library(remotes)
  # Option 1
  install_git("https://code.usgs.gov/water/utc2nwislocal.git")

  # Option 2
  install_url("https://code.usgs.gov/water/utc2nwislocal/-/archive/master/utc2nwislocal.zip")

  # Option 3
  install_gitlab("water/utc2nwislocal", host="https://code.usgs.gov/")
```


## Further Installation Details

The design of this package is to be compliant with the requirements of the Comprehensive R Archive Network (CRAN) (accessed October 1, 2019 at https://cran.r-project.org). The **utc2nwislocal** package itself however is of too narrow focus for simultaneous distribution through the CRAN. Hence, the standard idioms to the language for package compliance testing, installation, and user manual building can be made by (at least on non-Windows platforms), respectively, the following commands at the operating system console:
```{r}
  R CMD check --as-cran utc2nwislocal
  R CMD INSTALL utc2nwislocal
  R CMD Rd2pdf --force utc2nwislocal
  R CMD check --as-cran --run-donttest utc2nwislocal; # potentially more rigorous checking
```
More details and background related to the **utc2nwislocal** package including its historical context, purpose, use, and demonstration of features are found within the user manual. The package checks are typically done on a `utc2nwislocal_*.tar.gz` that is a file resulting from the command: `R CMD build utc2nwislocal`.

In particular, the _R_ documentation file `man/utc2nwislocal.Rd` is the canonical starting point, and that starting point can be initiated after package installation through the following commands at the _R_ prompt:
```{r}
  library(utc2nwislocal)
  ?"utc2nwislocal"
```
A copy of the user manual built by `R CMD Rd2pdf` as shown previously and renamed is  [file](https://code.usgs.gov/water/utc2nwislocal/blob/master/inst/doc/UserManual.pdf) `./inst/doc/UserManual.pdf`. The user manual is provided within the source code repository for convenience because this package is not hosted by the CRAN.

The most critical component of the package is the hidden _R_ environment `.NWIStzUTC` provided by the `./utc2nwislocal/R/sysdata.rda` file, which was created by the script `./utc2nwislocal/inst/doc/buildSYSDATA(R).txt`. (The script is given a `.txt` file extension to keep _R_ from complaining when the **utc2nwislocal** package is checked for CRAN compliance.)

The `.NWIStzUTC` environment is not exported but forced access can be used if users are very curious: `utc2nwislocal:::.NWIStzUTC` (triple colon). This environment contains three subordinate environments that are hash-tabled lookups of time zones and their corresponding UTC offsets. Below are some examples for inspecting, by the `ls()` function, the table contents:
```{r}
  ls(utc2nwislocal:::.NWIStzUTC) # results shown below
  # [1] "TimeZone_Names"     "TimeZone_Offset"     "TimeZone_Offset_seconds"
  ls(utc2nwislocal:::.NWIStzUTC$TimeZone_Names) # results shown below
  #  [1] "ACSST"  "ACST"   "ADT"    "AESST"  "AEST"   "AFT"    "AKDT"   "AKST"
  #  [9] "AST"    "AWSST"  "AWST"   "BT"     "CADT"   "CAST"   "CCT"    "CDT"
  # [17] "CET"    "CETDST" "CST"    "DNT"    "DST"    "EASST"  "EAST"   "EDT"
  # [25] "EET"    "EETDST" "EST"    "FST"    "FWT"    "GST"    "HDT"    "HST"
  # [33] "IDLE"   "IDLW"   "IST"    "IT"     "JST"    "JT"     "KST"    "LIGT"
  # [41] "MDT"    "MEST"   "MET"    "METDST" "MEWT"   "MEZ"    "MST"    "MT"
  # [49] "NDT"    "NFT"    "NOR"    "NST"    "NZDT"   "NZST"   "NZT"    "PDT"
  # [57] "PST"    "SADT"   "SAT"    "SET"    "SST"    "SWT"    "UTC"    "WADT"
  # [65] "WAST"   "WAT"    "WDT"    "WET"    "WETDST" "WST"    "ZP-11"  "ZP-2"
  # [73] "ZP-3"   "ZP11"   "ZP4"    "ZP5"    "ZP6"
```


## Additional Notes on Package Installation from Sources

Attention to which TAR (unzipping software) is used to unpack compressed files (inflate the repository) is needed for some Windows operating system users. For example, on some Windows machines with Esri ArcGIS software installed, the `tar.exe` distributed with ArcGIS will automatically run, but that `tar.exe` does not provide for zip inflation. The error message will look like this:
```{r}
  C:\ArcGIS\gbin\tar.exe: Cannot use compressed or remote archives
  C:\ArcGIS\gbin\tar.exe: Error is not recoverable: exiting now
```
The easiest fix is to specify use of the `TAR="internal"` built into _R_ through the `Sys.setenv(TAR="internal")` command as shown and then repeat the remote package installation process.

Testing indicates that downloading other compressed archives, such as `utc2nwislocal-v1.0.0.zip`, does not always work across platforms tested (MacOS and Windows platforms). General attention to the `.tar.gz` format is recommended. Additional guidance on installation from sources (Windows platforms) can be found in the [file](https://code.usgs.gov/water/utc2nwislocal/blob/master/inst/INSTALL_HELP.md) `./inst/INSTALL_HELP.md` as well as in the **FURTHER DETAILS** section below (non-Windows platforms).


# REPOSITORY CONTENTS

The following sections describe directories and most files found at the top-level of the **utc2nwislocal** repository. Some of the material is required for this repository to also be an _R_ package, whereas other material is for structured presentation of this repository to the general public.

## Top-Level Directories

1. The `./inst/` directory is a standard naming convention following _R_ packaging and
therein, it holds material that will be placed into the installation tree of the package but strictly does not contain the code or documentation of the package itself. The `./inst/www/` directory contains graphic material to enhance the home page of the package. The `./inst/doc/` directory is very important because it contains the steps used to build the NWIS time-zone tables that are used by the installed package. More details are provided in `./inst/doc/README.md`. The `./.Rbuildignore` file does not emplace the `./inst/www/` at package installation.

3. The `./man` directory standard R-documentation formatted files (`.Rd`) that are needed for CRAN-compliant package checking, installation, and user manual building.

4. The `./R` directory contains the _R_ source code. There need not be a one-to-one correspondence in file counts between `./R` and `./man`. The `./R/utc2nwislocal.R` contains all of the package functionality source code. The `./R/zzz.R` is a hook to define a message to be shown on the _R_ console when the package is imported (`library(utc2nwislocal)`). There is an _R_ binary file (`sysdata.rda`) that holds the "system data" of the package, which are the NWIS time-zone codes and their respective UTC offsets. (See documentation in `./inst/doc/` as to how this system data file was created.)

## Documentation Files not Installed

5. The `CONTRIBUTING.md` file is an expected standard file to have in a repository
and describes that the repository is not particularly open to inclusion of new material
from others than the authors and their immediate colleagues. The `./.Rbuildignore` file does not emplace the file at package installation.

6. The `DISCLAIMER.md` file provides a standard U.S. Geological Survey disclaimer of
software. The `./.Rbuildignore` file does not emplace the file at package installation.

7. The `LICENSE.md` is a standard file concerning the licensing details of this package. The `./.Rbuildignore` file does not emplace the file at package installation.

8. The `SUMMARY.txt` file is a short abstract concerning the repository itself. The authors have a need, as part of the review and publication process, to report a formal abstract on the information product, and this summary serves that purpose. The `./.Rbuildignore` file does not emplace the file at package installation.

## Required Files for a Source Code Repository to be an _R_ Package

9. The `DESCRIPTION` is a required _R_ package description of the package declaring the basic information, required dependencies, need for compiling, and other details.

10. The `NAMESPACE` is a required declaration of the imports that the package requires from other _R_ package along with the declaration of the functions that the **utc2nwislocal** package will export into the user's session with the `library(utc2nwislocal)` command.

11. The `NEWS` is an author-led record of release notes and other related topics to the repository's lifespan.


# REFERENCES

R Development Core Team, 2020, R—A language and environment for statistical computing, R Foundation for Statistical Computing, Vienna, Austria, version 3.6.3, accessed on March 10, 2020, at https://www.R-project.org.

U.S. Geological Survey, 2019, USGS water data for the Nation: U.S. Geological Survey National Water Information System database, accessed August 9, 2019, at https://doi.org/10.5066/F7P55KJN.
