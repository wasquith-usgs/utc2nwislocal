\encoding{utf8}
\name{utc2nwislocal}
\alias{utc2nwislocal}
\title{ Convert UTC Date-Time to NWIS Local Date-Time }
\description{
Convert Coordinated Universal Time (UTC) \code{base::as.POSIXct()} date-time values into character-string representations for time zones. The UTC offset for individual time zones are determined from the time-zone codes recognized by the U.S. Geological Survey National Water Information System (NWIS) (U.S. Geological Survey, 2019) (see \bold{Note}). The time zones are tracked in a separate database slot than the UTC date-time.

The justification for this package is that the time-zone codes are not standard to the \code{OlsonNames()} within base \R, but the NWIS names are an ANSI SQL/92 time-zone offset string. American National Standards Institute (ANSI) SQL/92 was the third revision of the Structured Query Language (SQL) database query language. NWIS stores date-times exclusively in UTC, and certain data retrievals can be (purposefully) kept in UTC, though commonly NWIS switches to the users local or the USGS data collection site local time zone in output.

For some data operations external to NWIS, it is useful to retain UTC convention for the core date-time information and convert to local time on character-string output. Further, NWIS also retains a date-accuracy code, which is actively used to truncate character-string output of date-time values. The \code{utc2nwislocal} function as a result relies on three separate parts that are the first three arguments. The basis of this function is to add respectively UTC offsets (in seconds) to the UTC \code{as.POSIXct} date-times and convert the results into character strings.

\bold{Warning: The function for basic speed intents does not check that an UTC is assigned to the first argument \code{dt}.}

The core operation of this function for the \eqn{i}th value is to add or subtract the number of seconds from the UTC:
\preformatted{
  off <- NULL # reset for the try(), which traps unknown codes
  try(off <- get(tz[i], envir=.NWIStzUTC$TimeZone_Offset_seconds), silent=TRUE)
  if(is.null(off)) stop("fatal: ", off, " is an unrecognized NWIS TZ code")
  val <- dt[i] + off # the addition of seconds to UTC \code{as.POSIXct} date-time
}
and really the rest of the logic in the function is error trapping, adding optional features, and support for vectorization.
}
\usage{
utc2nwislocal(dt, tz, acy=NA, no.ending.ws=FALSE,
              addat=FALSE, nosec=FALSE, pad=TRUE, secpad=FALSE, tzpad=FALSE)
}
\arguments{
  \item{dt}{A vector of \code{as.POSIXct} or similar date-time stamp in UTC in which seconds can be subtracted or added in order to change the date-time stamp. Also \code{NA} values for \code{dt} are returned as \code{NA};}
  \item{tz}{A vector of NWIS time-zone codes (such as \code{lev_tz_cd}) and \code{NA}s at which are assumed to be in UTC; thus it is the users responsibility to deliver UTC. This argument can be a factor, but internally, it is immediately flipped to a character representation. This argument also can be of length one, which will then be repeated to the length of \code{dt} internally;}
  \item{acy}{The NWIS date-time accuracy code (such as \code{lev_dt_acy_cd}), which in implementation here is optional. This argument can be a factor, but internally, it is immediately flipped to a character representation. The \code{NA} values internally trigger \emph{to-the-second} accuracy condition (though NWIS does not explicitly recognize an \dQuote{s}econd condition \emph{per se} because that is the default resolution of the database) and the entire date-time stamp of whatever accuracy held in \code{dt} is returned with the UTC offset applied. This argument also can be of length one, which will then be repeated to the length of \code{dt} internally;}
  \item{no.ending.ws}{A logical to strip trailing whitespace from the end of the converted values. This is provided as switch to superceed the results of the various default right-padding styles;}
  \item{addat}{A logical to trigger whether the \dQuote{at} character is inserted instead of a space between the date and time component;}
  \item{nosec}{A logical to override the \code{acy="s"} values by truncating the seconds out. This might be a more useful option that at first seen---consider that for vast majority of USGS datasets that seconds are simply \code{":00"} a consumer of this function might decide the truncate those to avoid unneeded character inflation in the returned string and subsequent impact on potential output files;}
  \item{pad}{A logical to right-side pad a date-time stamp to 19 or 16 characters wide \emph{before} the time-zone code is appended if it makes sense for the accuracy (codes \eqn{\in} \code{Y}, \code{M}, \code{D}, \code{h}, and \code{m} but not \code{s}). This argument is intended to help the human eye more rapidly discern information from a wide variation in potential date-time stamps in output (see \bold{Examples});}
  \item{secpad}{A logical controlling whether the date-time padding on the right-side is 19 (\code{secpad=TRUE}) or 16 (\code{secpad=FALSE}), and this option makes sense really only for \code{acy="m"}; and}
  \item{tzpad}{A logical controlling whether the time-zone stamp is right-padded to 5 characters.}
}
\value{
A character vector of converted date and times from UTC to the time zones requested. The date-time stamp will be right-padded 16 or 19 characters wide, and the time-zone code is right-padded to 5 characters or not at all. This padding can be stripped by the \code{no.ending.ws} argument.
}
\note{
A list of the NWIS time-zone codes can be found at \href{https://help.waterdata.usgs.gov/code/tz_query?fmt=html}{NWIS Time Zones}  (accessed on October 22, 2019) and the date-time accuracy codes can be found at
\href{https://help.waterdata.usgs.gov/code/water_level_dtacy_cd_query?fmt=html}{NWIS Time Accuracy Codes} (accessed on October 22, 2019). The conversion of time-zone code to UTC offset is made by tabular lookup. The \code{sysdata.rda} that comes with this package contains the \code{environment} named \code{.NWIStzUTC}. Within this \code{environment} are three other environments titled \cr
\code{TimeZone_Names},\cr
\code{TimeZone_Offset}, and \cr
\code{TimeZone_Offset_seconds}.\cr
The \code{.NWIStzUTC} and these other three are not exported by the \pkg{utc2nwislocal} package but they can be accessed through \dQuote{triple-colon insistance.} The following code shows access to these three tables:
\preformatted{
  ls(NWIStzUTC:::.NWIStzUTC) # See the three table names
    # "TimeZone_Names"   "TimeZone_Offset"   "TimeZone_Offset_seconds"

    # The creation of a vector of all time-zone codes
  all_tz_codes <- ls(NWIStzUTC:::.NWIStzUTC$TimeZone_Names)

    # Demonstration of access for a given code.
  NWIStzUTC:::.NWIStzUTC$TimeZone_Names$IDLE
    #   "International Date Line, East"
  NWIStzUTC:::.NWIStzUTC$TimeZone_Offset$IDLE
    # "+12:00"
  NWIStzUTC:::.NWIStzUTC$TimeZone_Offset_seconds$IDLE
    #  43200
}
The code, which was used the create the \code{sysdata.rda}, is located in file \code{buildSYSDATA(R).txt} that is located in the \code{inst/doc} subdirectory of this package's sources. NWIS appears to use a 5 (five) character wide (max) time-zone code convention. It is important to state that the table-lookup herein is based on white space being stripped from time-zone code. All spaces are internally stripped from the \code{tz} before processing commences---the pad is possible to return through the \code{tzpad} argument.
}
\author{ W.H. Asquith}
\references{
U.S. Geological Survey, 2019, USGS water data for the Nation: U.S. Geological Survey National Water Information System database, accessed August 9, 2019, at https://doi.org/10.5066/F7P55KJN.
}
\seealso{\code{\link{nwislocal2utc_offset_hours}}, \code{\link{nwislocal2utc_offset_seconds}}}
\examples{
# Australia Eastern Standard Time is +10:00 to UTC and NWIS code == "AESST"
# EST, CDT, and PST are obviously American time zones.

dt_va <- as.POSIXct(c("2012-10-06 12:00:00", "2016-12-17 16:00:00",
                      "2017-07-26 06:15:00", "2017-07-26 06:15:30"), tz="UTC")

# Let us look only at impact on the Australian "data point."
utc2nwislocal(dt_va, tz="AESST")[1]      # tz vectored to length of dt_va
  # "2012-10-06 23:00:00 AESST"
utc2nwislocal(dt_va, tz="AESST", "h")[1] # m means accurate down to the minute
  # "2012-10-06 23     AESST"
utc2nwislocal(dt_va, tz="AESST", "s", nosec=TRUE)[1]
  # "2012-10-06 23:00  AESST"
utc2nwislocal(dt_va, tz="AESST", "M")[1]
  # "2012-10                "
utc2nwislocal(dt_va, tz="AESST", "Y")[1]
  # "2012                   "

utc2nwislocal(as.POSIXct("2011-03-14 15:30:00"), tz="MDT", "m", secpad=TRUE)
  # "2011-03-14 09:30    MDT"
utc2nwislocal(as.POSIXct("2011-03-14 15:30:00"), tz="MDT", "m", secpad=FALSE)
  # "2011-03-14 09:30 MDT"

tzs <- c("AESST", "EST", "CDT", "PST")
utc2nwislocal(dt_va, tz=tzs)      # tz vectored to length of dt_va
utc2nwislocal(dt_va, tz=tzs, "h") # m means accurate down to the minute
utc2nwislocal(dt_va, tz=tzs, "s", nosec=TRUE)
utc2nwislocal(dt_va, tz=tzs, c("D","h","m","s"))
}
