## David Ferguson 7/17/2015

## For the given state, return the nth ranked hospital

rankhospital <- function(state, outcome, num = "best") {

	## Read outcome data (type: "heart attack", "heart failure", or "pneumonia")

		outcome_data <- read.csv("data/outcome-of-care-measures.csv",
									colClasses = "character")

	## Validate state and outcome, designate outcome column, filter data by state

		## Column 11: 30-Day Heart Attack Mortality
		## Column 17: 30-Day Heart Failure Mortality
		## Column 23: 30-Day Pneumonia Mortality
		     if( outcome == "heart attack"  )	outcome_col <- 11
		else if( outcome == "heart failure" )	outcome_col <- 17
		else if( outcome == "pneumonia"     )	outcome_col <- 23
		else stop("invalid outcome")

		if( !is.character(state) || 
				nrow( outcome_data[ outcome_data$State == state, ] ) <= 1 ){
			stop("invalid state")
		}

		## Convert outcome column to numeric values
  		suppressWarnings(
  			outcome_data[,outcome_col] <- as.numeric( outcome_data[,outcome_col] )
  		) ## Ignore warning about NAs

		## Filter data by state, remove rows with NA mortality rate
			outcome_data <- outcome_data[ outcome_data$State == state, ]
			outcome_data <- outcome_data[ !is.na(outcome_data[,outcome_col]), ]

	## Validate num
			 if( num == "best" ) num <- 1
		else if( num == "worst") num <- nrow( outcome_data )
		else if( num > nrow( outcome_data ) ) return( NA )
		else if( !is.numeric(num) || num < 1 ) stop("invalid num")

	## Return hospital name in that state with nth best ranked 30-day death rate
		rankedHospitals <- outcome_data[ order( outcome_data[,outcome_col],
												  outcome_data$Hospital.Name ), ]
		nthRankedHospital <- rankedHospitals[ num, "Hospital.Name" ]

		return( nthRankedHospital )

}