\encoding{utf8}
\name{utc_offset_hours2nwislocal}
\alias{utc_offset_hours2nwislocal}
\title{ Convert a Offset in Hours from UTC to NWIS Local Time Zone }
\description{
Convert an offset in hours from Coordinated Universal Time (UTC) to a U.S. Geological Survey National Water Information System (NWIS) (U.S. Geological Survey, 2019) time-zone code. The NWIS time-zone codes can be found at \href{https://help.waterdata.usgs.gov/code/tz_query?fmt=html}{NWIS Time Zones}  (accessed on October 22, 2019) and see file \code{./inst/doc/README.md} in the \pkg{utc2nwislocal} sources for more details.
}
\usage{
utc_offset_hours2nwislocal(hrs, split=FALSE, trace=FALSE)
}
\arguments{
  \item{hrs}{A vector of NWIS time-zone codes (such as \code{lev_tz_cd}), and \code{NA} values are assumed to be in UTC with offset of zero;}
  \item{split}{A logical triggering a \code{unlist(strsplit())} on the time-zone codes (see \bold{Examples}); and}
  \item{trace}{A logical triggering a \code{message()} where the user can see the looping through the time-zone codes.}
}
\value{
One or more time-zone codes matching the \code{hrs} (if any) as affected by the \code{split} argument. The string \code{" and "} is inserted between the time-zone codes if \code{split=FALSE}; otherwise, a vector of the time-zone-codes results. Any time zone that does not exist in the lookup table (the hidden environment [hash table] \code{.NWIStzUTC$TimeZone_Offset}), is set to \code{NA} (see \bold{Examples}).
}
\author{ W.H. Asquith}
\references{
U.S. Geological Survey, 2019, USGS water data for the Nation: U.S. Geological Survey National Water Information System database, accessed August 9, 2019, at https://doi.org/10.5066/F7P55KJN.
}
\seealso{\code{\link{nwislocal2utc_offset_hours}}}
\examples{
utc_offset_hours2nwislocal("+02:00", split=FALSE)
# [1] "CETDST and EET and FWT and IST and MEST and METDST and SST"

utc_offset_hours2nwislocal("+02:00", split=TRUE)
# [1] "CETDST" "EET"    "FWT"    "IST"    "MEST"   "METDST" "SST"

utc_offset_hours2nwislocal( "+2:00", split=FALSE) # must have proper syntax
# [1] NA
}
