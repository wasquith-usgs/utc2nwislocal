\encoding{utf8}
\name{nwislocal2utc_offset_hours}
\alias{nwislocal2utc_offset_hours}
\title{ Convert a NWIS Local Time Zone to Offset in Hours from UTC }
\description{
Convert an U.S. Geological Survey National Water Information System (NWIS) (U.S. Geological Survey, 2019) time-zone code to the offset in hours from Coordinated Universal Time (UTC). The NWIS time-zone codes can be found at \href{https://help.waterdata.usgs.gov/code/tz_query?fmt=html}{NWIS Time Zones}  (accessed on October 22, 2019) and see file \code{./inst/doc/README.md} in the \pkg{utc2nwislocal} sources for more details.
}
\usage{
nwislocal2utc_offset_hours(tz)
}
\arguments{
  \item{tz}{A vector of NWIS time-zone codes (such as \code{lev_tz_cd}), and \code{NA} values are assumed to be in UTC with offset of zero;}
}
\value{
The UTC offsets in hours. Any time zone that does not exist in the lookup table (hidden environment [hash table] \code{.NWIStzUTC$TimeZone_Offset}), is set to \code{NA}.
}
\author{ W.H. Asquith}
\references{
U.S. Geological Survey, 2019, USGS water data for the Nation: U.S. Geological Survey National Water Information System database, accessed August 9, 2019, at https://doi.org/10.5066/F7P55KJN.
}
\seealso{\code{\link{utc2nwislocal}}, \code{\link{nwislocal2utc_offset_seconds}}}
\examples{
nwislocal2utc_offset_hours(c("PST","PDT","the author",NA,"CDT"))

# Force inspection of lookup table contents, using triple colon notation:
ls(utc2nwislocal:::.NWIStzUTC$TimeZone_Offset) # keys are time-zone codes
}
