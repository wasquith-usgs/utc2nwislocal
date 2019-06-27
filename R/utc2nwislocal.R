"utc2nwislocal" <-
function(dt, tz, acy=NA, no.ending.ws=FALSE,
         addat=FALSE, nosec=FALSE, pad=TRUE, secpad=FALSE, tzpad=FALSE) {
  tz  <- as.character(tz)
  acy <- as.character(acy)
  n <- length(dt); if(n  == 0) return(dt)

  if(length(tz)  == 1) tz  <- rep( tz[1], n)
  if(length(acy) == 1) acy <- rep(acy[1], n)

  if(length(tz) != length(dt)) {
     warning("length of time zone not equal to length of UTC date-time, ",
             "assuming UTC and moving on")
     tz <- rep("UTC", length(dt))
  }
  if(length(dt) != length(acy)) {
     warning("length of a date-time in UTC not equal to length of the ",
             "date accuracy (precision)")
     acy <- rep(NA, length(dt))
  }
  acy[is.na(acy)] <- "s"; tz[is.na(tz)] <- "UTC" # two defaults
  tz <- gsub("\\s+", "", tz) # strip out all spaces

  at <- ifelse(addat, "@", " ")
  frmtY  <-        "%Y"
  frmtM  <-        "%Y-%m"
  frmtD  <-        "%Y-%m-%d"
  frmth  <- paste0("%Y-%m-%d",at,"%H"      )
  frmtm  <- paste0("%Y-%m-%d",at,"%H:%M"   )
  frmtsa <- paste0("%Y-%m-%d",at,"%H:%M"   )
  frmtsb <- paste0("%Y-%m-%d",at,"%H:%M:%S")

  # This sets up the removal of a trailing time zone in presence of no time
  tzt <- tz; tzt[acy == "Y" | acy == "M" | acy == "D"] <- "XXXXX"
  if(tzpad) tzt <- format(tzt, width=5)

  sapply(1:length(dt), function(i) {
      if(is.na(dt[i])) return(NA)
      off <- NULL
      if(tzt[i] != "XXXXX") {
         try(off <- get(tz[i], envir=.NWIStzUTC$TimeZone_Offset_seconds), silent=TRUE)
         if(is.null(off)) stop("fatal: '", off, "' is an unrecognized NWIS TZ code")
      } else {
         off <- 0
      }
      val <- dt[i] + off
      if(     acy[i] == "Y") { frmt <- frmtY }
      else if(acy[i] == "M") { frmt <- frmtM }
      else if(acy[i] == "D") { frmt <- frmtD }
      else if(acy[i] == "h") { frmt <- frmth }
      else if(acy[i] == "m") { frmt <- frmtm }
      else if(acy[i] == "s") { frmt <- ifelse(nosec, frmtsa, frmtsb) }
      else { stop("should not be here in logic, bad accuracy value") }
      str <- format(val, frmt, usetz=FALSE)
      if(pad) {
         str <- ifelse(secpad, format(str, width=19), format(str, width=16))
      }
      str <- ifelse(tzt[i] == "XXXXX", paste0(str,"      "    ),
                                       paste0(str," ", tzt[i]))
      if(no.ending.ws) str <- gsub("\\s+$", "", str)
      return(str) })
}

"nwislocal2utc_offset_seconds" <- function(tz) {
  off <- sapply(tz, function(t) { ss <- NULL
          if(is.na(t)) return(0)
	         try(ss <- get(t, .NWIStzUTC$TimeZone_Offset_seconds), silent=TRUE)
          if(is.null(ss)) return(NA)
          return(ss) })
  names(off) <- NULL
  return(off)
}

"nwislocal2utc_offset_hours" <- function(tz) {
  off <- sapply(tz, function(t) { hrss <- NULL
          if(is.na(t)) return("00:00")
	         try(hrss <- get(t, .NWIStzUTC$TimeZone_Offset), silent=TRUE)
          if(is.null(hrss)) return(NA)
          return(hrss) })
  names(off) <- NULL
  off <- as.character(off)
  off <- strsplit(off, ":")
  sapply(1:length(off), function(t) { h <- as.numeric(off[[t]])
                                      if(is.na(h[1])) return(NA)
                                      h[1] + h[2]/60 })
}

