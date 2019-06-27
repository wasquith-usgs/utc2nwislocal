\encoding{utf8}
\name{nwislocal2utc_offset_seconds}
\alias{utc2nwislocal}
\title{ Convert a NWIS Local Time Zone to Offset in Seconds from UTC }
\description{
Convert an NWIS time zone code to the offset in seconds from UTC.
}
\usage{
nwislocal2utc_offset_seconds(tz)
}
\arguments{
  \item{tz}{A vector of NWIS time-zone codes (such as \code{lev_tz_cd}) and \code{NA}s at which are assumed to be in UTC with offset of zero;}
}
\value{
The UTC offsets in seconds. Any time zone that does not exist in the lookup table, is returned as an \code{NA}.
}
\author{ W.H. Asquith}
\seealso{\code{\link{utc2nwislocal}}}
\examples{
nwislocal2utc_offset_seconds(c("PST","PDT","the author",NA,"CDT"))
}
